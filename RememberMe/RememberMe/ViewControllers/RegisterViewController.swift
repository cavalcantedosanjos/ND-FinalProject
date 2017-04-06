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
    @IBOutlet weak var reminderTextField: UITextField!
    @IBOutlet weak var reminderDate: UIDatePicker!
    
    let currentDate = Date()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderDate.minimumDate = currentDate
        reminderDate.date = currentDate
    }
    
    // MARK: - Actions
    
    @IBAction func doneButton_Clicked(_ sender: UIBarButtonItem) {
        
        guard let title = reminderTextField.text, !title.isEmpty  else {
            self.showMessage(message: "Required To-do.", title: "Invalid Field!")
            return
        }
        
        guard (reminderDate.date.timeIntervalSinceNow > 0) else {
            self.showMessage(message: "Invalid Date", title: "Invalid Field!")
            return
        }
        
        registerReminder(text: title, date: reminderDate.date)
        
    }
    
    @IBAction func cancelButton_Clicked(_ sender: UIBarButtonItem) {
        clearForm()
    }
    
    // MARK: - Misc
    
    func registerReminder(text: String, date: Date){
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: text, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: date.description(with: Locale.current), arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "com.cavalcante.RememberMe"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: "teste", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
        
        
        self.showMessage(message: "Reminder created with success!", title: "Success")
        clearForm()
        
    }

    func clearForm(){
        reminderTextField.text = ""
        reminderDate.date = currentDate
    }
    
}
