//
//  ConsultTableViewCell.swift
//  RememberMe
//
//  Created by Joao Anjos on 05/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func setup(reminder: Reminder) {
        titleLabel.text = reminder.text
        
        //Format Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZ"
        
        let dateObj = dateFormatter.date(from: reminder.dateTime)
        dateFormatter.dateFormat = "EEE, MMM dd yyyy hh:mm"
        
        dateLabel.text = dateFormatter.string(from: dateObj!)
    }

}
