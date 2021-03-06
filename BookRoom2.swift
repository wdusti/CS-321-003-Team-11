//
//  BookRoom2.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/22/22.
//

import Foundation
import UIKit



class BookRoom2: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    static var cellReuseID: String = "Booking Cell"
    
    
    @objc func didTapBookRoomBtn(sender: UIButton) {
        print("didTapBookRoomBtn!")
    }
    func layoutView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
//        self.view.backgroundColor = .orange
    }
    func layoutTableView() {
        tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)), style: .plain)
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: BookRoom2.cellReuseID)
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
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell(style: .default, reuseIdentifier: "bookRoomCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookRoom2.cellReuseID, for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        cell.bookRoomLabel.addTarget(self, action: #selector(didTapBookRoomBtn(sender:)), for: .touchUpInside)
       return cell
    }
   
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BookRoom2: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
