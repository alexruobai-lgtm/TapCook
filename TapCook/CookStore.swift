import Foundation
import Combine

@MainActor
final class CookStore: ObservableObject {
    static let shared = CookStore()
    private static let recordsKey = "tapcook.cook-records"

    @Published private(set) var records: [CookRecord] = []
    @Published private(set) var lastSentRecipeID: String?

    private init() {
        load()
#if DEBUG
        if ProcessInfo.processInfo.environment["TAPCOOK_DEMO_STATS"] == "1", records.isEmpty {
            let calendar = Calendar.current
            records = [
                CookRecord(recipeID: "egg-fried-rice", completedAt: Date(), elapsedSeconds: 1_080, rating: 5),
                CookRecord(recipeID: "garlic-broccoli", completedAt: calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date(), elapsedSeconds: 840, rating: 4),
                CookRecord(recipeID: "tomato-eggs", completedAt: calendar.date(byAdding: .day, value: -2, to: Date()) ?? Date(), elapsedSeconds: 900, rating: 5),
                CookRecord(recipeID: "mapo-tofu", completedAt: calendar.date(byAdding: .day, value: -4, to: Date()) ?? Date(), elapsedSeconds: 1_320, rating: 4)
            ]
        }
#endif
        CookConnectivity.shared.onRecordReceived = { [weak self] record in
            self?.add(record)
        }
    }

    func sendToWatch(_ recipe: Recipe, preferences: CookPreferences) {
        lastSentRecipeID = recipe.id
        CookConnectivity.shared.start(recipeID: recipe.id, preferences: preferences)
    }

    func add(_ record: CookRecord) {
        guard !records.contains(where: { $0.id == record.id }) else { return }
        records.insert(record, at: 0)
        save()
    }

    func update(_ record: CookRecord) {
        guard let index = records.firstIndex(where: { $0.id == record.id }) else { return }
        records[index] = record
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: Self.recordsKey),
              let decoded = try? JSONDecoder().decode([CookRecord].self, from: data) else { return }
        records = decoded.sorted { $0.completedAt > $1.completedAt }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: Self.recordsKey)
    }
}
