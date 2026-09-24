#!/usr/bin/env ruby

require "xcodeproj"

root = File.expand_path("..", __dir__)
project_path = File.join(root, "TapCook.xcodeproj")
development_team = ENV["DEVELOPMENT_TEAM"]
project = Xcodeproj::Project.new(project_path)

project.root_object.attributes["LastSwiftUpdateCheck"] = "2610"
project.root_object.attributes["LastUpgradeCheck"] = "2610"

ios_target = project.new_target(:application, "TapCook", :ios, "18.0")
watch_target = project.new_target(:application, "TapCookWatch", :watchos, "11.0")
test_target = project.new_target(:unit_test_bundle, "TapCookTests", :ios, "18.0")

project.root_object.attributes["TargetAttributes"] = {
  ios_target.uuid => { "CreatedOnToolsVersion" => "26.1" },
  watch_target.uuid => { "CreatedOnToolsVersion" => "26.1" },
  test_target.uuid => { "CreatedOnToolsVersion" => "26.1" },
}

localization_group = project.main_group.new_group("Localization", "Localization")
localizable_variant = localization_group.new_variant_group("Localizable.strings")
%w[en zh-Hans].each do |language|
  reference = localizable_variant.new_file("#{language}.lproj/Localizable.strings")
  reference.name = language
end

resources_group = project.main_group.new_group("Resources", "Resources")
steps_group = resources_group.new_group("Steps", "Steps")
step_references = Dir[File.join(root, "Resources", "Steps", "*.png")].sort.map do |path|
  steps_group.new_file(File.basename(path))
end
heroes_group = resources_group.new_group("RecipeHeroes", "RecipeHeroes")
hero_references = Dir[File.join(root, "Resources", "RecipeHeroes", "*-hero.jpg")].sort.map do |path|
  heroes_group.new_file(File.basename(path))
end

shared_group = project.main_group.new_group("Shared", "Shared")
shared_references = %w[
  AppLanguage.swift
  CookModels.swift
  BundleImage.swift
  CatalogRecipeFactory.swift
  CatalogRecipeSeeds.swift
  SampleRecipes.swift
  ExpandedRecipes.swift
  TapCookTheme.swift
  CookConnectivity.swift
].map { |path| shared_group.new_file(path) }
ios_target.add_file_references(shared_references)
watch_target.add_file_references(shared_references)

ios_group = project.main_group.new_group("TapCook", "TapCook")
ios_sources = %w[
  TapCookApp.swift
  PhoneRootView.swift
  RecipeDetailView.swift
  NotebookView.swift
  SettingsView.swift
  CookStore.swift
]
ios_target.add_file_references(ios_sources.map { |path| ios_group.new_file(path) })
ios_target.resources_build_phase.add_file_reference(ios_group.new_file("PrivacyInfo.xcprivacy"))
ios_target.resources_build_phase.add_file_reference(ios_group.new_file("Assets.xcassets"))
ios_target.resources_build_phase.add_file_reference(localizable_variant)
step_references.each { |reference| ios_target.resources_build_phase.add_file_reference(reference) }
hero_references.each { |reference| ios_target.resources_build_phase.add_file_reference(reference) }

watch_group = project.main_group.new_group("TapCookWatch", "TapCookWatch")
watch_sources = %w[
  TapCookWatchApp.swift
  WatchRootView.swift
  CookingSessionController.swift
  VoiceCoach.swift
  WatchNotificationCoordinator.swift
]
watch_target.add_file_references(watch_sources.map { |path| watch_group.new_file(path) })
watch_target.resources_build_phase.add_file_reference(watch_group.new_file("PrivacyInfo.xcprivacy"))
watch_target.resources_build_phase.add_file_reference(watch_group.new_file("Assets.xcassets"))
watch_target.resources_build_phase.add_file_reference(localizable_variant)
step_references.each { |reference| watch_target.resources_build_phase.add_file_reference(reference) }
hero_references.each { |reference| watch_target.resources_build_phase.add_file_reference(reference) }

tests_group = project.main_group.new_group("TapCookTests", "TapCookTests")
test_target.add_file_references([tests_group.new_file("CookModelsTests.swift")])
test_target.add_dependency(ios_target)

ios_target.add_dependency(watch_target)
embed_watch_phase = ios_target.new_copy_files_build_phase("Embed Watch Content")
embed_watch_phase.dst_subfolder_spec = "1"
embed_watch_phase.dst_path = "Watch"
embed_watch_phase.add_file_reference(watch_target.product_reference)

