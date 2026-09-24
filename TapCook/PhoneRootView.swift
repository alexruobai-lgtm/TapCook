import SwiftUI

struct PhoneRootView: View {
    private enum Tab: Hashable { case cook, notebook, settings }
    @State private var selectedTab: Tab

    init() {
#if DEBUG
        let demoTab = ProcessInfo.processInfo.environment["TAPCOOK_DEMO_TAB"]
        _selectedTab = State(initialValue: demoTab == "notebook" ? .notebook : .cook)
#else
        _selectedTab = State(initialValue: .cook)
#endif
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            CookHomeView()
                .tabItem { Label(L10n.string("tab.cook"), systemImage: "fork.knife") }
                .tag(Tab.cook)
            NotebookView()
                .tabItem { Label(L10n.string("tab.notebook"), systemImage: "book.closed.fill") }
                .tag(Tab.notebook)
            SettingsView()
                .tabItem { Label(L10n.string("tab.settings"), systemImage: "gearshape.fill") }
                .tag(Tab.settings)
        }
    }
}

private struct CookHomeView: View {
    @EnvironmentObject private var preferences: CookPreferencesStore
    @State private var selectedCuisine: String?
    @State private var searchText = ""

    private var language: AppLanguage { preferences.interfaceLanguage.resolved }

    private var cuisineKeys: [String] {
        var seen = Set<String>()
        return SampleRecipes.all.compactMap { recipe in
            seen.insert(recipe.cuisine.en).inserted ? recipe.cuisine.en : nil
        }
    }

    private var filteredRecipes: [Recipe] {
        let byCuisine = selectedCuisine.map { cuisine in
            SampleRecipes.all.filter { $0.cuisine.en == cuisine }
        } ?? SampleRecipes.all
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return byCuisine }
        return byCuisine.filter { recipe in
            [recipe.name.en, recipe.name.zh, recipe.cuisine.en, recipe.cuisine.zh, recipe.subtitle.en, recipe.subtitle.zh]
                .contains { $0.localizedCaseInsensitiveContains(query) }
        }
    }

    private func cuisineName(for key: String) -> String {
        SampleRecipes.all.first { $0.cuisine.en == key }?.cuisine.value(for: language) ?? key
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    hero

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(L10n.string("home.choose"))
                                .font(.title2.bold())
                            Text(L10n.string("home.choose.subtitle"))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(L10n.format("home.recipe.count", filteredRecipes.count))
                            .font(.caption2.bold())
                            .foregroundStyle(TapCookTheme.orange)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(TapCookTheme.orange.opacity(0.12), in: Capsule())
                    }

                    cuisineFilter

                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe: recipe, language: language)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
                .padding(.bottom, 20)
            }
            .background(TapCookTheme.cream.ignoresSafeArea())
            .navigationTitle("Tap Cook")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: L10n.string("search.recipes"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        preferences.setInterfaceLanguage(
                            preferences.interfaceLanguage.resolved == .english ? .simplifiedChinese : .english
                        )
                    } label: {
                        HStack(spacing: 3) {
                            Text("EN")
                                .foregroundStyle(preferences.interfaceLanguage.resolved == .english ? TapCookTheme.orange : .secondary)
                            Text("/").foregroundStyle(.tertiary)
                            Text("中文")
                                .foregroundStyle(preferences.interfaceLanguage.resolved == .simplifiedChinese ? TapCookTheme.orange : .secondary)
                        }
                    }
                    .font(.caption.bold())
                    .buttonStyle(.bordered)
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }

    private var cuisineFilter: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 9) {
                cuisineButton(
                    title: L10n.string("filter.all"),
                    isSelected: selectedCuisine == nil
                ) {
                    selectedCuisine = nil
                }
                ForEach(cuisineKeys, id: \.self) { key in
                    cuisineButton(
                        title: cuisineName(for: key),
                        isSelected: selectedCuisine == key
                    ) {
                        selectedCuisine = key
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    private func cuisineButton(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(isSelected ? .white : TapCookTheme.ink)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(
                    isSelected ? TapCookTheme.orange : Color.white,
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
    }

    private var hero: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(L10n.string("home.hero.eyebrow"))
                    .font(.caption.bold())
                    .textCase(.uppercase)
                    .foregroundStyle(.white.opacity(0.8))
                Text(L10n.string("home.hero.title"))
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text(L10n.string("home.hero.subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
            }
            Spacer(minLength: 4)
            Image(systemName: "applewatch.radiowaves.left.and.right")
                .font(.system(size: 48, weight: .semibold))
                .foregroundStyle(.white)
        }
        .padding(22)
        .background(
            LinearGradient(
                colors: [TapCookTheme.orange, Color(red: 0.78, green: 0.20, blue: 0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 28, style: .continuous)
        )
    }
}

private struct RecipeCard: View {
    let recipe: Recipe
    let language: AppLanguage

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(TapCookTheme.color(hex: recipe.colorHex).gradient)
                BundleImage.image(
                    named: "\(recipe.id)-hero",
                    fallbackNamed: "\(recipe.id)-\(recipe.steps.last?.id ?? "serve")"
                )
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 104, height: 114)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            VStack(alignment: .leading, spacing: 7) {
                Text(recipe.cuisine.value(for: language).uppercased())
                    .font(.caption2.bold())
                    .foregroundStyle(TapCookTheme.orange)
                Text(recipe.name.value(for: language))
                    .font(.title3.bold())
                    .foregroundStyle(TapCookTheme.ink)
                Text(recipe.subtitle.value(for: language))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                HStack(spacing: 12) {
                    Label("\(recipe.totalMinutes) \(L10n.string("unit.min"))", systemImage: "clock")
                    Label(recipe.difficulty.localizedName, systemImage: "chart.bar.fill")
                }
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 12, y: 5)
    }
}

#Preview {
    PhoneRootView()
        .environmentObject(CookPreferencesStore.shared)
        .environmentObject(CookStore.shared)
}
