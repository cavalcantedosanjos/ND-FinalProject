//
//  Reminder.swift
//  RememberMe
//
//  Created by Joao Anjos on 06/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import Firebase

struct Reminder {
    
    
    static var saved = [Reminder]()
    
    var key: String
    var text: String
    var dateTime: String
    let ref: FIRDatabaseReference?
    
    init(text: String, dateTime: String, key: String) {
        self.text = text
        self.dateTime = dateTime
        self.key = key
        self.ref = nil
    }
    
    func toAnyObject() -> Any {
        return [
            "text": text,
            "dateTime": dateTime
        ]
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        text = snapshotValue["text"] as! String
        dateTime = snapshotValue["dateTime"] as! String
        ref = snapshot.ref
    }
    
}
