import SwiftUI

struct account {
    let uname: String
    var pass: String
    var auth: Bool
}

//account manager class for handling login and confirmation
public class accManager {
    //for finding document in directory
    private let directory: URL
    private let path: URL
    
    //built in decoder and encoder for JSON data
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    //initializing the accManager object
    public init() {
        self.directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.path = directory.appendingPathComponent("accounts.JSON")
    }
    
    //login function - checking whether all fields are valid
    func login(uname: String, pass: String) -> Bool {
        let JSONdata = try Data(contentsOf: path)
        let data = decoder.decode([account].self, from: JSONdata)
        
        return data.contains(account(uname: uname, pass: pass, auth: true))
    }
}
