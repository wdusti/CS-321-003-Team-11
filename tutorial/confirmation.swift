//
//  confirmation.swift
//  testBB
//
//  Created by Dustin Wong on 4/22/22.
//

import UIKit

class confirmation: UIViewController {
    
    var start: Int = -1
    var date: Int = -1
    var end: Int = -1
    var room: Int = -1
    
    @IBOutlet weak var label: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        label?.text = String("\(date)...\(start)-\(end) in \(room)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
