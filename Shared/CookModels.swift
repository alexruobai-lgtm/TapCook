import Foundation

struct LocalizedText: Codable, Hashable, Sendable {
    let en: String
    let zh: String

    func value(for language: AppLanguage) -> String {
        language.resolved == .simplifiedChinese ? zh : en
    }

    func value(for language: CoachLanguage) -> String {
        value(for: language.contentLanguage)
    }
}

enum RecipeDifficulty: String, Codable, Hashable, Sendable {
    case easy
    case medium

    var localizedName: String { L10n.string("difficulty.\(rawValue)") }
}

struct Ingredient: Identifiable, Codable, Hashable, Sendable {
    let id: String
    let name: LocalizedText
    let metricAmount: String
    let usAmount: String
    let substitute: LocalizedText?

    func amount(for units: UnitSystem) -> String { units == .metric ? metricAmount : usAmount }
}

struct CookingStep: Identifiable, Codable, Hashable, Sendable {
    let id: String
    let title: LocalizedText
    let instruction: LocalizedText
    let voicePrompt: LocalizedText
    let durationSeconds: Int?
    let symbol: String
    let heat: LocalizedText?
    let tip: LocalizedText?
}

struct Recipe: Identifiable, Codable, Hashable, Sendable {
    let id: String
    let name: LocalizedText
    let subtitle: LocalizedText
    let cuisine: LocalizedText
    let totalMinutes: Int
    let difficulty: RecipeDifficulty
    let symbol: String
    let colorHex: String
    let ingredients: [Ingredient]
    let steps: [CookingStep]
}

struct CookRecord: Identifiable, Codable, Hashable, Sendable {
    let id: UUID
    let recipeID: String
    let completedAt: Date
    let elapsedSeconds: Int
    var rating: Int?
    var note: String

    init(
        id: UUID = UUID(),
        recipeID: String,
        completedAt: Date = Date(),
        elapsedSeconds: Int,
        rating: Int? = nil,
        note: String = ""
    ) {
        self.id = id
        self.recipeID = recipeID
        self.completedAt = completedAt
        self.elapsedSeconds = elapsedSeconds
        self.rating = rating
        self.note = note
    }

    var recipe: Recipe? { SampleRecipes.recipe(id: recipeID) }
}

extension Recipe {
    func name(in language: AppLanguage) -> String { name.value(for: language) }
    func subtitle(in language: AppLanguage) -> String { subtitle.value(for: language) }
}
