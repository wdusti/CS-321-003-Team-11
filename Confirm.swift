//
//  Confirm.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/6/22.
//

import UIKit

class Confirm: UIViewController {
    
    var roomNumber : Int = 0

    @IBOutlet weak var RoomNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RoomNumberLabel.text = "Room \(roomNumber)"
    }
}
