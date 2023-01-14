//
//  UserNotificationUtil.swift
//  NotificationTest
//
//  Created by 近江伸一 on 2023/01/14.
//
import UIKit
import UserNotifications

final class UserNotificationUtil: NSObject, UNUserNotificationCenterDelegate {
   
    static var shared = UserNotificationUtil()
    private var center = UNUserNotificationCenter.current()
    
    func initialize() {
        center.delegate = UserNotificationUtil.shared
        
    }
    func showPushPermit(completion: @escaping (Result<Bool, Error>) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(.failure(error))
                return
            }
            completion(.success(isGranted))
        }
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (_ options: UNNotificationPresentationOptions) -> Void
    ) {
        // banner: 端末上部にバナー表示
        // list: 通知センターに表示
        // sound: 通知音
        // badge: バッジ
        completionHandler([.banner, .list, .sound, .badge])
    }
    
    // 通知をタップした時にはしる処理
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
    func countTimerRequest() {
//        let trigger = UNTimeIntervalNotificationTrigger(
//            timeInterval: TimeInterval(64),
//            repeats: true
//        )
        let dateComponents = DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            hour: 15,
            minute: 14
        )
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )
        let content = UNMutableNotificationContent()
        content.title = "おやつの時間"
        content.body = "たくさん食べるんですよ！"
       //    content.sound = .default
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        center.add(request)
    }
    
    
}
    
