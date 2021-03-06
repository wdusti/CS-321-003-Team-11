//
//  SelectTime.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/10/22.
//

import UIKit
import SwiftUI

class SelectTime: UIViewController{
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker()
        let timePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date())
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChange(timePicker:)), for: UIControl.Event.valueChanged)
        timePicker.preferredDatePickerStyle = .wheels
        timeTF.inputView = timePicker
        timeTF.text = formatTime(time: Date())
        timePicker.minuteInterval = 30
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    @objc func timeChange(timePicker: UIDatePicker){
        timeTF.text = formatTime(time: timePicker.date)
    }
    
    @IBAction func continueSegue(_ sender: Any) {
        let openRoomsAry = OpenRooms().getOpen(date: 1, startTime: 1200)
        let bookRoom2VC = BookRoom2ViewController(openRooms: openRoomsAry)
        bookRoom2VC.modalPresentationStyle = .fullScreen
        bookRoom2VC.loadView()
        self.present(bookRoom2VC, animated: true)
    }
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    func formatTime(time: Date) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
    
//    func dateToInt(date: Date){
//        if(dateTF == "[Monday]+@[gmu]{3}
//    }
           
}
