import Foundation
import Combine
import WatchKit

@MainActor
final class CookingSessionController: ObservableObject {
    static let shared = CookingSessionController()

    @Published private(set) var recipe: Recipe?
    @Published private(set) var stepIndex = 0
    @Published private(set) var remainingSeconds = 0
    @Published private(set) var isTimerRunning = false
    @Published private(set) var isTimerFinished = false
    @Published private(set) var isCompleted = false

    private static let snapshotKey = "tapcook.active-session"
    private var timer: Timer?
    private var deadline: Date?
    private var startedAt = Date()
    private var sessionID = UUID()

    var currentStep: CookingStep? {
        guard let recipe, recipe.steps.indices.contains(stepIndex) else { return nil }
        return recipe.steps[stepIndex]
    }

    var progress: Double {
        guard let recipe, !recipe.steps.isEmpty else { return 0 }
        return Double(stepIndex + (isCompleted ? 1 : 0)) / Double(recipe.steps.count)
    }

    private init() {
        let connectivity = CookConnectivity.shared
        connectivity.onRecipeRequested = { [weak self] recipeID, sessionID in
            guard let recipe = SampleRecipes.recipe(id: recipeID) else { return }
            self?.start(recipe: recipe, sessionID: sessionID)
        }
        connectivity.onPreferencesReceived = { preferences in
            CookPreferencesStore.shared.apply(preferences)
        }
        restore()
#if DEBUG
        if recipe == nil,
           let demoRecipeID = ProcessInfo.processInfo.environment["TAPCOOK_DEMO_RECIPE"],
           let demoRecipe = SampleRecipes.recipe(id: demoRecipeID) {
            start(recipe: demoRecipe)
            if let rawStep = ProcessInfo.processInfo.environment["TAPCOOK_DEMO_STEP"],
               let demoStep = Int(rawStep),
               demoRecipe.steps.indices.contains(demoStep) {
                stepIndex = demoStep
                enterCurrentStep(announce: false)
            }
        }
#endif
    }

    func start(recipe: Recipe, sessionID: UUID? = nil) {
        timer?.invalidate()
        self.recipe = recipe
        self.sessionID = sessionID ?? UUID()
        startedAt = Date()
        stepIndex = 0
        isCompleted = false
        enterCurrentStep(announce: true)
    }

    func advance() {
        guard let recipe, let currentStep else { return }
        WatchNotificationCoordinator.cancel(stepID: currentStep.id)
        timer?.invalidate()
        timer = nil
        deadline = nil

        if stepIndex >= recipe.steps.count - 1 {
            finish(recipe: recipe)
        } else {
            stepIndex += 1
            enterCurrentStep(announce: true)
        }
    }

    func pauseOrResume() {
        guard currentStep?.durationSeconds != nil, !isTimerFinished else { return }
        if isTimerRunning {
            updateRemainingFromDeadline()
            timer?.invalidate()
            timer = nil
            deadline = nil
            isTimerRunning = false
            if let step = currentStep { WatchNotificationCoordinator.cancel(stepID: step.id) }
            let coach = CookPreferencesStore.shared.coachLanguage
            VoiceCoach.shared.speak(VoicePhrase.timerPaused(coach), language: coach)
        } else {
            beginTimer(seconds: remainingSeconds)
        }
        persist()
    }

    func addThirtySeconds() {
        guard currentStep?.durationSeconds != nil else { return }
        remainingSeconds += 30
        if isTimerRunning {
            deadline = (deadline ?? Date()).addingTimeInterval(30)
            scheduleNotification()
        }
        WKInterfaceDevice.current().play(.click)
        persist()
    }

    func repeatInstruction() {
        guard let step = currentStep else { return }
        let coach = CookPreferencesStore.shared.coachLanguage
        VoiceCoach.shared.speak(step.voicePrompt.value(for: coach), language: coach)
    }

    func leaveCompletedSession() {
        timer?.invalidate()
        VoiceCoach.shared.stop()
        recipe = nil
        isCompleted = false
        stepIndex = 0
        remainingSeconds = 0
        UserDefaults.standard.removeObject(forKey: Self.snapshotKey)
    }

    private func enterCurrentStep(announce: Bool) {
        guard let step = currentStep else { return }
        timer?.invalidate()
        timer = nil
        deadline = nil
        isTimerFinished = false
        remainingSeconds = step.durationSeconds ?? 0

        if announce { repeatInstruction() }
        if let duration = step.durationSeconds { beginTimer(seconds: duration) }
        persist()
    }

