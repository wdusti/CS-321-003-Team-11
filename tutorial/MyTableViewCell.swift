//
//  MyTableViewCell.swift
//  testBB
//
//  Created by Dustin Wong on 4/22/22.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func onClick(with title: String, with room: String)
}

class MyTableViewCell: UITableViewCell {

    weak var delegate: MyTableViewCellDelegate?
    
    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    private var title: String = ""
    private var room: String = ""
    
    @IBAction func onClick() {
        delegate?.onClick(with: title, with: room)
    }
    
    func configure(with title: String, with room: String) {
        self.title = title
        self.room = room
        button.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.link, for: .normal)
    }
    
}
