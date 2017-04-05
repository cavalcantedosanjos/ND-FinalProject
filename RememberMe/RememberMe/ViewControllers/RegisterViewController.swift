//
//  RegisterViewController.swift
//  RememberMe
//
//  Created by Joao Anjos on 05/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import UserNotifications

class RegisterViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: " vamos cambada", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: " ", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared.applicationIconBadgeNumber as NSNumber?;
        content.categoryIdentifier = "com.cavalcante.RememberMe"
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 60.0, repeats: true)
        let request = UNNotificationRequest.init(identifier: "teste", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
        //center.removePendingNotificationRequests(withIdentifiers: ["teste"])


    }
    
    

}
