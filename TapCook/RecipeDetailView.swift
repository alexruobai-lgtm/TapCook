import Foundation
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @EnvironmentObject private var preferences: CookPreferencesStore
    @EnvironmentObject private var store: CookStore
    @State private var sentToWatch = false

    private var language: AppLanguage { preferences.interfaceLanguage.resolved }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                artwork

                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name.value(for: language))
                        .font(.largeTitle.bold())
                    Text(recipe.subtitle.value(for: language))
                        .font(.body)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 16) {
                        Label("\(recipe.totalMinutes) \(L10n.string("unit.min"))", systemImage: "clock.fill")
                        Label("\(recipe.steps.count) \(L10n.string("unit.steps"))", systemImage: "list.number")
                        Label(recipe.difficulty.localizedName, systemImage: "chart.bar.fill")
                    }
                    .font(.caption.bold())
                    .foregroundStyle(TapCookTheme.orange)
                }

                videoTutorials

                sectionTitle(L10n.string("recipe.ingredients"), subtitle: L10n.string("recipe.ingredients.subtitle"))
                VStack(spacing: 0) {
                    ForEach(Array(recipe.ingredients.enumerated()), id: \.element.id) { index, ingredient in
                        IngredientRow(ingredient: ingredient, language: language, units: preferences.unitSystem)
                        if index < recipe.ingredients.count - 1 { Divider().padding(.leading, 46) }
                    }
                }
                .padding(.horizontal, 14)
                .background(.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))

                sectionTitle(L10n.string("recipe.steps.preview"), subtitle: L10n.string("recipe.steps.preview.subtitle"))
                VStack(spacing: 12) {
                    ForEach(Array(recipe.steps.enumerated()), id: \.element.id) { index, step in
                        HStack(alignment: .top, spacing: 12) {
                            ZStack(alignment: .topLeading) {
                                BundleImage.image(named: "\(recipe.id)-\(step.id)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 58, height: 58)
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                Text("\(index + 1)")
                                    .font(.caption2.bold())
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20)
                                    .background(TapCookTheme.orange, in: Circle())
                                    .offset(x: -5, y: -5)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(step.title.value(for: language)).font(.subheadline.bold())
                                Text(step.instruction.value(for: language))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            Spacer()
                            if let seconds = step.durationSeconds {
                                Text(Self.shortTime(seconds))
                                    .font(.caption.monospacedDigit().bold())
                                    .foregroundStyle(TapCookTheme.orange)
                            }
                        }
                        .padding(14)
                        .background(.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                }

                Button {
                    store.sendToWatch(recipe, preferences: preferences.preferences)
                    sentToWatch = true
                } label: {
                    HStack {
                        Image(systemName: "applewatch")
                        Text(L10n.string("recipe.start.watch"))
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(18)
                    .background(TapCookTheme.orange, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            .padding(20)
            .padding(.bottom, 24)
        }
        .background(TapCookTheme.cream.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .alert(L10n.string("watch.sent.title"), isPresented: $sentToWatch) {
            Button(L10n.string("action.ok"), role: .cancel) {}
        } message: {
            Text(L10n.string("watch.sent.message"))
        }
    }

    private var artwork: some View {
        ZStack(alignment: .bottomLeading) {
            BundleImage.image(
                named: "\(recipe.id)-hero",
                fallbackNamed: "\(recipe.id)-\(recipe.steps.last?.id ?? "serve")"
            )
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            LinearGradient(colors: [.clear, .black.opacity(0.28)], startPoint: .center, endPoint: .bottom)
            Text(recipe.cuisine.value(for: language))
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 13)
                .padding(.vertical, 8)
                .background(.black.opacity(0.18), in: Capsule())
                .padding(16)
        }
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private var videoTutorials: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(spacing: 11) {
                Image(systemName: "play.rectangle.fill")
                    .font(.title2)
                    .foregroundStyle(Color(red: 1, green: 0, blue: 0))
                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.string("recipe.video.title"))
                        .font(.headline)
                    Text(L10n.string("recipe.video.subtitle"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            HStack(spacing: 10) {
                tutorialLink(language: .english, title: "English", symbol: "captions.bubble.fill")
                tutorialLink(language: .simplifiedChinese, title: "中文", symbol: "character.bubble.fill")
            }

            Text(L10n.string("recipe.video.note"))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func tutorialLink(language videoLanguage: AppLanguage, title: String, symbol: String) -> some View {
        Link(destination: RecipeVideoLinks.tutorialURL(for: recipe, language: videoLanguage)) {
            HStack(spacing: 8) {
                Image(systemName: symbol)
                Text(title)
                Spacer(minLength: 0)
                Image(systemName: "arrow.up.right")
                    .font(.caption.bold())
            }
            .font(.subheadline.bold())
            .foregroundStyle(videoLanguage == language ? .white : TapCookTheme.ink)
            .padding(.horizontal, 13)
            .frame(maxWidth: .infinity, minHeight: 46)
            .background(
                videoLanguage == language ? TapCookTheme.orange : TapCookTheme.cream,
                in: RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(L10n.format("recipe.video.accessibility", title, recipe.name.value(for: videoLanguage)))
    }

    private func sectionTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.title2.bold())
            Text(subtitle).font(.caption).foregroundStyle(.secondary)
        }
    }

    private static func shortTime(_ seconds: Int) -> String {
        seconds >= 60 ? "\(seconds / 60)m" : "\(seconds)s"
    }
}

enum RecipeVideoLinks {
    static func tutorialURL(for recipe: Recipe, language: AppLanguage) -> URL {
        let resolved = language.resolved
        let query = resolved == .simplifiedChinese
            ? "\(recipe.name.zh) 正宗做法 视频教程"
            : "\(recipe.name.en) authentic Chinese recipe tutorial English subtitles"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.youtube.com"
        components.path = "/results"
        components.queryItems = [URLQueryItem(name: "search_query", value: query)]
        return components.url ?? URL(string: "https://www.youtube.com")!
    }
}

private struct IngredientRow: View {
    let ingredient: Ingredient
    let language: AppLanguage
    let units: UnitSystem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(TapCookTheme.orange)
                .padding(.top, 2)
            VStack(alignment: .leading, spacing: 3) {
                Text(ingredient.name.value(for: language)).font(.subheadline.weight(.semibold))
                if let substitute = ingredient.substitute {
                    Text(L10n.format("ingredient.substitute", substitute.value(for: language)))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text(ingredient.amount(for: units))
                .font(.subheadline.monospacedDigit().weight(.semibold))
        }
        .padding(.vertical, 12)
    }
}
