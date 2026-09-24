import Foundation

enum CatalogTechnique: String, Sendable {
    case stirFry
    case braise
    case steam
    case soup
    case coldDish
    case noodle
    case rice
    case roast
    case fry
    case dough
    case hotPot
    case dessert

    var label: LocalizedText {
        switch self {
        case .stirFry: .init(en: "Stir-fry", zh: "快炒")
        case .braise: .init(en: "Braise", zh: "烧炖")
        case .steam: .init(en: "Steam", zh: "蒸制")
        case .soup: .init(en: "Soup", zh: "汤羹")
        case .coldDish: .init(en: "Cold dish", zh: "凉菜")
        case .noodle: .init(en: "Noodles", zh: "面食")
        case .rice: .init(en: "Rice dish", zh: "米饭")
        case .roast: .init(en: "Roast", zh: "烤制")
        case .fry: .init(en: "Crisp fry", zh: "炸制")
        case .dough: .init(en: "Dough and shaping", zh: "面点")
        case .hotPot: .init(en: "Hot pot", zh: "锅物")
        case .dessert: .init(en: "Dessert", zh: "甜品")
        }
    }

    var symbol: String {
        switch self {
        case .stirFry: "flame.fill"
        case .braise: "hourglass"
        case .steam: "cloud.fill"
        case .soup: "drop.fill"
        case .coldDish: "leaf.fill"
        case .noodle: "lines.measurement.horizontal"
        case .rice: "takeoutbag.and.cup.and.straw.fill"
        case .roast: "oven.fill"
        case .fry: "sparkles"
        case .dough: "circle.grid.3x3.fill"
        case .hotPot: "flame.circle.fill"
        case .dessert: "birthday.cake.fill"
        }
    }

    var colorHex: String {
        switch self {
        case .stirFry: "E45A24"
        case .braise: "A83D26"
        case .steam: "3D8D8B"
        case .soup: "D58B28"
        case .coldDish: "3D9C56"
        case .noodle: "C73A28"
        case .rice: "E88422"
        case .roast: "9B4A2F"
        case .fry: "D96C1F"
        case .dough: "B67A42"
        case .hotPot: "BD3428"
        case .dessert: "D4777F"
        }
    }
}

struct CatalogRecipeSeed: Sendable {
    let id: String
    let name: LocalizedText
    let cuisine: LocalizedText
    let technique: CatalogTechnique
    let totalMinutes: Int
    let difficulty: RecipeDifficulty
    let focus: LocalizedText
}

enum CatalogRecipeFactory {
    static func make(_ seed: CatalogRecipeSeed) -> Recipe {
        Recipe(
            id: seed.id,
            name: seed.name,
            subtitle: .init(
                en: "A guided \(seed.cuisine.en) \(seed.technique.label.en.lowercased()) built around \(seed.focus.en).",
                zh: "以\(seed.focus.zh)为主角的\(seed.cuisine.zh)\(seed.technique.label.zh)教学。"
            ),
            cuisine: seed.cuisine,
            totalMinutes: seed.totalMinutes,
            difficulty: seed.difficulty,
            symbol: seed.technique.symbol,
            colorHex: seed.technique.colorHex,
            ingredients: ingredients(for: seed),
            steps: blueprints(for: seed).map { blueprint in
                CookingStep(
                    id: blueprint.id,
                    title: .init(en: blueprint.titleEn, zh: blueprint.titleZh),
                    instruction: .init(
                        en: fill(blueprint.instructionEn, focus: seed.focus.en, dish: seed.name.en),
                        zh: fill(blueprint.instructionZh, focus: seed.focus.zh, dish: seed.name.zh)
                    ),
                    voicePrompt: .init(
                        en: fill(blueprint.voiceEn ?? blueprint.instructionEn, focus: seed.focus.en, dish: seed.name.en),
                        zh: fill(blueprint.voiceZh ?? blueprint.instructionZh, focus: seed.focus.zh, dish: seed.name.zh)
                    ),
                    durationSeconds: blueprint.durationSeconds,
                    symbol: blueprint.symbol,
                    heat: blueprint.heatEn.map { .init(en: $0, zh: blueprint.heatZh ?? $0) },
                    tip: blueprint.tipEn.map { .init(en: $0, zh: blueprint.tipZh ?? $0) }
                )
            }
        )
    }

