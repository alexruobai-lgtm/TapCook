import Foundation

extension SampleRecipes {
    static let redBraisedPork = Recipe(
        id: "red-braised-pork",
        name: .init(en: "Red-Braised Pork", zh: "红烧肉"),
        subtitle: .init(en: "Slow-simmered pork in a glossy Jiangnan sauce", zh: "慢火煨出油亮浓香的江南经典"),
        cuisine: .init(en: "Jiangnan", zh: "江浙菜"),
        totalMinutes: 65,
        difficulty: .medium,
        symbol: "hourglass",
        colorHex: "A83D26",
        ingredients: [
            ingredient("pork", "Skin-on pork belly", "带皮五花肉", "600 g", "1⅓ lb", nil, nil),
            ingredient("sugar", "Rock sugar", "冰糖", "35 g", "3 tbsp", "White sugar", "可以换成白砂糖"),
            ingredient("soy", "Light + dark soy sauce", "生抽＋老抽", "45 ml", "3 tbsp", nil, nil),
            ingredient("wine", "Shaoxing wine", "绍兴酒", "45 ml", "3 tbsp", "Dry sherry", "可以换成干雪莉酒"),
            ingredient("aromatics", "Ginger, scallion, star anise", "姜、葱、八角", "1 small bowl", "1 small bowl", nil, nil),
            ingredient("water", "Hot water", "热水", "700 ml", "3 cups", nil, nil)
        ],
        steps: [
            step("cut", "Cut even cubes", "切成均匀方块", "Cut pork belly into 3 cm cubes so every piece cooks at the same speed.", "五花肉切成三厘米方块，大小一致才会同时软烂。", "Cut the pork belly into even three-centimeter cubes. Keep the skin attached.", "把五花肉切成均匀的三厘米方块，肉皮要保留。", 150, "square.grid.3x3.fill", nil, nil, nil),
            step("blanch", "Blanch the pork", "冷水焯肉", "Cover pork with cold water, add ginger, boil, then skim and drain.", "五花肉冷水下锅，加姜煮开，撇去浮沫后捞出沥干。", "Start the pork in cold water. Once boiling, skim the foam and drain it very well.", "五花肉冷水下锅，煮开后撇净浮沫，再充分沥干。", 240, "water.waves", "High heat", "大火", nil, nil),
            step("caramel", "Make amber caramel", "炒出糖色", "Melt rock sugar with oil over low heat until amber, not dark brown.", "冰糖加少量油，小火融化到琥珀色，不要炒成深褐色。", "Melt the sugar slowly. Stop at amber—dark brown caramel will taste bitter.", "小火慢慢融化冰糖，变成琥珀色就停，太深会发苦。", 90, "sparkles", "Low heat", "小火", "Watch closely: caramel changes quickly near the end.", "糖色最后变化很快，要一直观察。"),
            step("brown", "Coat and brown", "上色煸香", "Add drained pork carefully and toss until every side is caramel-coated.", "小心放入沥干的肉块，翻炒到每一面都裹上糖色。", "Add the dry pork carefully. Toss until every piece is glossy and lightly browned.", "小心放入沥干的肉，翻炒到每块都油亮、微微焦香。", 150, "flame.fill", "Medium heat", "中火", nil, nil),
            step("season", "Build the braise", "加入炖煮调味", "Add wine, soy sauces, ginger, scallion, star anise, and hot water.", "加入黄酒、生抽、老抽、姜葱、八角和热水。", "Add the wine and soy sauces, then aromatics and enough hot water to nearly cover the pork.", "加入黄酒和酱油，再放香料和热水，水量接近没过肉。", 60, "drop.fill", "Medium heat", "中火", nil, nil),
            step("simmer", "Simmer until tender", "小火慢炖", "Cover and simmer gently until the skin and fat become tender.", "盖盖小火慢炖，直到肉皮和肥肉都变得软糯。", "Cover the pot and keep only a gentle simmer. Let time make the pork tender.", "盖上锅盖，保持轻轻冒泡，让时间把肉炖到软糯。", 2700, "hourglass", "Low heat", "小火", "Check once halfway and add hot water if the pan looks dry.", "中途检查一次，太干时补少量热水。"),
            step("glaze", "Reduce to a glaze", "大火收汁", "Uncover, remove aromatics, and reduce until the sauce clings and shines.", "开盖捞出香料，大火收汁到酱汁浓稠油亮。", "Remove the aromatics. Reduce the sauce until it coats every cube with a glossy glaze.", "捞出香料，把汤汁收到浓稠，均匀挂在每一块肉上。", 180, "checkmark.seal.fill", "High heat", "大火", nil, nil)
        ]
    )

