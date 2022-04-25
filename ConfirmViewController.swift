//
//  Confirm.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/6/22.
//

import UIKit

class ConfirmViewController: UIViewController {

    //outlets
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var bookingTimeLabel: UILabel!
    
    //ivars
    var roomNumber : String?
    var bookingTime: Int?
    var date: Int?
    var userBookingsVCID = "UserBookingsVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        if let roomNumber = roomNumber, let bookingTime = bookingTime {
            roomNumberLabel.text = roomNumber
            bookingTimeLabel.text = "\(bookingTime)"
        } else {
            roomNumberLabel.text = "No Room Selected"
            bookingTimeLabel.text = "No Time Selected"
        }
    }
    @IBAction func didTapConfirmBookingBtn(_ sender: Any) {
        guard let date = self.date, let bookingTime = self.bookingTime, let roomNumber = self.roomNumber else {
            let alertVC = self.buildAppAlertController(withMsg: .reservation)
            self.present(alertVC, animated: true)
            return
        }
        
        //save booked room and launch the user bookings view controller
        // otherwise, show booked rooms persistance error
        guard let _ = BookedRooms().addtoBooked(date: date, roomNumber: roomNumber, slot: [bookingTime]), let userBookingsVC = self.storyboard?.instantiateViewController(withIdentifier: self.userBookingsVCID) as? ShowUsersBookingsViewController else {
            let alertVC = self.buildAppAlertController(withMsg: .saveBookedRoom)
            self.present(alertVC, animated: true)
            return
        }
        self.present(userBookingsVC, animated: true)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
