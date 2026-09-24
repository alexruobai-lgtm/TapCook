import Foundation

enum CatalogRecipes {
    static let all: [Recipe] = seeds.map { CatalogRecipeFactory.make($0) }

    private static let sichuan = LocalizedText(en: "Sichuan", zh: "川菜")
    private static let cantonese = LocalizedText(en: "Cantonese", zh: "粤菜")
    private static let hunan = LocalizedText(en: "Hunan", zh: "湘菜")
    private static let jiangsu = LocalizedText(en: "Jiangsu", zh: "苏菜")
    private static let zhejiang = LocalizedText(en: "Zhejiang", zh: "浙菜")
    private static let fujian = LocalizedText(en: "Fujian", zh: "闽菜")
    private static let shandong = LocalizedText(en: "Shandong", zh: "鲁菜")
    private static let anhui = LocalizedText(en: "Anhui", zh: "徽菜")
    private static let northern = LocalizedText(en: "Beijing & Northern", zh: "北京与北方菜")
    private static let jiangnan = LocalizedText(en: "Shanghai & Jiangnan", zh: "上海与江南菜")
    private static let northwest = LocalizedText(en: "Northwest & Xinjiang", zh: "西北与新疆菜")
    private static let yungui = LocalizedText(en: "Yunnan & Guizhou", zh: "云贵菜")
    private static let taiwanese = LocalizedText(en: "Taiwanese", zh: "台湾菜")

