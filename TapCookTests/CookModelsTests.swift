import XCTest
@testable import TapCook

final class CookModelsTests: XCTestCase {
    func testLocalizedTextUsesRequestedLanguage() {
        let text = LocalizedText(en: "Tomato", zh: "番茄")
        XCTAssertEqual(text.value(for: AppLanguage.english), "Tomato")
        XCTAssertEqual(text.value(for: AppLanguage.simplifiedChinese), "番茄")
    }

    func testEveryRecipeHasGuidedStepsAndTimedInteraction() {
        XCTAssertEqual(CatalogRecipes.all.count, 130)
        XCTAssertEqual(SampleRecipes.all.count, 142)
        XCTAssertEqual(Set(SampleRecipes.all.map(\.id)).count, SampleRecipes.all.count)
        XCTAssertEqual(Set(SampleRecipes.all.map(\.name.en)).count, SampleRecipes.all.count)
        XCTAssertEqual(Set(SampleRecipes.all.map(\.name.zh)).count, SampleRecipes.all.count)
        for recipe in SampleRecipes.all {
            XCTAssertGreaterThanOrEqual(recipe.steps.count, 7)
            XCTAssertTrue(recipe.steps.contains { $0.durationSeconds != nil })
            XCTAssertFalse(recipe.ingredients.isEmpty)
            XCTAssertFalse(recipe.name.en.isEmpty)
            XCTAssertFalse(recipe.name.zh.isEmpty)
            for step in recipe.steps {
                XCTAssertFalse(step.title.en.isEmpty)
                XCTAssertFalse(step.title.zh.isEmpty)
                XCTAssertFalse(step.instruction.en.isEmpty)
                XCTAssertFalse(step.instruction.zh.isEmpty)
                XCTAssertFalse(step.voicePrompt.en.isEmpty)
                XCTAssertFalse(step.voicePrompt.zh.isEmpty)
                XCTAssertNotNil(
                    BundleImage.resourceURL(named: "\(recipe.id)-\(step.id)"),
                    "Missing step image for \(recipe.id)/\(step.id)"
                )
            }
        }
    }

    func testCatalogCoversThirteenRegionalCuisines() {
        let grouped = Dictionary(grouping: CatalogRecipes.all, by: { $0.cuisine.en })
        XCTAssertEqual(grouped.count, 13)
        for (cuisine, recipes) in grouped {
            XCTAssertEqual(recipes.count, 10, "Expected ten recipes for \(cuisine)")
        }
    }

    func testCatalogHeroImagesArePresentAndUnique() throws {
        var imageData: [Data] = []

        for recipe in CatalogRecipes.all {
            let url = Bundle.main.url(forResource: "\(recipe.id)-hero", withExtension: "jpg")
            XCTAssertNotNil(url, "Missing hero image for \(recipe.id)")
            if let url {
                imageData.append(try Data(contentsOf: url))
            }
        }

        XCTAssertEqual(imageData.count, CatalogRecipes.all.count)
        XCTAssertEqual(Set(imageData).count, CatalogRecipes.all.count, "Catalog hero images must not be duplicates")
    }

    func testEveryRecipeHasBilingualYouTubeTutorialLinks() {
        for recipe in SampleRecipes.all {
            for language in [AppLanguage.english, .simplifiedChinese] {
                let url = RecipeVideoLinks.tutorialURL(for: recipe, language: language)
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let query = components?.queryItems?.first { $0.name == "search_query" }?.value
                XCTAssertEqual(components?.scheme, "https")
                XCTAssertEqual(components?.host, "www.youtube.com")
                XCTAssertEqual(components?.path, "/results")
                XCTAssertTrue(query?.contains(recipe.name.value(for: language)) == true)
            }
        }
    }

    func testCookRecordRoundTrips() throws {
        let original = CookRecord(recipeID: SampleRecipes.tomatoEggs.id, elapsedSeconds: 741, rating: 5, note: "Fluffy eggs")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(CookRecord.self, from: data)
        XCTAssertEqual(decoded, original)
        XCTAssertEqual(decoded.recipe?.id, SampleRecipes.tomatoEggs.id)
    }
}
