import Foundation

enum SampleRecipes {
    static let all: [Recipe] = [
        tomatoEggs,
        redBraisedPork,
        cantoneseSteamedFish,
        eggFriedRice,
        smashedCucumber,
        kungPaoChicken,
        mapoTofu,
        danDanNoodles,
        blackPepperBeef,
        sweetSourPork,
        garlicBroccoli,
        scallionOilNoodles
    ] + CatalogRecipes.all

    static func recipe(id: String) -> Recipe? { all.first { $0.id == id } }

    static let tomatoEggs = Recipe(
        id: "tomato-eggs",
        name: .init(en: "Tomato & Eggs", zh: "番茄炒蛋"),
        subtitle: .init(en: "The perfect first Chinese home dish", zh: "中国家常菜的第一课"),
        cuisine: .init(en: "Chinese Home Cooking", zh: "中式家常菜"),
        totalMinutes: 15,
        difficulty: .easy,
        symbol: "sun.max.fill",
        colorHex: "F25A24",
        ingredients: [
            ingredient("eggs", "Eggs", "鸡蛋", "3", "3", "Large eggs work best", "大号鸡蛋更合适"),
            ingredient("tomatoes", "Ripe tomatoes", "熟番茄", "300 g", "10.5 oz", "Use cherry tomatoes if needed", "也可以用圣女果"),
            ingredient("scallion", "Scallion", "小葱", "1 stalk", "1 stalk", "Optional", "可省略"),
            ingredient("oil", "Cooking oil", "食用油", "25 ml", "1½ tbsp", "Neutral oil", "使用味道清淡的油"),
            ingredient("seasoning", "Salt + sugar", "盐＋糖", "½ tsp each", "½ tsp each", nil, nil)
        ],
        steps: [
            step("prep", "Prep first", "备好食材", "Cut each tomato into 6 wedges. Crack the eggs into a bowl.", "番茄切成六瓣，鸡蛋打入碗中。", "Cut the tomatoes into wedges, then crack three eggs into a bowl.", "把番茄切成小块，再把三个鸡蛋打进碗里。", nil, "takeoutbag.and.cup.and.straw.fill", nil, nil, "Keep the tomato juice—it becomes the sauce.", "番茄汁不要倒掉，它会变成汤汁。"),
            step("whisk", "Whisk the eggs", "打散鸡蛋", "Add a pinch of salt and whisk until the whites disappear.", "加一小撮盐，搅打到看不见蛋白。", "Add a pinch of salt and whisk the eggs until smooth.", "加一小撮盐，把鸡蛋充分打散。", 25, "fork.knife", nil, nil, nil),
            step("heat-pan", "Heat the wok", "热锅", "Place the wok over high heat until it feels hot above the surface.", "大火把锅烧热，手放在锅上方能感到明显热气。", "Heat the wok over high heat. Keep your hand safely above it—never touch the pan.", "开大火把锅烧热。手只放在锅上方感受热气，不要碰锅。", 45, "flame.fill", "High heat", "大火", "A hot wok keeps the eggs fluffy.", "锅够热，鸡蛋才会蓬松。"),
            step("cook-eggs", "Cook the eggs", "炒鸡蛋", "Add half the oil. Pour in the eggs and fold large curds toward the center.", "倒入一半油，加入蛋液，把凝固的蛋块向中间轻推。", "Add half the oil. Pour in the eggs. Gently fold—do not break them into tiny pieces.", "倒入一半油和蛋液，轻轻推成大块，不要炒得太碎。", 55, "circle.grid.cross.fill", "Medium-high heat", "中大火", nil, nil),
            step("remove-eggs", "Take eggs out", "盛出鸡蛋", "Remove the eggs while still glossy. They will finish cooking later.", "鸡蛋还有光泽时就盛出，之后还会再次入锅。", "Take the eggs out now, while they still look a little glossy.", "现在把鸡蛋盛出来，表面微微湿润正合适。", nil, "arrow.up.circle.fill", nil, nil, nil),
            step("cook-tomatoes", "Soften tomatoes", "炒软番茄", "Add the remaining oil and tomatoes. Add salt and sugar, then stir until juicy.", "倒入剩余的油和番茄，加盐和糖，翻炒到番茄出汁。", "Add the tomatoes, salt, and sugar. Stir until the tomatoes release plenty of juice.", "加入番茄、盐和糖，翻炒到番茄明显出汁。", 150, "drop.fill", "Medium heat", "中火", "If the pan is dry, add one tablespoon of water.", "如果锅里太干，可以加一汤匙水。"),
            step("combine", "Bring it together", "鸡蛋回锅", "Return the eggs and fold through the tomato sauce for 30 seconds.", "鸡蛋倒回锅中，和番茄汤汁轻轻翻匀三十秒。", "Return the eggs. Gently fold them through the tomato sauce for thirty seconds.", "把鸡蛋倒回锅里，和番茄汤汁轻轻翻匀三十秒。", 30, "arrow.triangle.2.circlepath", "Medium heat", "中火", nil, nil),
            step("serve", "Taste and serve", "尝味出锅", "Taste, adjust salt, add scallion, and serve with rice.", "尝一下咸淡，撒上小葱，配米饭出锅。", "Taste it. Add a little salt only if needed. Sprinkle scallion and serve.", "尝一下咸淡，需要的话再补一点盐，撒上小葱就可以出锅了。", nil, "checkmark.seal.fill", nil, nil, "You made a classic Chinese home dish.", "你完成了一道经典中国家常菜。")
        ]
    )