    private func beginTimer(seconds: Int) {
#if DEBUG
        let environment = ProcessInfo.processInfo.environment
        if environment["TAPCOOK_SKIP_NOTIFICATIONS"] == nil,
           environment["TAPCOOK_DEMO_STEP"] == nil {
            WatchNotificationCoordinator.requestPermission()
        }
#else
        WatchNotificationCoordinator.requestPermission()
#endif
        guard seconds > 0 else {
            timerDidFinish()
            return
        }
        remainingSeconds = seconds
        deadline = Date().addingTimeInterval(TimeInterval(seconds))
        isTimerRunning = true
        isTimerFinished = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in self?.tick() }
        }
        scheduleNotification()
        persist()
    }

    private func tick() {
        updateRemainingFromDeadline()
        if remainingSeconds <= 0 { timerDidFinish() }
    }

    private func updateRemainingFromDeadline() {
        guard let deadline else { return }
        remainingSeconds = max(0, Int(ceil(deadline.timeIntervalSinceNow)))
    }

    private func timerDidFinish() {
        timer?.invalidate()
        timer = nil
        deadline = nil
        remainingSeconds = 0
        isTimerRunning = false
        isTimerFinished = true
        WKInterfaceDevice.current().play(.notification)
        let coach = CookPreferencesStore.shared.coachLanguage
        VoiceCoach.shared.speak(VoicePhrase.timerDone(coach), language: coach)
        persist()
    }

    private func finish(recipe: Recipe) {
        isCompleted = true
        isTimerRunning = false
        isTimerFinished = false
        remainingSeconds = 0
        WKInterfaceDevice.current().play(.success)
        let elapsed = max(1, Int(Date().timeIntervalSince(startedAt)))
        let record = CookRecord(id: sessionID, recipeID: recipe.id, elapsedSeconds: elapsed)
        CookConnectivity.shared.send(record: record)
        let coach = CookPreferencesStore.shared.coachLanguage
        VoiceCoach.shared.speak(VoicePhrase.completed(coach), language: coach)
        persist()
    }

    private func scheduleNotification() {
        guard let step = currentStep, isTimerRunning, remainingSeconds > 0 else { return }
        WatchNotificationCoordinator.cancel(stepID: step.id)
        WatchNotificationCoordinator.scheduleTimer(
            stepID: step.id,
            seconds: remainingSeconds,
            title: L10n.string("watch.timer.done.title"),
            body: step.title.value(for: CookPreferencesStore.shared.interfaceLanguage.resolved)
        )
    }

    private func persist() {
        guard let recipe else { return }
        let snapshot = Snapshot(
            recipeID: recipe.id,
            stepIndex: stepIndex,
            remainingSeconds: remainingSeconds,
            deadline: deadline,
            isTimerRunning: isTimerRunning,
            isTimerFinished: isTimerFinished,
            isCompleted: isCompleted,
            startedAt: startedAt,
            sessionID: sessionID
        )
        if let data = try? JSONEncoder().encode(snapshot) {
            UserDefaults.standard.set(data, forKey: Self.snapshotKey)
        }
    }

    private func restore() {
        guard let data = UserDefaults.standard.data(forKey: Self.snapshotKey),
              let snapshot = try? JSONDecoder().decode(Snapshot.self, from: data),
              let recipe = SampleRecipes.recipe(id: snapshot.recipeID),
              recipe.steps.indices.contains(snapshot.stepIndex) else { return }

        self.recipe = recipe
        stepIndex = snapshot.stepIndex
        remainingSeconds = snapshot.remainingSeconds
        deadline = snapshot.deadline
        isTimerRunning = snapshot.isTimerRunning
        isTimerFinished = snapshot.isTimerFinished
        isCompleted = snapshot.isCompleted
        startedAt = snapshot.startedAt
        sessionID = snapshot.sessionID

        if isTimerRunning, let deadline {
            remainingSeconds = max(0, Int(ceil(deadline.timeIntervalSinceNow)))
            if remainingSeconds > 0 {
                beginTimer(seconds: remainingSeconds)
            } else {
                timerDidFinish()
            }
        }
    }
}

private struct Snapshot: Codable {
    let recipeID: String
    let stepIndex: Int
    let remainingSeconds: Int
    let deadline: Date?
    let isTimerRunning: Bool
    let isTimerFinished: Bool
    let isCompleted: Bool
    let startedAt: Date
    let sessionID: UUID
}