    private static func fill(_ text: String, focus: String, dish: String) -> String {
        text.replacingOccurrences(of: "{focus}", with: focus)
            .replacingOccurrences(of: "{dish}", with: dish)
    }

    private static func ingredients(for seed: CatalogRecipeSeed) -> [Ingredient] {
        let supporting: LocalizedText
        let seasoning: LocalizedText
        switch seed.technique {
        case .dough:
            supporting = .init(en: "Flour or wrapper base", zh: "面粉或面皮原料")
            seasoning = .init(en: "Filling seasonings", zh: "馅料调味")
        case .dessert:
            supporting = .init(en: "Sugar and starch base", zh: "糖和淀粉类原料")
            seasoning = .init(en: "Fragrant finishing ingredients", zh: "增香收尾原料")
        case .noodle:
            supporting = .init(en: "Noodles and fresh toppings", zh: "面条和新鲜配菜")
            seasoning = .init(en: "Signature noodle sauce", zh: "特色拌面或汤面调味")
        case .rice:
            supporting = .init(en: "Rice and seasonal vegetables", zh: "米饭和时令配菜")
            seasoning = .init(en: "Signature rice seasoning", zh: "特色米饭调味")
        case .soup, .hotPot:
            supporting = .init(en: "Stock and seasonal vegetables", zh: "高汤和时令蔬菜")
            seasoning = .init(en: "Soup seasonings", zh: "汤底调味")
        default:
            supporting = .init(en: "Seasonal vegetables", zh: "时令配菜")
            seasoning = .init(en: "Signature seasonings", zh: "特色调味料")
        }

        return [
            Ingredient(id: "focus", name: seed.focus, metricAmount: "400 g", usAmount: "14 oz", substitute: nil),
            Ingredient(id: "supporting", name: supporting, metricAmount: "1 set", usAmount: "1 set", substitute: nil),
            Ingredient(id: "aromatics", name: .init(en: "Fresh aromatics", zh: "新鲜葱姜蒜等料头"), metricAmount: "1 small bowl", usAmount: "1 small bowl", substitute: nil),
            Ingredient(id: "seasoning", name: seasoning, metricAmount: "1 small bowl", usAmount: "1 small bowl", substitute: nil),
            Ingredient(id: "oil", name: .init(en: "Cooking oil", zh: "食用油"), metricAmount: "30 ml", usAmount: "2 tbsp", substitute: nil),
            Ingredient(id: "water", name: .init(en: "Water or stock", zh: "清水或高汤"), metricAmount: "As needed", usAmount: "As needed", substitute: nil)
        ]
    }

