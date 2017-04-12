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
    
    func save(text: String, date: Date, key: String,
              onSuccess: @escaping ()-> Void,
              onFailure: @escaping(_ error: Error) -> Void,
              onCompleted: @escaping ()-> Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let itemRef = deviceRef.child(key)
        let item = Reminder(text: text, dateTime: "\(date)", key: key)
        
        itemRef.setValue(item.toAnyObject()) { (error, databaseReference) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            if error == nil {
               onSuccess()
            } else {
                onFailure(error!)
            }
            
             onCompleted()
        }

    }
    
    func load(completed: @escaping ()-> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        deviceRef.observe(.value, with: { snapshot in
            Reminder.saved.removeAll()
            for item in snapshot.children {
                let item = Reminder(snapshot: item as! FIRDataSnapshot)
                 Reminder.saved.append(item)
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completed()
        })
    }
    
    func remove(ref: FIRDatabaseReference,
                onSuccess: @escaping ()-> Void,
                onFailure: @escaping(_ error: Error) -> Void,
                onCompleted: @escaping ()-> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ref.removeValue { (error, databaseReference) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if error == nil {
                onSuccess()
            } else {
                onFailure(error!)
            }
            
            onCompleted()
        }
    }

}
