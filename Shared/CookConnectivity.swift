import Foundation
import Combine
import WatchConnectivity

final class CookConnectivity: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = CookConnectivity()

    @Published private(set) var isReachable = false

#if os(iOS)
    var onRecordReceived: ((CookRecord) -> Void)?
#else
    var onRecipeRequested: ((String, UUID?) -> Void)?
    var onPreferencesReceived: ((CookPreferences) -> Void)?
#endif

    private override init() {
        super.init()
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }

#if os(iOS)
    func start(recipeID: String, sessionID: UUID = UUID(), preferences: CookPreferences) {
        guard WCSession.isSupported() else { return }
        var context = encodedPreferences(preferences)
        context["activeRecipeID"] = recipeID
        context["sessionID"] = sessionID.uuidString
        try? WCSession.default.updateApplicationContext(context)
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(context, replyHandler: nil)
        }
    }

    func sync(preferences: CookPreferences) {
        guard WCSession.isSupported() else { return }
        var context = WCSession.default.applicationContext
        encodedPreferences(preferences).forEach { context[$0.key] = $0.value }
        try? WCSession.default.updateApplicationContext(context)
    }
#else
    func send(record: CookRecord) {
        guard WCSession.isSupported(), let data = try? JSONEncoder().encode(record) else { return }
        WCSession.default.transferUserInfo(["cookRecord": data])
    }
#endif

    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: (any Error)?
    ) {
        updateReachability(session)
#if os(iOS)
        if activationState == .activated {
            Task { @MainActor in
                self.sync(preferences: CookPreferencesStore.shared.preferences)
            }
        }
#else
        if activationState == .activated {
            apply(context: session.receivedApplicationContext)
        }
#endif
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        updateReachability(session)
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
#if os(watchOS)
        apply(context: message)
#endif
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
#if os(watchOS)
        apply(context: applicationContext)
#endif
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any]) {
#if os(iOS)
        guard let data = userInfo["cookRecord"] as? Data,
              let record = try? JSONDecoder().decode(CookRecord.self, from: data) else { return }
        DispatchQueue.main.async { self.onRecordReceived?(record) }
#endif
    }

#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
#else
    private func apply(context: [String: Any]) {
        if let preferences = decodedPreferences(context) {
            DispatchQueue.main.async { self.onPreferencesReceived?(preferences) }
        }
        guard let recipeID = context["activeRecipeID"] as? String else { return }
        let sessionID = (context["sessionID"] as? String).flatMap(UUID.init(uuidString:))
        DispatchQueue.main.async { self.onRecipeRequested?(recipeID, sessionID) }
    }
#endif

    private func updateReachability(_ session: WCSession) {
        DispatchQueue.main.async { self.isReachable = session.isReachable }
    }

    private func encodedPreferences(_ preferences: CookPreferences) -> [String: Any] {
        [
            "interfaceLanguage": preferences.interfaceLanguage.rawValue,
            "coachLanguage": preferences.coachLanguage.rawValue,
            "unitSystem": preferences.unitSystem.rawValue
        ]
    }

    private func decodedPreferences(_ context: [String: Any]) -> CookPreferences? {
        guard let languageRaw = context["interfaceLanguage"] as? String,
              let language = AppLanguage(rawValue: languageRaw),
              let coachRaw = context["coachLanguage"] as? String,
              let coach = CoachLanguage(rawValue: coachRaw),
              let unitsRaw = context["unitSystem"] as? String,
              let units = UnitSystem(rawValue: unitsRaw) else { return nil }
        return CookPreferences(interfaceLanguage: language, coachLanguage: coach, unitSystem: units)
    }
}
