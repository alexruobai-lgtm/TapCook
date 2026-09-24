import SwiftUI

@main
struct TapCookApp: App {
    @StateObject private var preferences = CookPreferencesStore.shared
    @StateObject private var store = CookStore.shared

    var body: some Scene {
        WindowGroup {
            PhoneRootView()
                .environmentObject(preferences)
                .environmentObject(store)
                .tint(TapCookTheme.orange)
                .id(preferences.preferences)
                .onAppear { _ = CookConnectivity.shared }
        }
    }
}