    static let kungPaoChicken = Recipe(
        id: "kung-pao-chicken",
        name: .init(en: "Kung Pao Chicken", zh: "宫保鸡丁"),
        subtitle: .init(en: "Sweet, sour, spicy—and easier than it looks", zh: "甜酸微辣，比想象中简单"),
        cuisine: .init(en: "Sichuan", zh: "川菜"),
        totalMinutes: 28,
        difficulty: .medium,
        symbol: "flame.fill",
        colorHex: "C93B27",
        ingredients: [
            ingredient("chicken", "Boneless chicken thigh", "去骨鸡腿肉", "350 g", "12 oz", "Chicken breast", "可以换成鸡胸肉"),
            ingredient("peanuts", "Roasted peanuts", "熟花生米", "50 g", "⅓ cup", "Cashews", "可以换成腰果"),
            ingredient("chili", "Dried chilies", "干辣椒", "6", "6", "Use fewer for mild heat", "怕辣可以减量"),
            ingredient("aromatics", "Scallion, ginger, garlic", "葱姜蒜", "1 small bowl", "1 small bowl", nil, nil),
            ingredient("sauce", "Soy, vinegar, sugar, starch", "酱油、醋、糖、淀粉", "1 bowl", "1 bowl", nil, nil)
        ],
        steps: [
            step("dice", "Cut and marinate", "切丁腌制", "Cut chicken into 2 cm cubes. Mix with soy sauce and starch.", "鸡肉切两厘米小丁，加入酱油和淀粉抓匀。", "Cut the chicken into bite-size cubes, then coat with soy sauce and starch.", "鸡肉切成入口大小的丁，再用酱油和淀粉抓匀。", 300, "square.grid.3x3.fill", nil, nil, nil),
            step("sauce", "Mix the sauce", "调宫保汁", "Mix soy sauce, black vinegar, sugar, water, and starch until smooth.", "酱油、香醋、糖、水和淀粉调匀。", "Mix the sauce now. Stir until there are no starch lumps.", "现在调好宫保汁，搅到看不见淀粉颗粒。", 60, "drop.circle.fill", nil, nil, nil),
            step("heat", "Heat the wok", "烧热炒锅", "Heat the wok over high heat, then add oil.", "大火烧热炒锅，再加入油。", "Heat the wok over high heat. Add oil when the wok is hot.", "大火把锅烧热，锅热后再加油。", 50, "flame.fill", "High heat", "大火", nil, nil),
            step("chicken", "Sear the chicken", "滑炒鸡丁", "Spread chicken in one layer, wait briefly, then stir until almost cooked.", "鸡丁铺开，短暂停留后翻炒到基本熟透。", "Spread the chicken in one layer. Let it sear, then stir until nearly cooked.", "把鸡丁铺成一层，先煎一下，再翻炒到基本熟透。", 150, "bolt.fill", "High heat", "大火", nil, nil),
            step("aromatics", "Wake up the spices", "炒香料头", "Add chilies, ginger, garlic, and scallion. Stir until fragrant.", "加入干辣椒、姜、蒜和葱，炒出香味。", "Add the chilies and aromatics. Stir until fragrant, but do not burn them.", "加入辣椒和葱姜蒜，炒出香味，注意不要炒糊。", 40, "sparkles", "Medium-high heat", "中大火", nil, nil),
            step("glaze", "Add the sauce", "倒入宫保汁", "Stir the sauce again, pour it around the wok, and toss quickly.", "宫保汁再次搅匀，沿锅边倒入，快速翻炒。", "Stir the sauce once more, pour it in, and toss quickly as it thickens.", "宫保汁再搅一下，倒入锅中，变浓时快速翻炒。", 45, "arrow.triangle.2.circlepath", "High heat", "大火", nil, nil),
            step("finish", "Finish with peanuts", "花生收尾", "Turn off the heat, fold in peanuts, and serve immediately.", "关火，拌入花生米，立即装盘。", "Turn off the heat. Fold in the peanuts and serve right away.", "现在关火，拌入花生米，马上装盘。", nil, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static let mapoTofu = Recipe(
        id: "mapo-tofu",
        name: .init(en: "Mapo Tofu", zh: "麻婆豆腐"),
        subtitle: .init(en: "Silky tofu in a bold Sichuan sauce", zh: "嫩豆腐配浓郁川味酱汁"),
        cuisine: .init(en: "Sichuan", zh: "川菜"),
        totalMinutes: 25,
        difficulty: .medium,
        symbol: "circle.hexagongrid.fill",
        colorHex: "D94A32",
        ingredients: [
            ingredient("tofu", "Soft or medium tofu", "嫩豆腐或软豆腐", "450 g", "16 oz", nil, nil),
            ingredient("pork", "Ground pork", "猪肉末", "120 g", "4 oz", "Mushrooms for a vegetarian version", "素食版可换成蘑菇末"),
            ingredient("doubanjiang", "Chili bean paste", "郫县豆瓣酱", "1½ tbsp", "1½ tbsp", "Other chili bean paste", "可以用其他辣豆瓣酱"),
            ingredient("broth", "Stock or water", "高汤或清水", "250 ml", "1 cup", nil, nil),
            ingredient("pepper", "Sichuan pepper", "花椒", "½ tsp", "½ tsp", "Optional, but characteristic", "可省略，但它是麻味来源")
        ],
        steps: [
            step("tofu", "Prepare the tofu", "处理豆腐", "Cut tofu into 2 cm cubes. Slide them gently into salted hot water.", "豆腐切两厘米方块，轻轻滑入加盐的热水中。", "Cut the tofu into cubes. Handle it gently so the pieces stay whole.", "豆腐切成小方块，动作轻一点，尽量保持完整。", 180, "square.grid.3x3.fill", nil, nil, nil),
            step("pork", "Brown the pork", "炒香肉末", "Heat oil and stir-fry pork until separated and lightly browned.", "热油，下肉末炒散，直到微微焦香。", "Stir-fry the pork until the pieces separate and turn lightly brown.", "把肉末炒散，炒到边缘微微焦黄。", 150, "flame.fill", "Medium-high heat", "中大火", nil, nil),
            step("paste", "Fry the bean paste", "炒豆瓣酱", "Lower the heat. Add bean paste and stir until the oil turns red.", "转小火，加入豆瓣酱，炒到油色变红。", "Lower the heat. Stir the bean paste until the oil turns red and fragrant.", "转小火炒豆瓣酱，炒到红油出现、香味出来。", 70, "paintbrush.pointed.fill", "Low heat", "小火", "Low heat prevents the paste from burning.", "小火能避免豆瓣酱发苦。"),
            step("simmer", "Build the sauce", "煮酱汁", "Add stock and bring to a gentle simmer.", "加入高汤，煮到轻轻冒泡。", "Add the stock and bring the sauce to a gentle simmer.", "加入高汤，把酱汁煮到轻轻冒泡。", 120, "drop.fill", "Medium heat", "中火", nil, nil),
            step("add-tofu", "Add tofu gently", "轻放豆腐", "Drain tofu and slide it into the sauce. Nudge the pan instead of stirring hard.", "豆腐沥水后滑入锅中，轻晃锅，不要用力翻。", "Slide in the tofu. Move the pan gently—do not mash the tofu with your spatula.", "把豆腐轻轻滑进锅里，晃锅就好，不要用锅铲把它弄碎。", 240, "square.on.square.fill", "Medium-low heat", "中小火", nil, nil),
            step("thicken", "Thicken in two rounds", "分两次勾芡", "Add half the starch slurry, wait, then add the rest until glossy.", "先加一半水淀粉，稍等片刻，再加剩余部分到汤汁油亮。", "Add half the starch water. Wait ten seconds, then add more until the sauce turns glossy.", "先加一半水淀粉，等十秒，再补到汤汁浓稠油亮。", 50, "waveform.path", "Medium heat", "中火", nil, nil),
            step("serve", "Finish with pepper", "花椒收尾", "Turn off heat, sprinkle Sichuan pepper and scallion, then serve.", "关火，撒花椒粉和葱花，装盘。", "Turn off the heat. Sprinkle Sichuan pepper and scallion. Your mapo tofu is ready.", "关火，撒上花椒粉和葱花。麻婆豆腐完成了。", nil, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static let eggFriedRice = Recipe(
        id: "egg-fried-rice",
        name: .init(en: "Egg Fried Rice", zh: "蛋炒饭"),
        subtitle: .init(en: "Turn leftover rice into a complete meal", zh: "把隔夜饭变成一顿完整家常饭"),
        cuisine: .init(en: "Chinese Home Cooking", zh: "中式家常菜"),
        totalMinutes: 18,
        difficulty: .easy,
        symbol: "takeoutbag.and.cup.and.straw.fill",
        colorHex: "E88422",
        ingredients: [
            ingredient("rice", "Cold cooked rice", "冷米饭", "400 g", "3 cups", "Fresh rice cooled on a tray", "新米饭摊开放凉后也可以"),
            ingredient("eggs", "Eggs", "鸡蛋", "2", "2", nil, nil),
            ingredient("peas", "Peas", "青豆", "60 g", "½ cup", "Corn", "可以换成玉米粒"),
            ingredient("carrot", "Carrot", "胡萝卜", "60 g", "½ cup", nil, nil),
            ingredient("scallion", "Scallions", "小葱", "2 stalks", "2 stalks", nil, nil),
            ingredient("soy", "Light soy sauce", "生抽", "15 ml", "1 tbsp", nil, nil)
        ],
        steps: [
            step("rice", "Loosen the rice", "把米饭拨散", "Break cold rice into separate grains. Remove any hard clumps.", "把冷米饭拨散成一粒一粒，去掉过硬的结块。", "Loosen the cold rice before the wok gets hot. Separate every large clump.", "先把冷米饭拨散，再开始热锅。大的饭团都要拆开。", 60, "circle.grid.3x3.fill", nil, nil, "Cold, dry rice fries into distinct grains.", "冷而偏干的米饭更容易炒得粒粒分明。"),
            step("prep", "Prep the add-ins", "备好配料", "Whisk the eggs. Dice the carrot and slice the scallions.", "鸡蛋打散，胡萝卜切小丁，小葱切圈。", "Whisk the eggs, dice the carrot small, and slice the scallions.", "把鸡蛋打散，胡萝卜切成小丁，小葱切成葱花。", 90, "fork.knife", nil, nil, nil),
            step("scramble", "Scramble the eggs", "炒散鸡蛋", "Heat oil over medium-high heat. Add eggs and fold into soft pieces.", "中大火热油，倒入蛋液，轻推成柔软蛋块。", "Add the eggs to the hot wok and fold them into soft pieces. Do not overcook.", "蛋液倒入热锅，轻轻推成柔软蛋块，不要炒老。", 55, "circle.grid.cross.fill", "Medium-high heat", "中大火", nil, nil),
            step("aromatics", "Fry the vegetables", "炒香配菜", "Add carrot, peas, and half the scallions. Stir until fragrant.", "加入胡萝卜、青豆和一半葱花，翻炒出香味。", "Add the vegetables and half the scallions. Stir until bright and fragrant.", "加入蔬菜和一半葱花，炒到颜色鲜亮、香味出来。", 75, "leaf.fill", "Medium-high heat", "中大火", nil, nil),
            step("fry-rice", "Fry the rice", "炒散米饭", "Add rice. Press and toss until the grains are hot and separate.", "加入米饭，边压边翻炒，直到米粒热透并散开。", "Add the rice. Press apart every clump, then toss until all the grains are hot.", "加入米饭，把结块压散，再翻炒到每一粒都热透。", 150, "flame.fill", "High heat", "大火", "Keep the rice moving so it does not stick.", "持续翻动米饭，避免粘锅。"),
            step("season", "Season around the wok", "沿锅边调味", "Pour soy sauce around the hot edge. Add salt and toss quickly.", "生抽沿热锅边淋入，加少量盐，快速翻匀。", "Pour the soy sauce around the hot side of the wok, then toss quickly.", "把生抽沿着热锅边淋入，然后快速翻匀。", 45, "drop.fill", "High heat", "大火", nil, nil),
            step("finish", "Finish and serve", "收尾出锅", "Fold the eggs back in, add remaining scallions, taste, and serve.", "鸡蛋回锅，加入剩余葱花，尝味后装盘。", "Fold the eggs back in. Add the remaining scallions, taste, and serve.", "把鸡蛋倒回锅，加入剩余葱花，尝一下咸淡就可以出锅了。", nil, "checkmark.seal.fill", nil, nil, "You just rescued leftover rice.", "你把剩米饭变成了一顿好吃的饭。")
        ]
    )

    static let garlicBroccoli = Recipe(
        id: "garlic-broccoli",
        name: .init(en: "Garlic Broccoli", zh: "蒜蓉西兰花"),
        subtitle: .init(en: "Bright green, crisp, and full of garlic", zh: "翠绿爽脆，蒜香十足"),
        cuisine: .init(en: "Chinese Home Cooking", zh: "中式家常菜"),
        totalMinutes: 16,
        difficulty: .easy,
        symbol: "leaf.fill",
        colorHex: "47A447",
        ingredients: [
            ingredient("broccoli", "Broccoli", "西兰花", "450 g", "1 lb", nil, nil),
            ingredient("garlic", "Garlic", "大蒜", "5 cloves", "5 cloves", nil, nil),
            ingredient("oil", "Cooking oil", "食用油", "20 ml", "1½ tbsp", nil, nil),
            ingredient("oyster", "Oyster sauce", "蚝油", "15 ml", "1 tbsp", "Vegetarian oyster sauce", "可以换成素蚝油"),
            ingredient("starch", "Cornstarch", "玉米淀粉", "1 tsp", "1 tsp", nil, nil),
            ingredient("salt", "Salt", "盐", "½ tsp", "½ tsp", nil, nil)
        ],
        steps: [
            step("cut", "Cut even florets", "切成均匀小朵", "Cut broccoli into similar bite-size florets so they cook evenly.", "西兰花切成大小接近、方便入口的小朵，受热才均匀。", "Cut the broccoli into similar bite-size florets. Keep the tender stem pieces too.", "把西兰花切成大小接近的小朵，嫩茎也可以保留。", 120, "leaf.fill", nil, nil, nil),
            step("wash", "Wash thoroughly", "彻底洗净", "Soak briefly in clean water, swish, then rinse and drain.", "清水中短暂浸泡并轻轻搅动，再冲洗沥水。", "Swish the broccoli in clean water, rinse it well, and drain.", "把西兰花在清水里轻轻搅洗，再冲净沥水。", 90, "drop.fill", nil, nil, nil),
            step("sauce", "Mix the sauce", "调好料汁", "Mix oyster sauce, starch, three tablespoons water, and a pinch of salt.", "蚝油、淀粉、三汤匙水和一小撮盐搅匀。", "Mix the oyster sauce, starch, water, and a small pinch of salt until smooth.", "把蚝油、淀粉、水和一小撮盐搅到顺滑。", 45, "drop.circle.fill", nil, nil, nil),
            step("blanch", "Blanch until bright green", "焯到翠绿", "Boil salted water. Add broccoli and cook until vivid green and barely tender.", "盐水烧开，放入西兰花，煮到翠绿、刚刚变嫩。", "Add the broccoli to boiling salted water. Cook until bright green and just tender.", "把西兰花放进沸腾的盐水，焯到翠绿、刚刚变嫩。", 90, "water.waves", "High heat", "大火", "Do not blanch too long or it will lose its crunch.", "不要焯太久，否则会失去爽脆口感。"),
            step("drain", "Drain it well", "充分沥水", "Lift out the broccoli and shake off as much water as possible.", "捞出西兰花，尽量把水分沥干。", "Drain the broccoli very well. Extra water will dilute the sauce.", "把西兰花充分沥干，多余的水会冲淡料汁。", 30, "arrow.down.to.line", nil, nil, nil),
            step("garlic", "Sizzle the garlic", "爆香蒜末", "Heat oil over medium heat. Add minced garlic and stir until fragrant.", "中火热油，加入蒜末，炒到香味出来。", "Add the minced garlic to warm oil. Stir just until fragrant—do not brown it.", "蒜末放进温热的油里，炒出香味就好，不要炒焦。", 35, "sparkles", "Medium heat", "中火", nil, nil),
            step("finish", "Glaze and serve", "裹汁出锅", "Add broccoli and sauce. Toss until glossy, then serve immediately.", "加入西兰花和料汁，翻到均匀油亮，立即装盘。", "Add the broccoli and sauce. Toss until every floret is glossy, then serve.", "加入西兰花和料汁，翻到每一朵都油亮裹汁，就可以出锅了。", 45, "checkmark.seal.fill", "High heat", "大火", nil, nil)
        ]
    )

    static let scallionOilNoodles = Recipe(
        id: "scallion-oil-noodles",
        name: .init(en: "Scallion Oil Noodles", zh: "葱油拌面"),
        subtitle: .init(en: "A Shanghai classic with deep scallion aroma", zh: "葱香浓郁的上海经典面食"),
        cuisine: .init(en: "Shanghai", zh: "上海菜"),
        totalMinutes: 20,
        difficulty: .easy,
        symbol: "lines.measurement.horizontal",
        colorHex: "B86A2B",
        ingredients: [
            ingredient("noodles", "Fresh wheat noodles", "鲜面条", "300 g", "10.5 oz", "Dried wheat noodles", "可以换成干面条"),
            ingredient("scallions", "Scallions", "小葱", "6 stalks", "6 stalks", nil, nil),
            ingredient("oil", "Neutral oil", "食用油", "60 ml", "¼ cup", nil, nil),
            ingredient("soy", "Light soy sauce", "生抽", "30 ml", "2 tbsp", nil, nil),
            ingredient("dark-soy", "Dark soy sauce", "老抽", "10 ml", "2 tsp", nil, nil),
            ingredient("sugar", "Sugar", "糖", "2 tsp", "2 tsp", nil, nil)
        ],
        steps: [
            step("sauce", "Mix the noodle sauce", "调拌面汁", "Mix light soy, dark soy, sugar, and two tablespoons water.", "生抽、老抽、糖和两汤匙水搅匀。", "Mix both soy sauces with sugar and water. Stir until the sugar starts to dissolve.", "把生抽、老抽、糖和水搅匀，让糖开始融化。", 45, "drop.circle.fill", nil, nil, nil),
            step("cut-scallion", "Cut the scallions", "切小葱", "Pat scallions dry and cut into 5 cm lengths.", "小葱擦干水分，切成五厘米左右的段。", "Dry the scallions well, then cut them into even finger-length pieces.", "把小葱擦干，再切成长度均匀的葱段。", 75, "fork.knife", nil, nil, "Dry scallions keep hot oil from splattering.", "小葱擦干，可以减少热油飞溅。"),
            step("warm-oil", "Warm the oil", "温热食用油", "Add oil to a cold pan and warm it gently over low heat.", "冷锅倒油，小火慢慢加热。", "Warm the oil slowly over low heat. It should shimmer gently, not smoke.", "用小火慢慢把油加热，微微发亮就好，不要冒烟。", 60, "flame.fill", "Low heat", "小火", nil, nil),
            step("fry-scallion", "Fry the scallions slowly", "慢炸葱段", "Add scallions and fry on low heat until deep golden and crisp.", "放入葱段，小火慢炸到深金黄、酥脆。", "Fry the scallions slowly. Wait until they turn deep golden and crisp.", "小火慢慢炸葱段，等到颜色变成深金黄、口感酥脆。", 420, "sparkles", "Low heat", "小火", "Low heat extracts aroma without burning the scallions.", "小火能把葱香炸出来，又不容易发苦。"),
            step("cook-noodles", "Cook the noodles", "煮面条", "Boil noodles until just tender. Save a little cooking water, then drain.", "面条煮到刚熟，留少量面汤后沥水。", "Cook the noodles until just tender. Save a spoonful of noodle water, then drain.", "面条煮到刚刚熟，留一勺面汤，再把面沥干。", 180, "water.waves", "High heat", "大火", nil, nil),
            step("toss", "Toss while hot", "趁热拌匀", "Add sauce and scallion oil to the hot noodles. Toss until glossy.", "热面中加入料汁和葱油，拌到均匀油亮。", "Pour the sauce and scallion oil over the hot noodles. Toss until every strand shines.", "把料汁和葱油倒在热面上，拌到每一根面条都油亮裹汁。", 45, "arrow.triangle.2.circlepath", nil, nil, nil),
            step("serve", "Top and serve", "加葱出碗", "Top with crisp scallions. Loosen with noodle water if needed and serve.", "铺上酥葱，太干可加少量面汤，立即享用。", "Top with the crisp scallions. Add a splash of noodle water only if needed, then serve.", "放上酥脆葱段，如果太干就加一点面汤，然后马上享用。", nil, "checkmark.seal.fill", nil, nil, nil)
        ]
    )

    static func ingredient(
        _ id: String,
        _ en: String,
        _ zh: String,
        _ metric: String,
        _ us: String,
        _ substituteEn: String?,
        _ substituteZh: String?
    ) -> Ingredient {
        Ingredient(
            id: id,
            name: .init(en: en, zh: zh),
            metricAmount: metric,
            usAmount: us,
            substitute: substituteEn.map { LocalizedText(en: $0, zh: substituteZh ?? $0) }
        )
    }

    static func step(
        _ id: String,
        _ titleEn: String,
        _ titleZh: String,
        _ instructionEn: String,
        _ instructionZh: String,
        _ voiceEn: String,
        _ voiceZh: String,
        _ duration: Int?,
        _ symbol: String,
        _ heatEn: String?,
        _ heatZh: String?,
        _ tipEn: String?,
        _ tipZh: String? = nil
    ) -> CookingStep {
        CookingStep(
            id: id,
            title: .init(en: titleEn, zh: titleZh),
            instruction: .init(en: instructionEn, zh: instructionZh),
            voicePrompt: .init(en: voiceEn, zh: voiceZh),
            durationSeconds: duration,
            symbol: symbol,
            heat: heatEn.map { LocalizedText(en: $0, zh: heatZh ?? $0) },
            tip: tipEn.map { LocalizedText(en: $0, zh: tipZh ?? $0) }
        )
    }
}