ios_target.build_configurations.each do |configuration|
  settings = configuration.build_settings
  settings["CODE_SIGN_STYLE"] = "Automatic"
  settings["CURRENT_PROJECT_VERSION"] = "4"
  settings["DEVELOPMENT_TEAM"] = development_team if development_team
  settings["ENABLE_PREVIEWS"] = "YES"
  settings["GENERATE_INFOPLIST_FILE"] = "YES"
  settings["INFOPLIST_KEY_CFBundleDisplayName"] = "Tap Cook"
  settings["INFOPLIST_KEY_ITSAppUsesNonExemptEncryption"] = "NO"
  settings["INFOPLIST_KEY_UIApplicationSceneManifest_Generation"] = "YES"
  settings["INFOPLIST_KEY_UILaunchScreen_Generation"] = "YES"
  settings["INFOPLIST_KEY_UISupportedInterfaceOrientations"] = "UIInterfaceOrientationPortrait"
  settings["IPHONEOS_DEPLOYMENT_TARGET"] = "18.0"
  settings["MARKETING_VERSION"] = "1.0"
  settings["PRODUCT_BUNDLE_IDENTIFIER"] = "org.example.tapcook"
  settings["PRODUCT_NAME"] = "$(TARGET_NAME)"
  settings["SDKROOT"] = "iphoneos"
  settings["SKIP_INSTALL"] = "NO"
  settings["SUPPORTED_PLATFORMS"] = "iphoneos iphonesimulator"
  settings["SWIFT_EMIT_LOC_STRINGS"] = "YES"
  settings["SWIFT_STRICT_CONCURRENCY"] = "minimal"
  settings["SWIFT_VERSION"] = "5.0"
  settings["TARGETED_DEVICE_FAMILY"] = "1"
end

watch_target.build_configurations.each do |configuration|
  settings = configuration.build_settings
  settings["CODE_SIGN_STYLE"] = "Automatic"
  settings["CURRENT_PROJECT_VERSION"] = "4"
  settings["DEVELOPMENT_TEAM"] = development_team if development_team
  settings["ENABLE_PREVIEWS"] = "YES"
  settings["GENERATE_INFOPLIST_FILE"] = "YES"
  settings["INFOPLIST_KEY_CFBundleDisplayName"] = "Tap Cook"
  settings["INFOPLIST_KEY_ITSAppUsesNonExemptEncryption"] = "NO"
  settings["INFOPLIST_KEY_WKCompanionAppBundleIdentifier"] = "org.example.tapcook"
  settings["INFOPLIST_KEY_WKRunsIndependentlyOfCompanionApp"] = "YES"
  settings["LD_RUNPATH_SEARCH_PATHS"] = "$(inherited) @executable_path/Frameworks"
  settings["MARKETING_VERSION"] = "1.0"
  settings["PRODUCT_BUNDLE_IDENTIFIER"] = "org.example.tapcook.watchkitapp"
  settings["PRODUCT_NAME"] = "$(TARGET_NAME)"
  settings["SDKROOT"] = "watchos"
  settings["SKIP_INSTALL"] = "YES"
  settings["SUPPORTED_PLATFORMS"] = "watchos watchsimulator"
  settings["SWIFT_EMIT_LOC_STRINGS"] = "YES"
  settings["SWIFT_STRICT_CONCURRENCY"] = "minimal"
  settings["SWIFT_VERSION"] = "5.0"
  settings["TARGETED_DEVICE_FAMILY"] = "4"
  settings["WATCHOS_DEPLOYMENT_TARGET"] = "11.0"
end

test_target.build_configurations.each do |configuration|
  settings = configuration.build_settings
  settings["BUNDLE_LOADER"] = "$(TEST_HOST)"
  settings["CODE_SIGN_STYLE"] = "Automatic"
  settings["DEVELOPMENT_TEAM"] = development_team if development_team
  settings["GENERATE_INFOPLIST_FILE"] = "YES"
  settings["IPHONEOS_DEPLOYMENT_TARGET"] = "18.0"
  settings["PRODUCT_BUNDLE_IDENTIFIER"] = "org.example.tapcook.tests"
  settings["PRODUCT_NAME"] = "$(TARGET_NAME)"
  settings["SDKROOT"] = "iphoneos"
  settings["SUPPORTED_PLATFORMS"] = "iphoneos iphonesimulator"
  settings["SWIFT_VERSION"] = "5.0"
  settings["TARGETED_DEVICE_FAMILY"] = "1"
  settings["TEST_HOST"] = "$(BUILT_PRODUCTS_DIR)/TapCook.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/TapCook"
end

project.save

ios_scheme = Xcodeproj::XCScheme.new
ios_scheme.add_build_target(ios_target)
ios_scheme.set_launch_target(ios_target)
ios_scheme.add_test_target(test_target)
ios_scheme.save_as(project_path, "TapCook", true)

watch_scheme = Xcodeproj::XCScheme.new
watch_scheme.add_build_target(watch_target)
watch_scheme.set_launch_target(watch_target)
watch_scheme.save_as(project_path, "TapCookWatch", true)

puts "Generated #{project_path}"