    private static func blueprints(for seed: CatalogRecipeSeed) -> [StepBlueprint] {
        let longCook = max(600, (seed.totalMinutes - 15) * 60)
        switch seed.technique {
        case .stirFry:
            return [
                bp("prep", "Prepare the main ingredient", "处理主料", "Cut {focus} into even bite-size pieces and dry the surface.", "把{focus}处理成大小均匀的入口小块，并擦干表面。", 150, "fork.knife"),
                bp("marinate", "Season before the wok", "提前入底味", "Coat {focus} with the recipe seasonings until evenly covered.", "把{focus}与基础调味抓拌均匀，让味道先进入主料。", 300, "drop.circle.fill"),
                bp("sauce", "Mix the finishing sauce", "调好碗汁", "Mix the signature sauce now so {dish} can move quickly once the wok is hot.", "提前调好{dish}的特色碗汁，锅热后才能快速完成。", 60, "drop.fill"),
                bp("heat", "Heat the wok", "烧热炒锅", "Heat the empty wok until clearly hot, then add cooking oil.", "空锅烧到明显发热，再加入食用油。", 45, "flame.fill", "High heat", "大火"),
                bp("sear", "Sear the main ingredient", "快速煎炒主料", "Spread {focus} in one layer, let it color, then toss until nearly cooked.", "把{focus}铺成一层，先煎上色，再翻炒到接近熟透。", 120, "bolt.fill", "High heat", "大火"),
                bp("combine", "Add vegetables and sauce", "加入配菜和料汁", "Add the prepared vegetables and sauce; toss until glossy and just cooked.", "加入备好的配菜和料汁，快速翻到油亮、刚好熟透。", 90, "arrow.triangle.2.circlepath", "High heat", "大火"),
                bp("serve", "Taste and serve", "尝味出锅", "Taste {dish}, adjust once, and serve immediately while the texture is lively.", "尝一下{dish}的味道，只调整一次，趁口感最好马上出锅。", nil, "checkmark.seal.fill")
            ]
        case .braise:
            return [
                bp("prep", "Cut and dry", "切配并擦干", "Cut {focus} evenly and remove excess surface moisture.", "把{focus}切得大小均匀，并去掉表面多余水分。", 180, "fork.knife"),
                bp("brown", "Brown for depth", "煎出焦香", "Brown {focus} in batches so the braise develops a deep base flavor.", "把{focus}分批煎上色，为烧炖建立浓郁底味。", 240, "flame.fill", "Medium-high heat", "中大火"),
                bp("aromatics", "Wake up the aromatics", "炒香料头", "Lower the heat and fry the aromatics until fragrant, not burnt.", "转中小火把料头炒香，注意不要炒糊。", 60, "sparkles", "Medium heat", "中火"),
                bp("liquid", "Build the braising liquid", "加入烧炖汤汁", "Add the signature seasonings and enough hot liquid to surround {focus}.", "加入特色调味和足量热汤汁，让{focus}均匀浸在汤汁中。", 60, "drop.fill", "Medium heat", "中火"),
                bp("simmer", "Braise gently", "小火慢炖", "Cover and keep {dish} at a gentle simmer until the main ingredient becomes tender.", "盖盖让{dish}保持轻轻冒泡，慢炖到主料软嫩。", longCook, "hourglass", "Low heat", "小火", "Check the liquid once halfway through.", "中途检查一次汤汁余量。"),
                bp("reduce", "Reduce the sauce", "开盖收汁", "Uncover and reduce until the sauce visibly clings to {focus}.", "开盖收汁，直到酱汁能明显挂在{focus}表面。", 180, "waveform.path", "Medium-high heat", "中大火"),
                bp("serve", "Rest, taste, and serve", "稍歇装盘", "Rest {dish} briefly, taste the sauce, then plate with its glaze.", "让{dish}稍微静置，尝味后连同油亮酱汁一起装盘。", nil, "checkmark.seal.fill")
            ]
        case .steam:
            return [
                bp("prep", "Prepare and dry", "处理并擦干", "Prepare {focus} in even portions and dry the surface well.", "把{focus}处理成均匀份量，并充分擦干表面。", 180, "fork.knife"),
                bp("season", "Season lightly", "轻调底味", "Season {focus} lightly so steaming preserves its natural flavor.", "给{focus}薄薄调味，让蒸制保留食材本味。", 180, "drop.circle.fill"),
                bp("setup", "Set up the steamer", "准备蒸锅", "Arrange {focus} on a heatproof plate and bring the steamer to a full boil.", "把{focus}摆入耐热盘，同时把蒸锅烧到充分上汽。", 120, "cloud.fill"),
                bp("steam", "Steam with steady heat", "稳定火力蒸制", "Put the plate in only after strong steam appears, then cover tightly.", "蒸汽充足后再放入盘子，并把锅盖盖严。", max(300, seed.totalMinutes * 18), "cloud.fill", "High heat", "大火"),
                bp("check", "Check the center", "检查中心熟度", "Check the thickest part of {focus}; it should be opaque, tender, and fully cooked.", "检查{focus}最厚的位置，应当变色、软嫩并完全熟透。", nil, "checkmark.circle.fill"),
                bp("garnish", "Add fresh aromatics", "加入新鲜料头", "Remove excess steaming liquid and add fresh aromatics for a clean finish.", "倒掉多余蒸汁，加入新鲜料头，让收尾味道更干净。", 45, "leaf.fill"),
                bp("serve", "Finish and serve hot", "调味趁热上桌", "Add the finishing seasoning to {dish} and serve while piping hot.", "给{dish}加入最后调味，趁热立即上桌。", nil, "checkmark.seal.fill")
            ]
        case .soup:
            return [
                bp("prep", "Prepare the soup ingredients", "准备汤料", "Cut {focus} and supporting ingredients into spoon-friendly pieces.", "把{focus}和配料切成适合汤匙入口的大小。", 180, "fork.knife"),
                bp("base", "Start the flavor base", "炒香汤底", "Gently cook the aromatics until fragrant without browning them too deeply.", "轻轻炒香料头，不要让颜色变得太深。", 60, "sparkles", "Medium heat", "中火"),
                bp("stock", "Add hot stock", "加入热汤", "Add hot stock and bring it to a clear, steady simmer.", "加入热高汤，煮到汤面稳定轻轻冒泡。", 180, "drop.fill", "High heat", "大火"),
                bp("cook", "Cook the main ingredient", "煮熟主料", "Add {focus} in the right order so every ingredient finishes tender together.", "按成熟速度加入{focus}和配料，让所有食材同时达到软嫩。", max(300, seed.totalMinutes * 20), "flame.fill", "Medium heat", "中火"),
                bp("skim", "Keep the broth clean", "保持汤清味净", "Skim foam and excess oil while {dish} simmers gently.", "让{dish}轻轻煮，同时撇去浮沫和多余油脂。", 120, "water.waves", "Low heat", "小火"),
                bp("season", "Season near the end", "最后调味", "Taste the broth first, then add salt and signature seasoning a little at a time.", "先尝汤味，再少量多次加入盐和特色调味。", 45, "drop.circle.fill"),
                bp("serve", "Rest and serve", "稍歇盛汤", "Let {dish} settle for one minute, then serve the broth and ingredients together.", "让{dish}静置一分钟，再把汤和食材一起盛出。", 60, "checkmark.seal.fill")
            ]
        case .coldDish:
            return [
                bp("wash", "Wash and dry", "洗净擦干", "Wash {focus} thoroughly and dry it so the dressing will cling.", "把{focus}彻底洗净并擦干，让料汁更容易附着。", 90, "drop.fill"),
                bp("cut", "Cut for texture", "按口感切配", "Cut {focus} into even pieces with enough surface area to hold flavor.", "把{focus}切成大小均匀、容易挂味的形状。", 120, "fork.knife"),
                bp("salt", "Season and rest", "加盐静置", "Season lightly and let {focus} rest so its texture becomes crisp and balanced.", "薄薄调味并让{focus}静置，使口感更爽脆平衡。", 300, "hourglass"),
                bp("dressing", "Mix the dressing", "调好凉拌汁", "Mix the signature dressing until sugar and salt are fully dissolved.", "把特色凉拌汁调匀，直到糖和盐完全融化。", 60, "drop.circle.fill"),
                bp("drain", "Remove excess water", "去掉多余水分", "Drain any released liquid and pat {focus} dry once more.", "倒掉渗出的水，再把{focus}表面轻轻擦干。", 45, "arrow.down.to.line"),
                bp("toss", "Toss thoroughly", "充分拌匀", "Toss {focus} with the dressing until every piece is evenly coated.", "把{focus}与料汁充分拌匀，让每一块都均匀入味。", 60, "arrow.triangle.2.circlepath"),
                bp("serve", "Taste and serve", "尝味装盘", "Taste {dish}, adjust acidity or salt once, garnish, and serve.", "尝一下{dish}，调整一次酸度或咸度，点缀后装盘。", nil, "checkmark.seal.fill")
            ]
        case .noodle:
            return [
                bp("toppings", "Prepare the toppings", "准备浇头配菜", "Prepare {focus}, aromatics, and fresh toppings before boiling the noodles.", "煮面前先把{focus}、料头和新鲜配菜全部备好。", 240, "fork.knife"),
                bp("sauce", "Build the noodle flavor", "调好面底", "Mix the signature sauce or start the broth base for {dish}.", "调好{dish}的特色拌面汁，或提前建立汤面底味。", 90, "drop.circle.fill"),
                bp("topping-cook", "Cook the topping", "完成浇头", "Cook {focus} until aromatic and properly tender; keep it warm.", "把{focus}烹饪到香味充足、熟度合适，并保持温热。", 300, "flame.fill", "Medium-high heat", "中大火"),
                bp("water", "Bring water to a full boil", "把水烧开", "Use plenty of water and wait for a strong rolling boil.", "使用足量清水，等到水面充分翻滚后再下面。", 180, "water.waves", "High heat", "大火"),
                bp("noodles", "Cook the noodles", "煮到刚好熟", "Add noodles, loosen them immediately, and cook until just tender.", "放入面条后马上拨散，煮到刚刚熟、仍有弹性。", max(120, seed.totalMinutes * 8), "lines.measurement.horizontal", "High heat", "大火"),
                bp("combine", "Combine while hot", "趁热组合", "Combine noodles, sauce or broth, and {focus} while everything is hot.", "趁热把面条、汤汁或拌面汁与{focus}组合在一起。", 60, "arrow.triangle.2.circlepath"),
                bp("serve", "Finish the bowl", "完成整碗面", "Add fresh garnish, taste once, and serve {dish} immediately.", "加入新鲜点缀，尝味一次，马上享用{dish}。", nil, "checkmark.seal.fill")
            ]
        case .rice:
            return [
                bp("rice", "Prepare the rice", "处理米饭", "Measure and prepare the rice so its moisture suits {dish}.", "量好并处理米饭，让含水量适合制作{dish}。", 180, "takeoutbag.and.cup.and.straw.fill"),
                bp("prep", "Prepare the additions", "准备配料", "Cut {focus} and seasonal vegetables into even small pieces.", "把{focus}和时令配菜切成均匀小块。", 240, "fork.knife"),
                bp("season", "Mix the seasoning", "调好米饭味汁", "Mix the signature seasoning before the pan or cooker gets hot.", "在锅热之前调好特色味汁。", 60, "drop.circle.fill"),
                bp("aromatics", "Cook the aromatics", "炒香料头", "Cook the aromatics until fragrant, then add {focus} in an even layer.", "炒香料头，再把{focus}均匀铺入锅中。", 120, "sparkles", "Medium-high heat", "中大火"),
                bp("combine", "Add and separate the rice", "加入米饭并拨散", "Add rice and separate every clump while mixing it with the cooked ingredients.", "加入米饭，一边混合食材，一边把所有结块拨散。", 180, "flame.fill", "High heat", "大火"),
                bp("finish", "Season and finish cooking", "调味完成熟制", "Add the sauce and finish {dish} until the rice is hot, glossy, and evenly flavored.", "加入味汁，把{dish}完成到米饭热透、油亮、味道均匀。", max(120, seed.totalMinutes * 8), "hourglass", "Medium heat", "中火"),
                bp("serve", "Rest and serve", "稍歇装碗", "Rest the rice briefly, loosen it once, then serve with fresh garnish.", "让米饭短暂静置，再拨松一次，加入新鲜点缀后装碗。", nil, "checkmark.seal.fill")
            ]
        case .roast:
            return [
                bp("prep", "Trim and dry", "修整擦干", "Prepare {focus} evenly and dry every surface before seasoning.", "把{focus}修整均匀，并在调味前擦干每一面。", 240, "fork.knife"),
                bp("marinate", "Marinate deeply", "充分腌制", "Massage the signature marinade into {focus}, then let it rest.", "把特色腌料充分抹进{focus}，再静置入味。", 900, "hourglass"),
                bp("preheat", "Preheat the oven", "充分预热", "Preheat fully and set up a rack so hot air can move around {focus}.", "把烤箱充分预热，并架起{focus}，让热空气能四周流动。", 600, "oven.fill"),
                bp("roast", "Roast the first phase", "第一阶段烤制", "Roast {focus} steadily until the surface begins to color.", "稳定烤制{focus}，直到表面开始上色。", max(900, (seed.totalMinutes - 20) * 45), "oven.fill"),
                bp("glaze", "Brush the glaze", "刷上亮汁", "Brush a thin, even layer of finishing glaze over the hot surface.", "在热表面薄薄刷一层均匀亮汁。", 60, "paintbrush.pointed.fill"),
                bp("finish", "Finish for color", "完成上色", "Return {focus} to the heat until deeply colored and fully cooked.", "把{focus}送回热源，烤到颜色饱满并完全熟透。", 480, "flame.fill"),
                bp("rest", "Rest before cutting", "静置后再切", "Rest {dish} so its juices settle, then slice and serve.", "让{dish}静置，使汁水重新稳定，再切开装盘。", 300, "checkmark.seal.fill")
            ]
        case .fry:
            return [
                bp("prep", "Cut even pieces", "切成均匀大小", "Prepare {focus} in evenly sized pieces and remove excess moisture.", "把{focus}处理成大小均匀的小块，并去除多余水分。", 180, "fork.knife"),
                bp("season", "Season the center", "给内部入味", "Season {focus} before coating so the inside will taste balanced.", "裹粉之前先给{focus}调底味，让内部味道平衡。", 300, "drop.circle.fill"),
                bp("coat", "Build an even crust", "均匀裹上外壳", "Coat every surface evenly and shake off loose excess coating.", "让每一面都均匀裹上外壳，并抖掉松散余粉。", 120, "snowflake"),
                bp("oil", "Heat the oil safely", "安全加热油锅", "Heat the oil steadily; test with a tiny crumb before adding {focus}.", "稳定加热食用油，放入{focus}前用一点碎屑测试油温。", 180, "flame.fill", "Medium-high heat", "中大火"),
                bp("fry", "Fry in small batches", "分小批炸制", "Fry {focus} without crowding until crisp and properly colored.", "把{focus}分小批炸，不要拥挤，炸到酥脆并达到合适颜色。", max(240, seed.totalMinutes * 10), "sparkles", "Medium-high heat", "中大火"),
                bp("drain", "Drain and season", "沥油调味", "Drain on a rack, then add the finishing seasoning while still hot.", "放在网架上沥油，趁热加入最后调味。", 60, "arrow.down.to.line"),
                bp("serve", "Serve while crisp", "趁酥脆上桌", "Plate {dish} with its garnish and serve before the crust softens.", "给{dish}加上点缀，趁外壳仍酥脆马上上桌。", nil, "checkmark.seal.fill")
            ]
        case .dough:
            return [
                bp("dough", "Mix the dough", "和好面团", "Combine the flour base and liquid until no dry patches remain.", "把面粉类原料和液体混合到看不见干粉。", 180, "circle.grid.3x3.fill"),
                bp("knead", "Knead and rest", "揉面醒面", "Knead until smoother, cover, and let the dough relax.", "把面团揉得更光滑，盖好后静置松弛。", 900, "hourglass"),
                bp("filling", "Prepare the filling", "调好馅料", "Prepare {focus} and mix the filling until evenly seasoned and cohesive.", "处理好{focus}，把馅料调到味道均匀、能够抱团。", 300, "drop.circle.fill"),
                bp("divide", "Divide evenly", "均匀分剂", "Divide the dough and filling into equal portions for consistent cooking.", "把面团和馅料分成相等份量，保证成熟时间一致。", 180, "square.grid.3x3.fill"),
                bp("shape", "Shape and seal", "成形封口", "Shape {dish} carefully and seal every edge so the filling stays inside.", "仔细给{dish}成形，并把每一道边缘封牢，避免馅料漏出。", 360, "hands.and.sparkles.fill"),
                bp("cook", "Cook through", "完全熟制", "Cook in batches until the wrapper or crust is set and the filling is fully cooked.", "分批熟制，直到外皮定型、内部馅料完全熟透。", max(300, seed.totalMinutes * 12), "flame.fill", "Medium heat", "中火"),
                bp("serve", "Rest and serve", "稍歇享用", "Let {dish} rest briefly, then serve with its traditional accompaniment.", "让{dish}短暂静置，再搭配合适蘸料或配菜享用。", nil, "checkmark.seal.fill")
            ]
        case .hotPot:
            return [
                bp("broth", "Build the broth", "建立锅底", "Combine stock, aromatics, and signature seasoning for {dish}.", "把高汤、料头和特色调味组合成{dish}的锅底。", 300, "drop.fill"),
                bp("prep", "Prepare every ingredient", "分类备好食材", "Slice {focus} and supporting ingredients into safe, quick-cooking portions.", "把{focus}和配料分门别类切成安全、容易熟的份量。", 480, "fork.knife"),
                bp("sauce", "Mix the dipping sauce", "调好蘸料", "Mix a personal dipping sauce before the broth reaches a simmer.", "在锅底煮开前先调好个人蘸料。", 90, "drop.circle.fill"),
                bp("simmer", "Bring the broth to a simmer", "把锅底煮开", "Bring the broth to a steady simmer and taste it before cooking ingredients.", "把锅底煮到稳定冒泡，下食材前先尝一次味道。", 300, "flame.circle.fill", "High heat", "大火"),
                bp("cook", "Cook in the right order", "按成熟顺序下锅", "Cook firm ingredients first, then add {focus} and delicate items in later rounds.", "先放耐煮食材，再分轮加入{focus}和易熟食材。", 900, "hourglass", "Medium heat", "中火"),
                bp("monitor", "Keep the broth safe", "保持锅底安全", "Return the broth to a simmer between batches and use separate utensils for raw food.", "每轮之间让锅底重新煮开，夹取生食和熟食使用不同工具。", nil, "checkmark.shield.fill"),
                bp("serve", "Enjoy in rounds", "分轮享用", "Serve each cooked batch immediately and finish with noodles or vegetables.", "每批食材熟后马上享用，最后可以加入面条或蔬菜收尾。", nil, "checkmark.seal.fill")
            ]
        case .dessert:
            return [
                bp("prep", "Measure precisely", "准确称量", "Measure {focus} and the sweetening ingredients before heating anything.", "加热前准确称量{focus}和甜味原料。", 180, "scalemass.fill"),
                bp("mix", "Mix until smooth", "混合到顺滑", "Combine the base until no dry pockets or obvious lumps remain.", "把甜品基底混合到没有干粉和明显结块。", 180, "drop.circle.fill"),
                bp("shape", "Portion evenly", "均匀分份", "Divide or shape {dish} evenly so every portion cooks at the same speed.", "把{dish}均匀分份或成形，保证每份成熟速度一致。", 240, "circle.grid.3x3.fill"),
                bp("cook", "Cook gently", "温和熟制", "Cook over controlled heat and stir or turn as the recipe requires.", "使用稳定可控的火力，并按需要搅拌或翻面。", max(300, seed.totalMinutes * 15), "flame.fill", "Low heat", "小火"),
                bp("finish", "Add the fragrant finish", "加入增香收尾", "Add the finishing syrup, fruit, nuts, or aroma while the dessert is warm.", "趁甜品温热加入糖浆、水果、坚果或增香原料。", 60, "sparkles"),
                bp("cool", "Cool to set", "冷却定型", "Let {dish} cool or rest until its texture becomes stable.", "让{dish}冷却或静置，直到质地稳定。", 600, "hourglass"),
                bp("serve", "Garnish and serve", "点缀享用", "Add a restrained garnish, check sweetness, and serve the finished dessert.", "加入适量点缀，确认甜度后享用完成的甜品。", nil, "checkmark.seal.fill")
            ]
        }
    }

    private static func bp(
        _ id: String,
        _ titleEn: String,
        _ titleZh: String,
        _ instructionEn: String,
        _ instructionZh: String,
        _ durationSeconds: Int?,
        _ symbol: String,
        _ heatEn: String? = nil,
        _ heatZh: String? = nil,
        _ tipEn: String? = nil,
        _ tipZh: String? = nil,
        _ voiceEn: String? = nil,
        _ voiceZh: String? = nil
    ) -> StepBlueprint {
        StepBlueprint(
            id: id,
            titleEn: titleEn,
            titleZh: titleZh,
            instructionEn: instructionEn,
            instructionZh: instructionZh,
            durationSeconds: durationSeconds,
            symbol: symbol,
            heatEn: heatEn,
            heatZh: heatZh,
            tipEn: tipEn,
            tipZh: tipZh,
            voiceEn: voiceEn,
            voiceZh: voiceZh
        )
    }
}

private struct StepBlueprint {
    let id: String
    let titleEn: String
    let titleZh: String
    let instructionEn: String
    let instructionZh: String
    let durationSeconds: Int?
    let symbol: String
    let heatEn: String?
    let heatZh: String?
    let tipEn: String?
    let tipZh: String?
    let voiceEn: String?
    let voiceZh: String?
}