    // Ten approachable dishes from each of thirteen regional traditions.
    private static let seeds: [CatalogRecipeSeed] = [
        s("twice-cooked-pork", "Twice-Cooked Pork", "回锅肉", sichuan, .stirFry, 30, .medium, "pork belly", "五花肉"),
        s("fish-fragrant-pork", "Fish-Fragrant Pork", "鱼香肉丝", sichuan, .stirFry, 25, .medium, "pork loin", "猪里脊"),
        s("boiled-beef", "Boiled Beef", "水煮牛肉", sichuan, .hotPot, 35, .medium, "sliced beef", "牛肉片"),
        s("spicy-chicken", "Spicy Chicken", "辣子鸡", sichuan, .fry, 35, .medium, "chicken thigh", "鸡腿肉"),
        s("dry-fried-green-beans", "Dry-Fried Green Beans", "干煸四季豆", sichuan, .stirFry, 25, .medium, "green beans", "四季豆"),
        s("hot-sour-glass-noodles", "Hot & Sour Glass Noodles", "酸辣粉", sichuan, .noodle, 25, .easy, "sweet-potato noodles", "红薯粉"),
        s("sichuan-cold-noodles", "Sichuan Cold Noodles", "四川凉面", sichuan, .coldDish, 20, .easy, "wheat noodles", "小麦面"),
        s("ants-climbing-tree", "Ants Climbing a Tree", "蚂蚁上树", sichuan, .stirFry, 25, .easy, "glass noodles and pork", "粉丝和肉末"),
        s("mouthwatering-chicken", "Mouthwatering Chicken", "口水鸡", sichuan, .coldDish, 35, .medium, "poached chicken", "白切鸡肉"),
        s("tea-smoked-duck", "Tea-Smoked Duck", "樟茶鸭", sichuan, .roast, 80, .medium, "whole duck", "整鸭"),

        s("char-siu", "Char Siu", "叉烧", cantonese, .roast, 75, .medium, "pork shoulder", "梅头肉"),
        s("white-cut-chicken", "White-Cut Chicken", "白切鸡", cantonese, .soup, 45, .medium, "whole chicken", "整鸡"),
        s("soy-sauce-chicken", "Soy Sauce Chicken", "豉油鸡", cantonese, .braise, 55, .medium, "whole chicken", "整鸡"),
        s("beef-chow-fun", "Beef Chow Fun", "干炒牛河", cantonese, .stirFry, 25, .medium, "rice noodles and beef", "河粉和牛肉"),
        s("wonton-noodle-soup", "Wonton Noodle Soup", "云吞面", cantonese, .noodle, 35, .medium, "wontons and noodles", "云吞和面条"),
        s("black-bean-pork-ribs", "Steamed Pork Ribs with Black Bean", "豉汁蒸排骨", cantonese, .steam, 35, .easy, "pork ribs", "排骨"),
        s("salt-pepper-shrimp", "Salt & Pepper Shrimp", "椒盐虾", cantonese, .fry, 30, .medium, "shell-on shrimp", "带壳鲜虾"),
        s("claypot-rice", "Claypot Rice", "煲仔饭", cantonese, .rice, 45, .medium, "rice and cured meat", "大米和腊味"),
        s("shrimp-rice-rolls", "Shrimp Rice Rolls", "鲜虾肠粉", cantonese, .steam, 35, .medium, "rice batter and shrimp", "米浆和鲜虾"),
        s("buddhas-delight", "Buddha's Delight", "罗汉斋", cantonese, .braise, 35, .easy, "mushrooms and tofu", "菌菇和豆制品"),

        s("chopped-chili-fish-head", "Steamed Fish Head with Chopped Chili", "剁椒鱼头", hunan, .steam, 35, .medium, "fish head", "鱼头"),
        s("hunan-stir-fried-pork", "Hunan Stir-Fried Pork", "农家小炒肉", hunan, .stirFry, 25, .easy, "pork belly and peppers", "五花肉和辣椒"),
        s("dongan-chicken", "Dong'an Chicken", "东安子鸡", hunan, .braise, 45, .medium, "chicken", "鸡肉"),
        s("smoked-pork-dried-radish", "Smoked Pork with Dried Radish", "腊肉炒萝卜干", hunan, .stirFry, 25, .easy, "cured pork and dried radish", "腊肉和萝卜干"),
        s("beer-duck", "Beer Duck", "啤酒鸭", hunan, .braise, 60, .medium, "duck", "鸭肉"),
        s("preserved-pork-chili", "Preserved Pork with Chili", "辣椒炒腊肉", hunan, .stirFry, 25, .easy, "preserved pork", "腊肉"),
        s("hunan-home-style-tofu", "Hunan Home-Style Tofu", "湘味家常豆腐", hunan, .stirFry, 25, .easy, "firm tofu", "老豆腐"),
        s("steamed-pork-rice-flour", "Steamed Pork with Rice Flour", "粉蒸肉", hunan, .steam, 60, .medium, "pork belly and rice flour", "五花肉和蒸肉米粉"),
        s("hot-sour-chicken-gizzards", "Hot & Sour Chicken Gizzards", "酸辣鸡杂", hunan, .stirFry, 30, .medium, "chicken gizzards", "鸡胗"),
        s("hot-sour-lotus-root", "Hot & Sour Lotus Root", "酸辣藕带", hunan, .stirFry, 20, .easy, "lotus-root shoots", "藕带"),

        s("lions-head-meatballs", "Lion's Head Meatballs", "狮子头", jiangsu, .braise, 60, .medium, "pork meatballs", "猪肉丸"),
        s("squirrel-mandarin-fish", "Squirrel Mandarin Fish", "松鼠桂鱼", jiangsu, .fry, 50, .medium, "whole mandarin fish", "整条桂鱼"),
        s("nanjing-salted-duck", "Nanjing Salted Duck", "南京盐水鸭", jiangsu, .braise, 90, .medium, "duck", "鸭肉"),
        s("yangzhou-fried-rice", "Yangzhou Fried Rice", "扬州炒饭", jiangsu, .rice, 25, .medium, "rice, egg, and shrimp", "米饭、鸡蛋和虾仁"),
        s("wuxi-spare-ribs", "Wuxi Spare Ribs", "无锡排骨", jiangsu, .braise, 70, .medium, "pork ribs", "猪肋排"),
        s("crystal-pork-aspic", "Crystal Pork Aspic", "水晶肴肉", jiangsu, .coldDish, 90, .medium, "pork shank", "猪蹄膀"),
        s("braised-shredded-tofu", "Braised Shredded Tofu", "大煮干丝", jiangsu, .soup, 40, .medium, "pressed tofu", "豆腐干丝"),
        s("beggars-chicken", "Beggar's Chicken", "叫花鸡", jiangsu, .roast, 120, .medium, "whole chicken", "整鸡"),
        s("fish-head-tofu-soup", "Fish Head Tofu Soup", "鱼头豆腐汤", jiangsu, .soup, 45, .easy, "fish head and tofu", "鱼头和豆腐"),
        s("biluochun-shrimp", "Biluochun Shrimp", "碧螺虾仁", jiangsu, .stirFry, 25, .medium, "shrimp and tea", "虾仁和茶叶"),

        s("dongpo-pork", "Dongpo Pork", "东坡肉", zhejiang, .braise, 100, .medium, "pork belly", "五花肉"),
        s("west-lake-vinegar-fish", "West Lake Vinegar Fish", "西湖醋鱼", zhejiang, .braise, 35, .medium, "whole fish", "整鱼"),
        s("longjing-shrimp", "Longjing Shrimp", "龙井虾仁", zhejiang, .stirFry, 25, .medium, "shrimp and tea", "虾仁和龙井茶"),
        s("song-sao-fish-soup", "Song Sao Fish Soup", "宋嫂鱼羹", zhejiang, .soup, 40, .medium, "white fish", "白肉鱼"),
        s("shrimp-eel-noodles", "Shrimp and Eel Noodles", "虾爆鳝面", zhejiang, .noodle, 35, .medium, "eel and shrimp", "鳝鱼和虾仁"),
        s("ningbo-rice-cakes", "Ningbo Rice Cakes with Greens", "雪菜炒年糕", zhejiang, .stirFry, 25, .easy, "rice cakes and preserved greens", "年糕和雪菜"),
        s("braised-bamboo-shoots", "Braised Spring Bamboo Shoots", "油焖笋", zhejiang, .braise, 35, .easy, "bamboo shoots", "春笋"),
        s("osmanthus-lotus-root", "Osmanthus Sticky Rice Lotus Root", "桂花糯米藕", zhejiang, .dessert, 70, .medium, "lotus root and sticky rice", "莲藕和糯米"),
        s("drunken-chicken", "Drunken Chicken", "醉鸡", zhejiang, .coldDish, 60, .medium, "chicken", "鸡肉"),
        s("yellow-croaker-preserved-greens", "Yellow Croaker with Preserved Greens", "雪菜大黄鱼", zhejiang, .braise, 45, .medium, "yellow croaker", "大黄鱼"),

        s("buddha-jumps-wall", "Buddha Jumps Over the Wall", "佛跳墙", fujian, .soup, 180, .medium, "seafood and poultry", "海味和禽肉"),
        s("lychee-pork", "Lychee Pork", "荔枝肉", fujian, .fry, 35, .medium, "pork loin", "猪里脊"),
        s("fuzhou-fish-balls", "Fuzhou Fish Balls", "福州鱼丸", fujian, .soup, 50, .medium, "fish paste", "鱼茸"),
        s("oyster-omelet", "Oyster Omelet", "海蛎煎", fujian, .fry, 25, .easy, "oysters and egg", "海蛎和鸡蛋"),
        s("red-wine-lees-chicken", "Red Wine Lees Chicken", "红糟鸡", fujian, .braise, 55, .medium, "chicken and red lees", "鸡肉和红糟"),
        s("dingbianhu", "Dingbianhu", "鼎边糊", fujian, .soup, 40, .medium, "rice batter and seafood", "米浆和海鲜"),
        s("shacha-noodles", "Shacha Noodles", "沙茶面", fujian, .noodle, 35, .easy, "noodles and satay broth", "面条和沙茶汤"),
        s("xiamen-peanut-soup", "Xiamen Peanut Soup", "厦门花生汤", fujian, .dessert, 90, .easy, "peanuts", "花生"),
        s("minnan-braised-noodles", "Southern Fujian Braised Noodles", "闽南卤面", fujian, .noodle, 45, .medium, "noodles and seafood", "面条和海鲜"),
        s("taro-duck", "Taro Duck", "芋香鸭", fujian, .braise, 65, .medium, "duck and taro", "鸭肉和芋头"),

        s("sweet-sour-carp", "Sweet & Sour Carp", "糖醋鲤鱼", shandong, .fry, 45, .medium, "whole carp", "整条鲤鱼"),
        s("dezhou-braised-chicken", "Dezhou Braised Chicken", "德州扒鸡", shandong, .braise, 120, .medium, "whole chicken", "整鸡"),
        s("nine-turn-intestines", "Nine-Turn Intestines", "九转大肠", shandong, .braise, 70, .medium, "pork intestine", "猪大肠"),
        s("scallion-sea-cucumber", "Scallion-Braised Sea Cucumber", "葱烧海参", shandong, .braise, 50, .medium, "sea cucumber", "海参"),
        s("shandong-pancake-wrap", "Shandong Pancake Wrap", "煎饼卷大葱", shandong, .dough, 35, .easy, "grain pancakes and scallion", "杂粮煎饼和大葱"),
        s("quick-fried-kidney", "Quick-Fried Kidney", "火爆腰花", shandong, .stirFry, 30, .medium, "pork kidney", "猪腰"),
        s("four-joy-meatballs", "Four-Joy Meatballs", "四喜丸子", shandong, .braise, 65, .medium, "pork meatballs", "猪肉丸"),
        s("braised-prawns", "Braised Prawns", "油焖大虾", shandong, .braise, 30, .easy, "whole prawns", "整只大虾"),
        s("vinegar-cabbage", "Vinegar Cabbage", "醋溜白菜", shandong, .stirFry, 18, .easy, "napa cabbage", "大白菜"),
        s("moo-shu-pork", "Moo Shu Pork", "木须肉", shandong, .stirFry, 25, .easy, "pork, egg, and wood ear", "猪肉、鸡蛋和木耳"),

        s("stinky-mandarin-fish", "Stinky Mandarin Fish", "臭鳜鱼", anhui, .braise, 60, .medium, "fermented mandarin fish", "发酵桂鱼"),
        s("li-hongzhang-hotchpotch", "Li Hongzhang Hotchpotch", "李鸿章大杂烩", anhui, .soup, 75, .medium, "mixed seafood and meat", "海鲜肉类杂烩"),
        s("hairy-tofu", "Hairy Tofu", "毛豆腐", anhui, .fry, 35, .medium, "fermented tofu", "毛豆腐"),
        s("bagongshan-tofu", "Bagongshan Tofu", "八公山豆腐", anhui, .braise, 35, .easy, "soft tofu", "嫩豆腐"),
        s("huangshan-stewed-pigeon", "Huangshan Braised Pigeon", "黄山炖鸽", anhui, .soup, 80, .medium, "pigeon", "乳鸽"),
        s("fuliji-roast-chicken", "Fuliji Roast Chicken", "符离集烧鸡", anhui, .roast, 110, .medium, "whole chicken", "整鸡"),
        s("wenzheng-bamboo-shoots", "Wenzheng Bamboo Shoots", "问政山笋", anhui, .braise, 40, .easy, "bamboo shoots", "山笋"),
        s("ham-softshell-turtle", "Ham-Stewed Softshell Turtle", "火腿炖甲鱼", anhui, .soup, 100, .medium, "softshell turtle and ham", "甲鱼和火腿"),
        s("wuwei-smoked-duck", "Wuwei Smoked Duck", "无为板鸭", anhui, .roast, 100, .medium, "whole duck", "整鸭"),
        s("huizhou-yipin-pot", "Huizhou Yipin Pot", "徽州一品锅", anhui, .hotPot, 90, .medium, "layered meat and vegetables", "分层肉菜"),

        s("peking-duck", "Peking Duck", "北京烤鸭", northern, .roast, 120, .medium, "whole duck", "整鸭"),
        s("zhajiang-noodles", "Zhajiang Noodles", "炸酱面", northern, .noodle, 40, .easy, "noodles and pork-bean sauce", "面条和肉酱"),
        s("copper-pot-lamb", "Copper-Pot Lamb Hot Pot", "铜锅涮羊肉", northern, .hotPot, 50, .easy, "sliced lamb", "羊肉片"),
        s("beijing-sweet-bean-pork", "Beijing Sweet-Bean Pork", "京酱肉丝", northern, .stirFry, 25, .easy, "pork loin and sweet-bean sauce", "猪里脊和甜面酱"),
        s("donkey-rolls", "Donkey Rolls", "驴打滚", northern, .dessert, 45, .medium, "sticky rice and red bean", "糯米和豆沙"),
        s("beijing-stewed-liver", "Beijing Stewed Liver", "炒肝", northern, .soup, 50, .medium, "pork liver and intestine", "猪肝和猪肠"),
        s("pork-cabbage-dumplings", "Pork & Cabbage Dumplings", "猪肉白菜饺子", northern, .dough, 70, .medium, "pork and napa cabbage", "猪肉和白菜"),
        s("northern-scallion-pancakes", "Northern Scallion Pancakes", "北方葱油饼", northern, .dough, 50, .medium, "flour and scallion", "面粉和大葱"),
        s("di-san-xian", "Di San Xian", "地三鲜", northern, .stirFry, 30, .easy, "potato, eggplant, and pepper", "土豆、茄子和青椒"),
        s("guo-bao-rou", "Guo Bao Rou", "锅包肉", northern, .fry, 40, .medium, "pork loin", "猪里脊"),

        s("soup-dumplings", "Soup Dumplings", "小笼包", jiangnan, .dough, 90, .medium, "pork filling and aspic", "猪肉馅和皮冻"),
        s("shengjian-buns", "Shengjian Buns", "生煎包", jiangnan, .dough, 80, .medium, "pork buns", "猪肉包子"),
        s("shanghai-smoked-fish", "Shanghai Smoked Fish", "上海熏鱼", jiangnan, .fry, 60, .medium, "fish steaks", "鱼段"),
        s("eight-treasure-duck", "Eight-Treasure Duck", "八宝鸭", jiangnan, .steam, 120, .medium, "duck and sticky-rice filling", "鸭和八宝糯米馅"),
        s("crab-roe-tofu", "Crab Roe Tofu", "蟹粉豆腐", jiangnan, .braise, 35, .medium, "crab roe and tofu", "蟹粉和豆腐"),
        s("four-happiness-gluten", "Four-Happiness Wheat Gluten", "四喜烤麸", jiangnan, .braise, 45, .easy, "wheat gluten and mushrooms", "烤麸和菌菇"),
        s("pork-ribs-rice-cakes", "Pork Ribs with Rice Cakes", "排骨年糕", jiangnan, .braise, 50, .medium, "pork ribs and rice cakes", "排骨和年糕"),
        s("drunken-shrimp", "Drunken Shrimp", "醉虾", jiangnan, .coldDish, 30, .medium, "fresh shrimp", "鲜虾"),
        s("salted-pork-bamboo-soup", "Salted Pork & Bamboo Soup", "腌笃鲜", jiangnan, .soup, 80, .medium, "cured pork, bamboo, and tofu", "咸肉、春笋和百叶结"),
        s("shepherds-purse-wontons", "Shepherd's Purse Wontons", "荠菜馄饨", jiangnan, .dough, 65, .medium, "shepherd's purse and pork", "荠菜和猪肉"),

        s("big-plate-chicken", "Big Plate Chicken", "大盘鸡", northwest, .braise, 70, .medium, "chicken, potato, and peppers", "鸡肉、土豆和辣椒"),
        s("xinjiang-lamb-skewers", "Xinjiang Lamb Skewers", "新疆羊肉串", northwest, .roast, 45, .easy, "lamb", "羊肉"),
        s("lanzhou-beef-noodles", "Lanzhou Beef Noodles", "兰州牛肉面", northwest, .noodle, 90, .medium, "beef broth and hand-pulled noodles", "牛肉汤和拉面"),
        s("roujiamo", "Roujiamo", "肉夹馍", northwest, .dough, 100, .medium, "braised pork and flatbread", "腊汁肉和白吉馍"),
        s("biang-biang-noodles", "Biang Biang Noodles", "油泼扯面", northwest, .noodle, 60, .medium, "hand-pulled wide noodles", "手扯宽面"),
        s("xinjiang-pilaf", "Xinjiang Pilaf", "新疆手抓饭", northwest, .rice, 60, .easy, "rice, lamb, and carrot", "大米、羊肉和胡萝卜"),
        s("cumin-lamb", "Cumin Lamb", "孜然羊肉", northwest, .stirFry, 30, .easy, "lamb and cumin", "羊肉和孜然"),
        s("lamb-paomo", "Lamb Paomo", "羊肉泡馍", northwest, .soup, 100, .medium, "lamb broth and flatbread", "羊肉汤和馍"),
        s("shaanxi-liangpi", "Shaanxi Liangpi", "陕西凉皮", northwest, .coldDish, 70, .medium, "wheat or rice noodles", "凉皮"),
        s("xinjiang-nang", "Xinjiang Nang", "新疆馕", northwest, .dough, 80, .medium, "flour and sesame", "面粉和芝麻"),

        s("crossing-bridge-noodles", "Crossing-the-Bridge Rice Noodles", "过桥米线", yungui, .noodle, 55, .medium, "rice noodles and hot broth", "米线和滚烫高汤"),
        s("yunnan-steam-pot-chicken", "Yunnan Steam-Pot Chicken", "汽锅鸡", yungui, .steam, 100, .medium, "chicken and mushrooms", "鸡肉和菌菇"),
        s("yunnan-mashed-potatoes", "Yunnan Mashed Potatoes", "老奶洋芋", yungui, .stirFry, 30, .easy, "potatoes", "土豆"),
        s("wild-mushroom-hot-pot", "Wild Mushroom Hot Pot", "野生菌火锅", yungui, .hotPot, 70, .medium, "mixed edible mushrooms", "可食用混合菌菇"),
        s("dai-pineapple-rice", "Dai Pineapple Rice", "傣味菠萝饭", yungui, .rice, 60, .easy, "sticky rice and pineapple", "糯米和菠萝"),
        s("guizhou-sour-soup-fish", "Guizhou Sour Soup Fish", "酸汤鱼", yungui, .hotPot, 60, .medium, "fish and sour broth", "鱼和酸汤"),
        s("guizhou-spicy-chicken", "Guizhou Spicy Chicken", "贵州辣子鸡", yungui, .fry, 45, .medium, "chicken", "鸡肉"),
        s("silk-doll-wraps", "Silk Doll Wraps", "丝娃娃", yungui, .dough, 50, .medium, "thin wrappers and vegetables", "薄饼和蔬菜丝"),
        s("guizhou-rice-tofu", "Guizhou Rice Tofu", "贵州米豆腐", yungui, .coldDish, 45, .easy, "rice tofu", "米豆腐"),
        s("yunnan-ham-erkuai", "Yunnan Ham Erkuai", "火腿炒饵块", yungui, .stirFry, 30, .easy, "rice cakes and Yunnan ham", "饵块和云南火腿"),

        s("three-cup-chicken", "Three Cup Chicken", "三杯鸡", taiwanese, .braise, 45, .medium, "chicken and basil", "鸡肉和九层塔"),
        s("lu-rou-fan", "Lu Rou Fan", "卤肉饭", taiwanese, .rice, 70, .easy, "braised pork and rice", "卤肉和米饭"),
        s("taiwan-beef-noodle-soup", "Taiwanese Beef Noodle Soup", "台湾牛肉面", taiwanese, .noodle, 90, .medium, "beef broth and noodles", "牛肉汤和面条"),
        s("oyster-vermicelli", "Oyster Vermicelli", "蚵仔面线", taiwanese, .noodle, 45, .easy, "oysters and thin vermicelli", "蚵仔和面线"),
        s("gua-bao", "Gua Bao", "刈包", taiwanese, .dough, 100, .medium, "pork belly and steamed buns", "五花肉和荷叶包"),
        s("taiwan-popcorn-chicken", "Taiwanese Popcorn Chicken", "盐酥鸡", taiwanese, .fry, 35, .easy, "chicken thigh and basil", "鸡腿肉和九层塔"),
        s("taiwan-fried-rice-noodles", "Taiwanese Fried Rice Noodles", "台湾炒米粉", taiwanese, .stirFry, 35, .easy, "rice vermicelli and pork", "米粉和猪肉"),
        s("pineapple-cakes", "Pineapple Cakes", "凤梨酥", taiwanese, .dessert, 90, .medium, "pineapple filling and pastry", "凤梨馅和酥皮"),
        s("taro-balls", "Taro Balls", "芋圆", taiwanese, .dessert, 55, .medium, "taro and tapioca starch", "芋头和木薯粉"),
        s("milkfish-congee", "Milkfish Congee", "虱目鱼粥", taiwanese, .rice, 50, .easy, "milkfish and rice", "虱目鱼和大米")
    ]

    private static func s(
        _ id: String,
        _ en: String,
        _ zh: String,
        _ cuisine: LocalizedText,
        _ technique: CatalogTechnique,
        _ minutes: Int,
        _ difficulty: RecipeDifficulty,
        _ focusEn: String,
        _ focusZh: String
    ) -> CatalogRecipeSeed {
        CatalogRecipeSeed(
            id: id,
            name: .init(en: en, zh: zh),
            cuisine: cuisine,
            technique: technique,
            totalMinutes: minutes,
            difficulty: difficulty,
            focus: .init(en: focusEn, zh: focusZh)
        )
    }
}
