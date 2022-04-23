//
//  ViewController.swift
//  testBB
//
//  Created by Dustin Wong on 4/22/22.
//

import UIKit
import roomFrame

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var openTest: openRooms = openRooms()
    var data: [openModel] = []
    
    var start: Int = 15
    var date: Int = 1
    private var end: Int = -1
    private var room: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = openTest.getOpen(date: date, startTime: start)
        
        table.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        table.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        
        var noon: String = "AM"
        var hour = (data[indexPath.section].slots[indexPath.row] + 15) / 60
        let minute = (data[indexPath.section].slots[indexPath.row] + 15) % 60
        
        if hour >= 12 {
            hour -= 12
            noon = "PM"
        }
        if hour == 0 {
            hour += 12
        }
        
        cell.configure(with: String(format: "Until %d:%.2d %@", hour, minute, noon), with: data[indexPath.section].roomNumber)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Fenwick Library Room \(data[section].roomNumber)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].slots.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is confirmation {
            let vc = segue.destination as? confirmation
            
            vc?.date = date
            vc?.start = start
            vc?.end = end
            vc?.room = room
        }
    }
}

extension ViewController: MyTableViewCellDelegate {
    func onClick(with title: String, with room: String) {
        
        let str = title.split(separator: " ")
        let time = str[1].split(separator: ":")
        
        var hour: Int = Int(time[0])!
        let minute: Int = Int(time[1])!
        if str[2] == "PM" {
            hour += 12
        }
        
        self.end = hour * 60 + minute - 15
        self.room = Int(room)!
        performSegue(withIdentifier: "nextView", sender: self)
    }
}
