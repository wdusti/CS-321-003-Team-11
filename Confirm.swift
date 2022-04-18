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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
