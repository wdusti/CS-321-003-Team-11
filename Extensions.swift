//
//  Extensions.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/24/22.
//

import Foundation
import UIKit

enum AppErrorMsg: String {
        case reservation =  "Sorry, we cannot process this reservation at this time"
        case saveBookedRoom = "Sorry, we are not able to book this room. Error: addtoBooked(...) failure"
    }
extension UIViewController {
    
    func getDayOfWeekFromInt(intDay: Int) -> String {
            let day = DayOfWeek(rawValue: intDay) ?? DayOfWeek.Sunday
            return "Day Of Week: \(day)"
        }
    func buildAppAlertController(withMsg: AppErrorMsg) -> UIAlertController {
        let alertVC = UIAlertController(title: "Internal Error", message: withMsg.rawValue, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .destructive)
                alertVC.addAction(alertAction)
        return alertVC
    }
}
