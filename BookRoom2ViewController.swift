//
//  BookRoom2.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/22/22.
//

import Foundation
import UIKit



class BookRoom2ViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    static var cellReuseID: String = "BookingCell"
    var openRoomsAryDataSource: [openModel]
    var selectedRoom: String?
    var selectedDate: Int?
    var selectedRoomBookingTime: Int?
    
    
    @objc func didTapBookRoomBtn(indexPath: IndexPath) {
        print("didTapBookRoomBtn!")
        //get selected cell from active tableView
        let alertVC = self.buildAppAlertController(withMsg: .reservation)
        guard let selectedCell = self.tableView.cellForRow(at: indexPath) as? RoomTableViewCell else {
            self.present(alertVC, animated: true)
            return
        }
        //get selected room info
        self.selectedRoom = selectedCell.roomNumberLabel.text
        self.selectedDate = openRoomsAryDataSource[indexPath.row].date
        self.selectedRoomBookingTime = openRoomsAryDataSource[indexPath.row].slots.first
        //pass selected room info to confirmVC
        if let confirmVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmVC") as? ConfirmViewController {
            //pass props into VC, then load view *precedential order*
            confirmVC.roomNumber = self.selectedRoom
            confirmVC.date = self.selectedDate
            confirmVC.bookingTime = selectedRoomBookingTime
            confirmVC.loadViewIfNeeded()
            self.present(confirmVC, animated: true)
        } else {
            self.present(alertVC, animated: true)
        }
    }
    func layoutView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
//        self.view.backgroundColor = .orange
    }
    func layoutTableView() {
        tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: BookRoom2ViewController.cellReuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        //        tableView.backgroundColor = .green
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    override func viewWillAppear(_ animated: Bool) {
        layoutTableView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openRoomsAryDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookRoom2ViewController.cellReuseID, for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        
        let intDay = openRoomsAryDataSource[indexPath.row].date
        cell.dayOfWeekLabel.text = self.getDayOfWeekFromInt(intDay: intDay)
        //hydrate subviews in cell
        cell.roomNumberLabel.text = self.openRoomsAryDataSource[indexPath.row].roomNumber
        print("date: \(self.openRoomsAryDataSource[indexPath.row].date)")
        print("date + until: \(self.openRoomsAryDataSource[indexPath.row].date + 30)")
        let bookingTime = self.openRoomsAryDataSource[indexPath.row].slots.first ?? 0
        cell.untilLabelKey.text = "Until:"
        cell.untilLabel.text = "\(bookingTime + 30)"
        cell.bookRoomBtn.isUserInteractionEnabled = false
        cell.selectionStyle = .none
       return cell
    }
   
    
    init(openRooms dataSource: [openModel]) {
        self.openRoomsAryDataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("do not call this initializer, please use custom initializer")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BookRoom2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selected called....")
        didTapBookRoomBtn(indexPath: indexPath)
    }
}
