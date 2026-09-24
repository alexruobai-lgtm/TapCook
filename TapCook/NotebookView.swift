import SwiftUI

struct NotebookView: View {
    @EnvironmentObject private var preferences: CookPreferencesStore
    @EnvironmentObject private var store: CookStore
    @State private var selectedRecord: CookRecord?

    private var language: AppLanguage { preferences.interfaceLanguage.resolved }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    statsCard
                    if store.records.isEmpty {
                        ContentUnavailableView(
                            L10n.string("notebook.empty.title"),
                            systemImage: "book.closed",
                            description: Text(L10n.string("notebook.empty.message"))
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.top, 48)
                    } else {
                        Text(L10n.string("notebook.history"))
                            .font(.title2.bold())
                        ForEach(store.records) { record in
                            Button { selectedRecord = record } label: {
                                recordCard(record)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
            .background(TapCookTheme.cream.ignoresSafeArea())
            .navigationTitle(L10n.string("notebook.title"))
            .sheet(item: $selectedRecord) { record in
                RecordEditor(record: record)
                    .environmentObject(store)
                    .environmentObject(preferences)
            }
        }
    }

    private var statsCard: some View {
        let stats = CookingStats(records: store.records, language: language)
        return VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(L10n.string("stats.title")).font(.title2.bold())
                    Text(L10n.string("stats.subtitle")).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(TapCookTheme.orange)
            }

            HStack(spacing: 0) {
                StatMetric(value: "\(stats.completedCount)", label: L10n.string("stats.dishes"))
                Divider().frame(height: 36)
                StatMetric(value: "\(stats.totalMinutes)", label: L10n.string("stats.minutes"))
                Divider().frame(height: 36)
                StatMetric(value: "\(stats.streak)", label: L10n.string("stats.streak"))
            }

            VStack(alignment: .leading, spacing: 7) {
                Text(L10n.string("stats.this.week")).font(.caption.bold()).foregroundStyle(.secondary)
                HStack {
                    ForEach(stats.week, id: \.date) { day in
                        VStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(day.didCook ? TapCookTheme.orange : Color.secondary.opacity(0.14))
                                .frame(height: 28)
                            Text(day.label)
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(17)
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func recordCard(_ record: CookRecord) -> some View {
        let recipe = record.recipe
        return HStack(spacing: 14) {
            Image(systemName: recipe?.symbol ?? "fork.knife")
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .background(TapCookTheme.color(hex: recipe?.colorHex ?? "F25A24"), in: RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe?.name.value(for: language) ?? L10n.string("notebook.unknown.recipe"))
                    .font(.headline)
                Text(formattedDate(record.completedAt))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if let rating = record.rating {
                Text(String(repeating: "★", count: rating))
                    .font(.caption)
                    .foregroundStyle(TapCookTheme.orange)
            }
            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = language.locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct StatMetric: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 3) {
            Text(value).font(.title2.bold().monospacedDigit()).foregroundStyle(TapCookTheme.ink)
            Text(label).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct CookingStats {
    struct WeekDay {
        let date: Date
        let label: String
        let didCook: Bool
    }

    let completedCount: Int
    let totalMinutes: Int
    let streak: Int
    let week: [WeekDay]

    init(
        records: [CookRecord],
        language: AppLanguage,
        now: Date = Date(),
        calendar: Calendar = .current
    ) {
        completedCount = records.count
        totalMinutes = records.reduce(0) { $0 + $1.elapsedSeconds } / 60
        let cookedDays = Set(records.map { calendar.startOfDay(for: $0.completedAt) })

        var cursor = calendar.startOfDay(for: now)
        if !cookedDays.contains(cursor), let yesterday = calendar.date(byAdding: .day, value: -1, to: cursor) {
            cursor = yesterday
        }
        var runningStreak = 0
        while cookedDays.contains(cursor) {
            runningStreak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: cursor) else { break }
            cursor = previous
        }
        streak = runningStreak

        let today = calendar.startOfDay(for: now)
        let firstDay = calendar.date(byAdding: .day, value: -6, to: today) ?? today
        let formatter = DateFormatter()
        formatter.locale = language.locale
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        week = (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: firstDay) else { return nil }
            return WeekDay(date: date, label: formatter.string(from: date), didCook: cookedDays.contains(date))
        }
    }
}

private struct RecordEditor: View {
    @EnvironmentObject private var store: CookStore
    @EnvironmentObject private var preferences: CookPreferencesStore
    @Environment(\.dismiss) private var dismiss
    @State private var draft: CookRecord

    init(record: CookRecord) { _draft = State(initialValue: record) }

    var body: some View {
        NavigationStack {
            Form {
                Section(L10n.string("record.rating")) {
                    HStack {
                        ForEach(1...5, id: \.self) { value in
                            Button {
                                draft.rating = value
                            } label: {
                                Image(systemName: value <= (draft.rating ?? 0) ? "star.fill" : "star")
                                    .foregroundStyle(TapCookTheme.orange)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                Section(L10n.string("record.note")) {
                    TextEditor(text: $draft.note).frame(minHeight: 130)
                }
            }
            .navigationTitle(draft.recipe?.name.value(for: preferences.interfaceLanguage.resolved) ?? "Tap Cook")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.string("action.cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(L10n.string("action.save")) {
                        store.update(draft)
                        dismiss()
                    }
                }
            }
        }
    }
}
