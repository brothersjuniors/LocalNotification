//
//  ViewController.swift
//  NotificationTest
//
//  Created by 近江伸一 on 2023/01/14.
//

import UIKit

class ViewController: UIViewController {
   
    private let dt = Date()
    private let df = DateFormatter()
    private let timeStyle = "yyyy年MM月dd日"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let content = UNMutableNotificationContent()
        df.locale = Locale(identifier: "ja_JP")
       
        //   content.title = "ここに通知のタイトル"
     //   content.body = "ここに通知の本文"
        // content.sound = .default
        content.badge = 1
   let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        UserNotificationUtil().countTimerRequest()
        
    }
    @IBAction func push(_ sender: Any) {
        
        
        UserNotificationUtil.shared.showPushPermit{ result in
            switch result {
            case .success(_): break
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    }

extension DateFormatter {
    static var yyyyMMddHHmmss: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        df.timeZone = TimeZone.current
        return df
    }
}
//extension Date {
//    var components: DateComponents {
//        let calendar = Calendar.current
//        return DateComponents(
//            calendar: Calendar.current,
//            timeZone: TimeZone.current,
//            year: calendar.component(.year, from: self),
//            month: calendar.component(.month, from: self),
//            day: calendar.component(.day, from: self),
//            hour: calendar.component(.hour, from: self),
//            minute: calendar.component(.minute, from: self),
//            second: calendar.component(.second, from: self)
//        )
//    }
//}
