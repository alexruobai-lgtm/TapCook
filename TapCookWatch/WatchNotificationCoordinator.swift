import Foundation
import UserNotifications

enum WatchNotificationCoordinator {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    static func scheduleTimer(stepID: String, seconds: Int, title: String, body: String) {
        guard seconds > 0 else { return }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let request = UNNotificationRequest(
            identifier: notificationID(stepID),
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        )
        UNUserNotificationCenter.current().add(request)
    }

    static func cancel(stepID: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID(stepID)])
    }

    private static func notificationID(_ stepID: String) -> String { "tapcook.timer.\(stepID)" }
}
