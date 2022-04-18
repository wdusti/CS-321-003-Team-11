//
//  BookRoom.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/4/22.
//

import UIKit
import roomFrame

class BookRoom: UIViewController {
    
    let roomData: openRooms = openRooms();
    
    @IBOutlet weak var Room3104: UIButton!
    @IBOutlet weak var Room3105: UIButton!
    @IBOutlet weak var Room3106: UIButton!
    @IBOutlet weak var Room3107: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func availableRooms(){
        
    }
   
    
}

