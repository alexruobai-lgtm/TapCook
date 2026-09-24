import SwiftUI

struct WatchRootView: View {
    @EnvironmentObject private var controller: CookingSessionController
    @EnvironmentObject private var preferences: CookPreferencesStore

    var body: some View {
        Group {
            if controller.isCompleted, let recipe = controller.recipe {
                WatchCompletedView(recipe: recipe)
            } else if controller.recipe != nil {
                ActiveCookingView()
            } else {
                WatchRecipeLibrary()
            }
        }
        .tint(TapCookTheme.orange)
        .id(preferences.preferences)
    }
}

private struct WatchRecipeLibrary: View {
    @EnvironmentObject private var controller: CookingSessionController
    @EnvironmentObject private var preferences: CookPreferencesStore
    @State private var searchText = ""

    private var language: AppLanguage { preferences.interfaceLanguage.resolved }

    private var filteredRecipes: [Recipe] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return SampleRecipes.all }
        return SampleRecipes.all.filter { recipe in
            [recipe.name.en, recipe.name.zh, recipe.cuisine.en, recipe.cuisine.zh]
                .contains { $0.localizedCaseInsensitiveContains(query) }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text("TAP COOK").font(.caption2.bold()).foregroundStyle(TapCookTheme.orange)
                            Spacer()
                            Button {
                                preferences.setInterfaceLanguage(
                                    preferences.interfaceLanguage.resolved == .english ? .simplifiedChinese : .english
                                )
                            } label: {
                                HStack(spacing: 2) {
                                    Text("EN")
                                        .foregroundStyle(preferences.interfaceLanguage.resolved == .english ? TapCookTheme.orange : .secondary)
                                    Text("/").foregroundStyle(.tertiary)
                                    Text("中文")
                                        .foregroundStyle(preferences.interfaceLanguage.resolved == .simplifiedChinese ? TapCookTheme.orange : .secondary)
                                }
                            }
                            .font(.system(size: 10, weight: .bold))
                            .buttonStyle(.plain)
                            .foregroundStyle(.white)
                        }
                        Text(L10n.string("watch.home.title")).font(.headline)
                        Text(L10n.format("watch.home.subtitle", SampleRecipes.all.count))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(filteredRecipes) { recipe in
                        Button { controller.start(recipe: recipe) } label: {
                            HStack(spacing: 9) {
                                BundleImage.image(
                                    named: "\(recipe.id)-hero",
                                    fallbackNamed: "\(recipe.id)-\(recipe.steps.last?.id ?? "serve")"
                                )
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 36)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(recipe.name.value(for: language))
                                        .font(.caption.bold())
                                        .lineLimit(1)
                                    Text("\(recipe.totalMinutes) \(L10n.string("unit.min")) · \(recipe.steps.count) \(L10n.string("unit.steps"))")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.secondary)
                                }
                                Spacer(minLength: 0)
                                Image(systemName: "chevron.right").font(.caption2)
                            }
                            .padding(8)
                            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)
                    }

                    NavigationLink {
                        WatchSettingsView()
                    } label: {
                        Label(L10n.string("tab.settings"), systemImage: "gearshape.fill")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .containerBackground(for: .navigation) { Color.black }
            .searchable(text: $searchText, prompt: L10n.string("search.recipes"))
        }
    }
}

private struct ActiveCookingView: View {
    @EnvironmentObject private var controller: CookingSessionController
    @EnvironmentObject private var preferences: CookPreferencesStore

    private var language: AppLanguage { preferences.interfaceLanguage.resolved }

