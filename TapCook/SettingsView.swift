import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var preferences: CookPreferencesStore
    @StateObject private var connectivity = CookConnectivity.shared

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker(L10n.string("settings.interface.language"), selection: interfaceLanguage) {
                        ForEach(AppLanguage.allCases) { language in
                            Text(language.nativeName).tag(language)
                        }
                    }
                    Picker(L10n.string("settings.coach.language"), selection: coachLanguage) {
                        ForEach(CoachLanguage.allCases) { language in
                            Text(language.nativeName).tag(language)
                        }
                    }
                    Picker(L10n.string("settings.units"), selection: units) {
                        ForEach(UnitSystem.allCases) { unit in
                            Text(unit.displayName).tag(unit)
                        }
                    }
                } header: {
                    Text(L10n.string("settings.cooking"))
                } footer: {
                    Text(L10n.string("settings.language.footer"))
                }

                Section(L10n.string("settings.about")) {
                    LabeledContent(L10n.string("settings.version"), value: "1.0")
                    HStack {
                        Label(L10n.string("settings.watch.sync"), systemImage: "applewatch")
                        Spacer()
                        Circle()
                            .fill(connectivity.isReachable ? TapCookTheme.green : .secondary)
                            .frame(width: 8, height: 8)
                        Text(L10n.string(connectivity.isReachable ? "settings.connected" : "settings.ready"))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(L10n.string("settings.title"))
        }
    }

    private var interfaceLanguage: Binding<AppLanguage> {
        Binding(get: { preferences.interfaceLanguage }, set: { preferences.setInterfaceLanguage($0) })
    }

    private var coachLanguage: Binding<CoachLanguage> {
        Binding(get: { preferences.coachLanguage }, set: { preferences.setCoachLanguage($0) })
    }

    private var units: Binding<UnitSystem> {
        Binding(get: { preferences.unitSystem }, set: { preferences.setUnitSystem($0) })
    }
}
