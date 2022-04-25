//
//  RoomTableViewCell.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/23/22.
//

import Foundation
import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var untilLabelKey: UILabel!
    @IBOutlet weak var untilLabel: UILabel!
    @IBOutlet weak var bookRoomBtn: UIButton!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    @IBOutlet weak var untilLabelKeyTopConstraint: NSLayoutConstraint!
    
}