    var body: some View {
        if let recipe = controller.recipe, let step = controller.currentStep {
            VStack(spacing: 7) {
                Button { controller.advance() } label: {
                    BundleImage.image(named: "\(recipe.id)-\(step.id)")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: step.durationSeconds == nil ? 122 : 108)
                        .clipped()
                        .overlay {
                        LinearGradient(
                            colors: [.black.opacity(0.04), .black.opacity(0.12), .black.opacity(0.82)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        }
                        .overlay {
                        VStack {
                            HStack {
                                Text(L10n.format("watch.step.progress", controller.stepIndex + 1, recipe.steps.count))
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.black.opacity(0.38), in: Capsule())
                                Spacer()
                                if step.durationSeconds != nil {
                                    Text(Self.clock(controller.remainingSeconds))
                                        .font(.system(size: 31, weight: .heavy, design: .rounded).monospacedDigit())
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            controller.isTimerFinished ? TapCookTheme.green.opacity(0.9) : .black.opacity(0.38),
                                            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        )
                                }
                            }
                            Spacer()
                            HStack(spacing: 7) {
                                Image(systemName: controller.isTimerFinished ? "checkmark.circle.fill" : "hand.tap.fill")
                                Text(controller.isTimerFinished ? L10n.string("watch.action.timer.done") : L10n.string("watch.action.done"))
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.white)
                        }
                        .padding(10)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                        .overlay {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(.white.opacity(0.16), lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)

                HStack(spacing: 9) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(step.title.value(for: language))
                            .font(.headline)
                            .lineLimit(1)
                        if let heat = step.heat {
                            Label(heat.value(for: language), systemImage: "flame.fill")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.orange)
                        }
                    }
                    Spacer()
                    Button { controller.repeatInstruction() } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.caption.bold())
                            .foregroundStyle(TapCookTheme.orange)
                            .frame(width: 32, height: 32)
                            .background(TapCookTheme.orange.opacity(0.16), in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(L10n.string("watch.action.repeat"))
                }

                Text(step.instruction.value(for: language))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(step.durationSeconds == nil ? 2 : 1)

                if step.durationSeconds != nil {
                    timerPanel
                }
            }
        }
    }

    private var timerPanel: some View {
        HStack(spacing: 8) {
            Button { controller.pauseOrResume() } label: {
                Label(
                    L10n.string(controller.isTimerRunning ? "watch.action.pause" : "watch.action.resume"),
                    systemImage: controller.isTimerRunning ? "pause.fill" : "play.fill"
                )
            }
            .buttonStyle(.bordered)
            .disabled(controller.isTimerFinished)
            Button { controller.addThirtySeconds() } label: {
                Text("+30s").font(.caption.bold())
            }
            .buttonStyle(.bordered)
        }
        .controlSize(.mini)
    }

    private static func clock(_ seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

private struct WatchCompletedView: View {
    let recipe: Recipe
    @EnvironmentObject private var controller: CookingSessionController
    @EnvironmentObject private var preferences: CookPreferencesStore

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(TapCookTheme.green)
                Text(L10n.string("watch.complete.title"))
                    .font(.title3.bold())
                Text(recipe.name.value(for: preferences.interfaceLanguage.resolved))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(L10n.string("watch.complete.message"))
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                Button(L10n.string("watch.complete.home")) {
                    controller.leaveCompletedSession()
                }
                .buttonStyle(.borderedProminent)
                .tint(TapCookTheme.orange)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
        }
    }
}

private struct WatchSettingsView: View {
    @EnvironmentObject private var preferences: CookPreferencesStore

    var body: some View {
        List {
            Picker(L10n.string("settings.interface.language"), selection: interfaceLanguage) {
                ForEach(AppLanguage.allCases) { language in Text(language.nativeName).tag(language) }
            }
            Picker(L10n.string("settings.coach.language"), selection: coachLanguage) {
                ForEach(CoachLanguage.allCases) { language in Text(language.nativeName).tag(language) }
            }
        }
        .navigationTitle(L10n.string("tab.settings"))
    }

    private var interfaceLanguage: Binding<AppLanguage> {
        Binding(get: { preferences.interfaceLanguage }, set: { preferences.setInterfaceLanguage($0) })
    }

    private var coachLanguage: Binding<CoachLanguage> {
        Binding(get: { preferences.coachLanguage }, set: { preferences.setCoachLanguage($0) })
    }
}

#Preview {
    WatchRootView()
        .environmentObject(CookingSessionController.shared)
        .environmentObject(CookPreferencesStore.shared)
}
