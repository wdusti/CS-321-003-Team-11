import Foundation
let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("info.txt")

func createAcc(id: String, pass: String) -> Void {
    //Function will write to a file, file stores all account information > server replacement

    let str = id + " " + pass + " 1,"
    str.write(to: path)    //, atomically: true, encoding: String.encoding.utf8)
    return
} 

func login(id: String, pass:String) -> Bool {
    //Function will parse/read from file with account information, if match is found allow access
    return true
}