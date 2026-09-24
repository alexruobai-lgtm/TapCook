import ImageIO
import SwiftUI

enum BundleImage {
    static func image(named name: String) -> Image {
        image(named: name, fallbackNamed: nil)
    }

    static func image(named name: String, fallbackNamed fallbackName: String?) -> Image {
        let url = exactResourceURL(named: name)
            ?? fallbackName.flatMap { resourceURL(named: $0) }
            ?? resourceURL(named: name)

        guard let url,
              let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
            return Image(systemName: "photo.fill")
        }
        return Image(decorative: cgImage, scale: 1)
    }

    static func resourceURL(named name: String) -> URL? {
        if let exact = exactResourceURL(named: name) {
            return exact
        }
        return Bundle.main.url(forResource: catalogFallbackName(for: name), withExtension: "png")
    }

    private static func exactResourceURL(named name: String) -> URL? {
        for fileExtension in ["png", "jpg", "jpeg"] {
            if let url = Bundle.main.url(forResource: name, withExtension: fileExtension) {
                return url
            }
        }
        return nil
    }

    private static func catalogFallbackName(for name: String) -> String {
        let panel: Int
        if matches(name, ["serve", "rest"]) {
            panel = 7
        } else if matches(name, ["reduce", "finish", "garnish", "glaze", "drain", "check", "monitor"]) {
            panel = 6
        } else if matches(name, ["simmer", "steam", "roast", "cool"]) {
            panel = 5
        } else if matches(name, ["sear", "cook", "fry", "combine", "shape", "toss", "noodles", "topping-cook"]) {
            panel = 4
        } else if matches(name, ["heat", "preheat", "oil", "water", "stock", "base", "aromatics", "brown"]) {
            panel = 3
        } else if matches(name, ["sauce", "season", "marinate", "dressing", "mix", "filling", "coat", "liquid"]) {
            panel = 2
        } else {
            panel = 1
        }
        return "catalog-step-\(panel)"
    }

    private static func matches(_ name: String, _ suffixes: [String]) -> Bool {
        suffixes.contains { name.hasSuffix("-\($0)") }
    }
}
