import Foundation
import Combine

enum TapCookDefaults {
    static let interfaceLanguage = "tapcook.interface-language"
    static let coachLanguage = "tapcook.coach-language"
    static let unitSystem = "tapcook.unit-system"
}

enum AppLanguage: String, CaseIterable, Identifiable, Codable, Sendable {
    case system
    case english = "en"
    case simplifiedChinese = "zh-Hans"

    var id: String { rawValue }

    var nativeName: String {
        switch self {
        case .system: L10n.string("language.system")
        case .english: "English"
        case .simplifiedChinese: "简体中文"
        }
    }

    var resolved: AppLanguage {
        guard self == .system else { return self }
        let preferred = Locale.preferredLanguages.first?.lowercased() ?? "en"
        return preferred.hasPrefix("zh") ? .simplifiedChinese : .english
    }

    var locale: Locale { Locale(identifier: resolved.rawValue) }
}

enum CoachLanguage: String, CaseIterable, Identifiable, Codable, Sendable {
    case english = "en-US"
    case simplifiedChinese = "zh-CN"

    var id: String { rawValue }
    var nativeName: String { self == .english ? "English" : "中文" }
    var contentLanguage: AppLanguage { self == .english ? .english : .simplifiedChinese }
}

enum UnitSystem: String, CaseIterable, Identifiable, Codable, Sendable {
    case metric
    case us

    var id: String { rawValue }
    var displayName: String { L10n.string(self == .metric ? "units.metric" : "units.us") }
}

struct CookPreferences: Codable, Equatable, Hashable, Sendable {
    var interfaceLanguage: AppLanguage = .english
    var coachLanguage: CoachLanguage = .english
    var unitSystem: UnitSystem = .metric
}

@MainActor
final class CookPreferencesStore: ObservableObject {
    static let shared = CookPreferencesStore()

    @Published private(set) var preferences: CookPreferences

    private init() {
        let defaults = UserDefaults.standard
        let interfaceLanguage = defaults.string(forKey: TapCookDefaults.interfaceLanguage)
            .flatMap(AppLanguage.init(rawValue:)) ?? .english
        let defaultCoach: CoachLanguage = interfaceLanguage.resolved == .simplifiedChinese ? .simplifiedChinese : .english
        let coachLanguage = defaults.string(forKey: TapCookDefaults.coachLanguage)
            .flatMap(CoachLanguage.init(rawValue:)) ?? defaultCoach
        let unitSystem = defaults.string(forKey: TapCookDefaults.unitSystem)
            .flatMap(UnitSystem.init(rawValue:)) ?? .metric
        preferences = CookPreferences(
            interfaceLanguage: interfaceLanguage,
            coachLanguage: coachLanguage,
            unitSystem: unitSystem
        )
    }

    var interfaceLanguage: AppLanguage { preferences.interfaceLanguage }
    var coachLanguage: CoachLanguage { preferences.coachLanguage }
    var unitSystem: UnitSystem { preferences.unitSystem }

    func setInterfaceLanguage(_ language: AppLanguage, synchronize: Bool = true) {
        preferences.interfaceLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: TapCookDefaults.interfaceLanguage)
        if synchronize { synchronizePreferences() }
    }

    func setCoachLanguage(_ language: CoachLanguage, synchronize: Bool = true) {
        preferences.coachLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: TapCookDefaults.coachLanguage)
        if synchronize { synchronizePreferences() }
    }

    func setUnitSystem(_ units: UnitSystem, synchronize: Bool = true) {
        preferences.unitSystem = units
        UserDefaults.standard.set(units.rawValue, forKey: TapCookDefaults.unitSystem)
        if synchronize { synchronizePreferences() }
    }

    func apply(_ incoming: CookPreferences) {
        preferences = incoming
        UserDefaults.standard.set(incoming.interfaceLanguage.rawValue, forKey: TapCookDefaults.interfaceLanguage)
        UserDefaults.standard.set(incoming.coachLanguage.rawValue, forKey: TapCookDefaults.coachLanguage)
        UserDefaults.standard.set(incoming.unitSystem.rawValue, forKey: TapCookDefaults.unitSystem)
    }

    private func synchronizePreferences() {
#if os(iOS)
        CookConnectivity.shared.sync(preferences: preferences)
#endif
    }
}

enum L10n {
    static func string(_ key: String) -> String {
        let stored = UserDefaults.standard.string(forKey: TapCookDefaults.interfaceLanguage)
        let selected = stored.flatMap(AppLanguage.init(rawValue:)) ?? .english
        let language = selected.resolved
        let bundle = localizedBundle(for: language)
        let value = bundle.localizedString(forKey: key, value: key, table: nil)
        if value != key || language == .english { return value }
        return localizedBundle(for: .english).localizedString(forKey: key, value: key, table: nil)
    }

    static func format(_ key: String, _ arguments: CVarArg...) -> String {
        let stored = UserDefaults.standard.string(forKey: TapCookDefaults.interfaceLanguage)
        let selected = stored.flatMap(AppLanguage.init(rawValue:)) ?? .english
        return String(format: string(key), locale: selected.locale, arguments: arguments)
    }

    private static func localizedBundle(for language: AppLanguage) -> Bundle {
        guard let path = Bundle.main.path(forResource: language.resolved.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else { return .main }
        return bundle
    }
}