    static let cantoneseSteamedFish = Recipe(
        id: "cantonese-steamed-fish",
        name: .init(en: "Cantonese Steamed Fish", zh: "粤式清蒸鱼"),
        subtitle: .init(en: "Learn the timing behind tender, flaky fish", zh: "掌握鱼肉鲜嫩不老的蒸制时间"),
        cuisine: .init(en: "Cantonese", zh: "粤菜"),
        totalMinutes: 20,
        difficulty: .medium,
        symbol: "fish.fill",
        colorHex: "3D8D8B",
        ingredients: [
            ingredient("fish", "Cleaned whole fish", "处理好的整鱼", "700 g", "1½ lb", "Fish fillet", "也可以使用鱼柳"),
            ingredient("ginger", "Fresh ginger", "生姜", "30 g", "1 oz", nil, nil),
            ingredient("scallion", "Scallions", "小葱", "4 stalks", "4 stalks", nil, nil),
            ingredient("soy", "Steamed-fish soy sauce", "蒸鱼豉油", "30 ml", "2 tbsp", "Light soy plus a pinch of sugar", "可以用生抽加少量糖"),
            ingredient("oil", "Neutral oil", "食用油", "30 ml", "2 tbsp", nil, nil),
            ingredient("salt", "Salt", "盐", "¼ tsp", "¼ tsp", nil, nil)
        ],
        steps: [
            step("dry", "Dry the fish", "擦干鱼身", "Pat the cleaned fish completely dry inside and out.", "把处理好的鱼里外都擦干。", "Pat the fish dry inside and out. A dry surface keeps the flavor clean.", "把鱼的里外都擦干，表面干爽，味道才更干净。", 60, "drop.triangle.fill", nil, nil, nil),
            step("score", "Score and season", "划刀轻腌", "Make two shallow cuts per side and rub with a very small pinch of salt.", "鱼身两面各划两刀，抹上很少量的盐。", "Make two shallow cuts on each side, then season very lightly with salt.", "鱼身两面各浅划两刀，再薄薄抹一点盐。", 75, "fork.knife", nil, nil, "Do not cut through the backbone.", "不要切到鱼骨。"),
            step("plate", "Set up the plate", "姜葱垫底", "Lay ginger and scallion whites under the fish on a heatproof plate.", "耐热盘中铺姜片和葱白，再放上整鱼。", "Set the fish over ginger and scallion whites so steam can move underneath.", "用姜片和葱白把鱼垫高一点，让蒸汽也能从底部通过。", 60, "rectangle.on.rectangle", nil, nil, nil),
            step("steam", "Steam over high heat", "旺火蒸鱼", "Wait for strong steam, add the fish, cover, and keep the heat high.", "蒸汽充足后放入鱼，盖好锅盖，全程保持大火。", "Put the fish in only when the steamer is fully steaming. Cover and keep high heat.", "蒸锅上汽后再放鱼，盖好锅盖，全程保持大火。", 480, "cloud.fill", "High heat", "大火", "Timing assumes a fish around 700 grams.", "这个时间适合约七百克的鱼。"),
            step("check", "Check the thickest part", "检查熟度", "The flesh should be opaque and lift from the backbone without resistance.", "最厚处鱼肉应变白，用筷子能轻松拨离鱼骨。", "Check the thickest part. The flesh should be opaque and release easily from the bone.", "检查鱼身最厚的位置，鱼肉变白并能轻松离骨就熟了。", nil, "checkmark.circle.fill", nil, nil, "If still translucent, steam 60 seconds more.", "如果还有透明感，再蒸六十秒。"),
            step("garnish", "Refresh the aromatics", "换上新姜葱", "Pour off cloudy liquid, discard cooked aromatics, and add fresh ginger and scallion.", "倒掉盘中浑浊汤汁，去掉旧姜葱，铺上新鲜姜葱丝。", "Pour off the cloudy liquid, remove the cooked aromatics, and add fresh shredded ginger and scallion.", "倒掉浑浊汤汁，拿走蒸过的姜葱，再铺上新鲜姜葱丝。", 60, "leaf.fill", nil, nil, nil),
            step("finish", "Finish with hot oil", "热油激香", "Pour hot oil over the aromatics, add soy sauce around the fish, and serve.", "热油淋在姜葱丝上，再沿鱼身周围加入蒸鱼豉油。", "Pour the hot oil over the fresh aromatics, then add soy sauce around—not over—the fish.", "把热油淋在新鲜姜葱丝上，再把豉油沿鱼身周围倒入，不要直接浇在鱼上。", 30, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static let danDanNoodles = Recipe(
        id: "dan-dan-noodles",
        name: .init(en: "Dan Dan Noodles", zh: "担担面"),
        subtitle: .init(en: "Spicy, nutty noodles built bowl by bowl", zh: "麻辣浓香，一碗一碗调出的川味面"),
        cuisine: .init(en: "Sichuan", zh: "川菜"),
        totalMinutes: 24,
        difficulty: .medium,
        symbol: "flame.fill",
        colorHex: "C73A28",
        ingredients: [
            ingredient("noodles", "Fresh wheat noodles", "鲜面条", "300 g", "10.5 oz", "Dried wheat noodles", "可以换成干面条"),
            ingredient("pork", "Ground pork", "猪肉末", "150 g", "5 oz", "Finely chopped mushrooms", "素食版可换成蘑菇末"),
            ingredient("sesame", "Sesame paste", "芝麻酱", "30 g", "2 tbsp", "Unsweetened peanut butter", "可以换成无糖花生酱"),
            ingredient("chili", "Chili oil", "辣椒油", "30 ml", "2 tbsp", nil, nil),
            ingredient("yacai", "Preserved mustard greens", "芽菜", "40 g", "¼ cup", "Finely chopped pickled mustard", "可以换成切碎的雪菜"),
            ingredient("greens", "Leafy greens", "青菜", "100 g", "3½ oz", nil, nil),
            ingredient("peanuts", "Roasted peanuts", "熟花生", "30 g", "¼ cup", nil, nil)
        ],
        steps: [
            step("sauce", "Build the bowl sauce", "调碗底", "Mix sesame paste, chili oil, soy, black vinegar, sugar, and garlic.", "芝麻酱、辣椒油、酱油、香醋、糖和蒜末搅匀。", "Mix the bowl sauce until the sesame paste is smooth and no lumps remain.", "把碗底调到顺滑，芝麻酱里不要留结块。", 60, "drop.circle.fill", nil, nil, nil),
            step("pork", "Crisp the pork", "炒酥肉末", "Stir-fry pork until separated, browned, and slightly crisp at the edges.", "肉末炒散，炒到焦香，边缘微微酥脆。", "Break the pork into small pieces and keep frying until the edges turn crisp.", "把肉末炒成小颗粒，继续炒到边缘微微酥脆。", 180, "flame.fill", "Medium-high heat", "中大火", nil, nil),
            step("preserved-greens", "Add the preserved greens", "加入芽菜", "Add preserved greens and scallion; stir until fragrant and fairly dry.", "加入芽菜和葱花，炒到香味出来、水分收干。", "Add the preserved greens and scallion. Fry until the topping smells fragrant and dry.", "加入芽菜和葱花，炒到香味出来，肉臊保持干香。", 60, "sparkles", "Medium heat", "中火", nil, nil),
            step("blanch-greens", "Blanch the greens", "焯青菜", "Cook leafy greens briefly in boiling noodle water, then lift them out.", "青菜放进煮面水里快速焯熟，捞出备用。", "Blanch the greens just until bright and tender, then lift them out.", "青菜焯到颜色鲜亮、刚刚变嫩，就马上捞出。", 30, "leaf.fill", "High heat", "大火", nil, nil),
            step("noodles", "Cook the noodles", "煮面条", "Boil noodles until just tender. Save a cup of noodle water before draining.", "面条煮到刚熟，捞面前留一杯面汤。", "Cook the noodles until just tender. Save some hot noodle water before you drain.", "面条煮到刚熟，捞出前记得留一些热面汤。", 180, "water.waves", "High heat", "大火", nil, nil),
            step("mix", "Mix while piping hot", "趁热拌匀", "Add hot noodles and a little noodle water to the sauce; mix thoroughly.", "热面和少量面汤加入碗底，快速充分拌匀。", "Add the hot noodles and a splash of noodle water. Mix until every strand is coated.", "把热面和一点面汤加入碗底，快速拌到每根面条都裹上酱汁。", 45, "arrow.triangle.2.circlepath", nil, nil, nil),
            step("finish", "Top and serve", "铺料上桌", "Top with pork, greens, peanuts, and scallion. Add chili oil to taste.", "铺上肉臊、青菜、花生和葱花，按口味补辣椒油。", "Top with the crisp pork, greens, peanuts, and scallion. Serve immediately.", "铺上肉臊、青菜、花生和葱花，马上享用。", nil, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static let smashedCucumber = Recipe(
        id: "smashed-cucumber",
        name: .init(en: "Smashed Cucumber", zh: "拍黄瓜"),
        subtitle: .init(en: "A crisp, garlicky cold dish in twelve minutes", zh: "十二分钟完成的爽脆蒜香凉菜"),
        cuisine: .init(en: "Northern Home Cooking", zh: "北方家常菜"),
        totalMinutes: 12,
        difficulty: .easy,
        symbol: "leaf.fill",
        colorHex: "3D9C56",
        ingredients: [
            ingredient("cucumber", "Small cucumbers", "小黄瓜", "500 g", "1.1 lb", "English cucumber", "可以换成无籽黄瓜"),
            ingredient("garlic", "Garlic", "大蒜", "4 cloves", "4 cloves", nil, nil),
            ingredient("vinegar", "Chinese black vinegar", "香醋", "20 ml", "1⅓ tbsp", "Rice vinegar", "可以换成米醋"),
            ingredient("soy", "Light soy sauce", "生抽", "15 ml", "1 tbsp", nil, nil),
            ingredient("sesame", "Sesame oil", "香油", "10 ml", "2 tsp", nil, nil),
            ingredient("chili", "Chili oil", "辣椒油", "10 ml", "2 tsp", "Optional", "可省略")
        ],
        steps: [
            step("wash", "Wash and dry", "洗净擦干", "Rinse the cucumbers and dry them so the dressing will cling.", "黄瓜洗净并擦干，料汁才容易附着。", "Wash the cucumbers, then dry the skins thoroughly.", "把黄瓜洗干净，再把表皮的水彻底擦干。", 60, "drop.fill", nil, nil, nil),
            step("smash", "Smash to open the texture", "拍出裂纹", "Press firmly with the flat of a cleaver until the cucumbers split.", "用刀面稳稳拍压，直到黄瓜自然裂开。", "Use the flat side of a cleaver to press and crack the cucumbers. Keep the blade facing away.", "用刀面按压拍裂黄瓜，刀刃始终朝外，注意安全。", nil, "hammer.fill", nil, nil, "A rolling pin also works.", "没有中式菜刀也可以用擀面杖。"),
            step("cut", "Cut rustic pieces", "切成滚刀块", "Cut the cracked cucumbers into irregular bite-size pieces.", "把拍裂的黄瓜切成方便入口的不规则小块。", "Cut the cracked cucumbers into rustic bite-size pieces. Rough edges hold more sauce.", "把拍裂的黄瓜切成入口大小，粗糙断面能挂住更多料汁。", 60, "fork.knife", nil, nil, nil),
            step("salt", "Salt and rest", "加盐杀水", "Toss with salt and rest in a colander to draw out excess water.", "拌入盐，放在滤篮中静置，让多余水分渗出。", "Toss with salt and let the cucumber drain. This keeps the final salad crisp.", "拌盐后静置沥水，这一步能让成品保持爽脆。", 600, "hourglass", nil, nil, nil),
            step("drain", "Drain and dry again", "沥干再擦水", "Discard the released liquid and pat the cucumber pieces dry.", "倒掉渗出的水，再把黄瓜表面轻轻擦干。", "Discard the cucumber water, then pat the pieces dry one more time.", "倒掉黄瓜水，再把黄瓜块表面擦干一次。", 45, "arrow.down.to.line", nil, nil, nil),
            step("dress", "Mix the dressing", "拌入料汁", "Mix garlic, vinegar, soy, sesame oil, sugar, and chili oil; toss well.", "蒜末、香醋、生抽、香油、糖和辣椒油调匀，与黄瓜拌匀。", "Mix the dressing and toss it through the cucumber until every rough edge is coated.", "调好料汁，与黄瓜充分拌匀，让每个断面都裹上味道。", 60, "drop.circle.fill", nil, nil, nil),
            step("serve", "Taste and serve", "尝味装盘", "Taste for salt, add sesame or cilantro, and serve chilled or immediately.", "尝一下咸淡，撒芝麻或香菜，冷藏后或直接享用。", "Taste once more, add sesame or cilantro, and serve. Your cold dish is ready.", "再尝一下咸淡，撒上芝麻或香菜，这道凉菜就完成了。", nil, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static let blackPepperBeef = Recipe(
        id: "black-pepper-beef",
        name: .init(en: "Black Pepper Beef", zh: "黑椒牛肉"),
        subtitle: .init(en: "Tender beef and crisp peppers in a bold sauce", zh: "嫩滑牛肉配爽脆彩椒和浓郁黑椒汁"),
        cuisine: .init(en: "Cantonese", zh: "粤菜"),
        totalMinutes: 25,
        difficulty: .medium,
        symbol: "bolt.fill",
        colorHex: "8C4B31",
        ingredients: [
            ingredient("beef", "Flank or sirloin steak", "牛里脊或侧腹牛排", "400 g", "14 oz", nil, nil),
            ingredient("peppers", "Mixed bell peppers", "彩椒", "250 g", "9 oz", nil, nil),
            ingredient("onion", "Onion", "洋葱", "120 g", "4 oz", nil, nil),
            ingredient("pepper", "Coarsely ground black pepper", "粗粒黑胡椒", "2 tsp", "2 tsp", nil, nil),
            ingredient("sauce", "Soy + oyster sauce", "生抽＋蚝油", "45 ml", "3 tbsp", nil, nil),
            ingredient("starch", "Cornstarch", "玉米淀粉", "2 tsp", "2 tsp", nil, nil)
        ],
        steps: [
            step("slice", "Slice across the grain", "逆纹切片", "Find the muscle lines and slice thinly across them, not along them.", "看清牛肉纹理，横着纹理切薄片，不要顺纹切。", "Find the long muscle lines and cut across them into thin, even slices.", "找到牛肉的长纹理，逆着纹路切成均匀薄片。", 180, "fork.knife", nil, nil, "Cutting across the grain makes every bite tender.", "逆纹切断肌肉纤维，牛肉更容易嫩。"),
            step("marinate", "Marinate for tenderness", "腌制牛肉", "Mix beef with soy, starch, water, and oil until no liquid remains.", "牛肉加入生抽、淀粉、水和油，抓到碗底看不见液体。", "Massage in soy, starch, water, and oil until the beef absorbs everything.", "把生抽、淀粉、水和油抓进牛肉里，直到碗底没有液体。", 600, "hourglass", nil, nil, nil),
            step("prep", "Cut the vegetables", "切好彩椒洋葱", "Cut peppers and onion into similar bite-size pieces.", "彩椒和洋葱切成大小接近、方便入口的小块。", "Cut the peppers and onion into similar pieces so they cook evenly.", "彩椒和洋葱切成相近大小，受热才会均匀。", 150, "square.grid.3x3.fill", nil, nil, nil),
            step("sauce", "Mix the pepper sauce", "调黑椒汁", "Mix black pepper, soy, oyster sauce, sugar, and water.", "黑胡椒、生抽、蚝油、糖和水搅匀。", "Mix the sauce now and keep it close to the stove. This stir-fry moves fast.", "现在把黑椒汁调好并放在手边，开始炒以后动作会很快。", 60, "drop.circle.fill", nil, nil, nil),
            step("sear", "Sear the beef fast", "大火快煎", "Spread beef in a very hot wok, brown one side, then toss until nearly cooked.", "牛肉铺入很热的锅中，一面煎上色后快速翻炒到接近熟。", "Spread the beef in one layer. Let it brown, then toss quickly and remove before fully cooked.", "把牛肉铺成一层，煎上色后快速翻炒，在完全熟透前先盛出。", 120, "flame.fill", "High heat", "大火", nil, nil),
            step("vegetables", "Keep the peppers crisp", "快炒彩椒", "Stir-fry peppers and onion until bright and crisp-tender.", "彩椒和洋葱快速翻炒到颜色鲜亮、刚刚断生。", "Stir-fry the vegetables quickly. Keep their color bright and texture crisp.", "快速翻炒蔬菜，保持颜色鲜亮和爽脆口感。", 90, "leaf.fill", "High heat", "大火", nil, nil),
            step("finish", "Glaze and finish", "回锅裹汁", "Return beef, add sauce, and toss just until glossy and cooked through.", "牛肉回锅，加入黑椒汁，翻到油亮并刚好熟透。", "Return the beef and add the sauce. Toss only until the glaze clings, then serve.", "把牛肉倒回锅并加入酱汁，翻到酱汁均匀挂住就马上出锅。", 60, "checkmark.seal.fill", "High heat", "大火", nil, nil)
        ]
    )

    static let sweetSourPork = Recipe(
        id: "sweet-sour-pork",
        name: .init(en: "Sweet & Sour Pork", zh: "糖醋里脊"),
        subtitle: .init(en: "Crisp pork in a bright, balanced glaze", zh: "外酥里嫩，酸甜平衡的经典味道"),
        cuisine: .init(en: "Cantonese", zh: "粤菜"),
        totalMinutes: 35,
        difficulty: .medium,
        symbol: "heart.fill",
        colorHex: "D94E32",
        ingredients: [
            ingredient("pork", "Pork tenderloin", "猪里脊", "400 g", "14 oz", nil, nil),
            ingredient("starch", "Cornstarch", "玉米淀粉", "80 g", "⅔ cup", nil, nil),
            ingredient("ketchup", "Ketchup", "番茄酱", "60 g", "¼ cup", nil, nil),
            ingredient("vinegar", "Rice vinegar", "米醋", "45 ml", "3 tbsp", nil, nil),
            ingredient("sugar", "Sugar", "糖", "45 g", "3½ tbsp", nil, nil),
            ingredient("produce", "Bell peppers + pineapple", "彩椒＋菠萝", "250 g", "9 oz", nil, nil),
            ingredient("oil", "Frying oil", "炸制用油", "As needed", "As needed", nil, nil)
        ],
        steps: [
            step("marinate", "Cut and marinate", "切条腌制", "Cut pork into even strips. Mix with salt, wine, and a little beaten egg.", "里脊切均匀长条，加入盐、料酒和少量蛋液抓匀。", "Cut even pork strips and marinate with salt, wine, and a little beaten egg.", "里脊切成均匀长条，用盐、料酒和少量蛋液抓匀腌制。", 600, "hourglass", nil, nil, nil),
            step("sauce", "Balance the sauce", "调糖醋汁", "Mix ketchup, vinegar, sugar, soy, and water; taste for sweet-sour balance.", "番茄酱、米醋、糖、生抽和水调匀，尝一下酸甜平衡。", "Mix the sauce and taste it now. It should be clearly sweet and sour, not only sweet.", "把糖醋汁调匀并先尝一下，应该酸甜都明显，不能只有甜味。", 60, "drop.circle.fill", nil, nil, nil),
            step("coat", "Coat every piece", "均匀裹粉", "Coat pork generously in dry cornstarch and press it onto the surface.", "里脊充分裹上干淀粉，用手轻压，让粉附着牢固。", "Coat every strip with dry starch. Press gently so no wet spots remain.", "每根肉条都裹满干淀粉，轻轻按压，不要留下湿润位置。", 120, "snowflake", nil, nil, nil),
            step("fry", "Fry until crisp", "炸到酥脆", "Fry in batches until pale golden and crisp, then drain on a rack.", "分批炸到浅金黄、表面酥脆，捞出放在网架上沥油。", "Fry in small batches so the oil stays hot. Remove when crisp and pale golden.", "分小批炸，保持油温。表面酥脆、颜色浅金黄时捞出。", 240, "flame.fill", "Medium-high heat", "中大火", "Do not crowd the pan.", "不要一次放太多，否则油温会下降。"),
            step("vegetables", "Flash-fry the produce", "快炒彩椒菠萝", "Stir-fry peppers, onion, and pineapple briefly so they stay bright.", "彩椒、洋葱和菠萝快速翻炒，保持颜色鲜亮。", "Flash-fry the peppers, onion, and pineapple. Keep them bright and crisp.", "快速翻炒彩椒、洋葱和菠萝，保持颜色鲜亮、口感清脆。", 90, "leaf.fill", "High heat", "大火", nil, nil),
            step("thicken", "Bubble the sauce", "熬浓糖醋汁", "Pour in sauce and boil until large bubbles form and it lightly coats the spatula.", "倒入糖醋汁，煮到出现大泡、能薄薄挂在锅铲上。", "Boil the sauce until the bubbles grow large and the glaze lightly coats your spatula.", "把酱汁煮到气泡变大，并能薄薄挂住锅铲。", 60, "waveform.path", "Medium-high heat", "中大火", nil, nil),
            step("finish", "Toss and serve fast", "快速裹汁出锅", "Return pork and vegetables, toss quickly to coat, and serve before the crust softens.", "肉和配菜回锅，快速翻到裹汁，趁外壳仍酥脆马上装盘。", "Return everything and toss quickly. Once every piece shines, serve immediately.", "把所有食材倒回锅快速裹汁，每一块都油亮后马上出锅。", 45, "checkmark.seal.fill", "High heat", "大火", nil, nil)
        ]
    )
}
