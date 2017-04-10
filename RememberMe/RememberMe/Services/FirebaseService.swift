//
//  FirebaseService.swift
//  RememberMe
//
//  Created by Joao Anjos on 06/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import Firebase

class FirebaseService {
    
    // MARK: Shared Instance
    class func shared() -> FirebaseService {
        struct Singleton {
            static var sharedInstance = FirebaseService()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: - Properties
    private let ref = FIRDatabase.database().reference(withPath: "reminder-items")
    private let deviceId = UIDevice.current.identifierForVendor!.uuidString
    var deviceRef: FIRDatabaseReference
    
    init() {
        deviceRef = self.ref.child(deviceId.lowercased())
    }
    
    
    func save(text: String, date: Date, key: String){
        let itemRef = deviceRef.child(key)
        let item = Reminder(text: text, dateTime: "\(date)", key: key)
        itemRef.setValue(item.toAnyObject())
    }
    
    func load() {
        deviceRef.observe(.value, with: { snapshot in
            Reminder.saved.removeAll()
            for item in snapshot.children {
                let item = Reminder(snapshot: item as! FIRDataSnapshot)
                 Reminder.saved.append(item)
            }
        })
    }
    
    func remove(ref: FIRDatabaseReference) {
        ref.removeValue()
    }

}
