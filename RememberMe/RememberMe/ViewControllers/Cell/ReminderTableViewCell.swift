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
        dateLabel.text = reminder.dateTime
    }

}
