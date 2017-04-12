//
//  ConsultTableViewController.swift
//  RememberMe
//
//  Created by Joao Anjos on 05/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import UserNotifications
import PKHUD

class ReminderTableViewController: UITableViewController {
    
    // MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(.progress)
        FirebaseService.shared().load {
            HUD.hide()
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.saved.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReminderTableViewCell
        cell.setup(reminder: Reminder.saved[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Alert!", message: "Are you sure you want to delete?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.deleteItem(indexItem: indexPath.row)
                alert.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    func deleteItem(indexItem index: Int) {
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Reminder.saved[index].key])
        
        HUD.show(.progress)
        FirebaseService.shared().remove(ref: Reminder.saved[index].ref!, onSuccess: {
            self.showMessage(message: "Deleted successfully.", title: "Success")
            Reminder.saved.remove(at: index)
            self.tableView.reloadData()
        }, onFailure: { (error) in
            self.showMessage(message: "Could not perform an operation at this time. Please try again later.", title: "Error")
        }, onCompleted: {
          HUD.hide()
        })

    }
    
    
    // MARK: - Misc
    func showMessage(message: String, title: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
