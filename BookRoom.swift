//
//  BookRoom.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/4/22.
//

import UIKit
import roomFrame

class BookRoom: UIViewController {
    
    var roomNumber : Int = 0
    
    @IBOutlet weak var room3104: UIButton!
    @IBOutlet weak var room3105: UIButton!
    @IBOutlet weak var room3106: UIButton!
    @IBOutlet weak var room3107: UIButton!
    
    let roomData: openRooms = openRooms();
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func room3104Pressed(_ sender: UIButton) {
        if(sender.titleLabel!.text == "Book Room 3104"){
            roomNumber = 3104
            performSegue(withIdentifier: "BookRoomToConfirm", sender: self)
        }
    }
    
    @IBAction func room3105Pressed(_ sender: UIButton) {
        if(sender.titleLabel!.text == "Book Room 3105"){
            roomNumber = 3105
            performSegue(withIdentifier: "BookRoomToConfirm", sender: self)
        }
    }
    
    @IBAction func room3106Pressed(_ sender: UIButton) {
        if(sender.titleLabel!.text == "Book Room 3106"){
            roomNumber = 3106
            performSegue(withIdentifier: "BookRoomToConfirm", sender: self)
        }
    }
    
    @IBAction func room3107Pressed(_ sender: UIButton) {
        if(sender.titleLabel!.text == "Book Room 3107"){
            roomNumber = 3107
            performSegue(withIdentifier: "BookRoomToConfirm", sender: self)
        }
    }
    
//    func getRoomData(){
//        roomData.getOpen(date: dateTF, startTime: timeTF)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "BookRoomToConfirm"){
            let destinationVC = segue.destination as? Confirm
            destinationVC?.roomNumber = roomNumber
        }
    }
    
}

