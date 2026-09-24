import SwiftUI

@main
struct TapCookWatchApp: App {
    @StateObject private var controller = CookingSessionController.shared
    @StateObject private var preferences = CookPreferencesStore.shared

    var body: some Scene {
        WindowGroup {
            WatchRootView()
                .environmentObject(controller)
                .environmentObject(preferences)
        }
    }
}
