//
//  ShowUsersBookings.swift
//  GMUBooking
//
//  Created by Emil Natour on 3/28/22.
//

import UIKit
import SwiftUI

enum DayOfWeek: Int { case Sunday = 1, Monday, TuesDay, Wednesday, Thursday, Friday }
class ShowUsersBookingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellReuseID = "BookingCell"
    var bookedRoomsDataSource: [bookedModel]
    
    
    func layoutView() {
        if shouldShowTableView() {
            tableView.isHidden = false
            layoutTableView()
        } else {
            tableView.isHidden = true
        }
    }
    func shouldShowTableView() -> Bool {
        return bookedRoomsDataSource.count > 0
    }
    func layoutTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        self.bookedRoomsDataSource = BookedRooms().getAllBooksRooms()
        super.init(coder: coder)
    }
}

extension ShowUsersBookingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookedRoomsDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseID, for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        cell.untilLabelKeyTopConstraint.constant = 26.0
        cell.selectionStyle = .none
        cell.bookRoomBtn.isHidden = true
        cell.roomNumberLabel.text = bookedRoomsDataSource[indexPath.row].roomNumber
        cell.untilLabelKey.text = "Reservation Time:"
        cell.untilLabel.text = "\(bookedRoomsDataSource[indexPath.row].slot.first ?? 0)"
        let intDay = bookedRoomsDataSource[indexPath.row].date
        cell.dayOfWeekLabel.text = self.getDayOfWeekFromInt(intDay: intDay)
        return cell
    }
}

extension ShowUsersBookingsViewController: UITableViewDelegate {
    
}
