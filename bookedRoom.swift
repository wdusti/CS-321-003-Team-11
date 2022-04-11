import SwiftUI

struct bookedModel: Codable {
    let date: Int
    let roomNumber: String
    let uname: String
    var slot: [Int]
}

private let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
private let path = directory!.appendingPathComponent("bookedData.json")

//Creates built in decoder and encoder
private let decoder = JSONDecoder()
private let encoder = JSONEncoder()

//Function to return the user's booked rooms
//str = the uname of the user
func getBooked(str: String) -> [bookedModel] {
    //read data from JSON
    let decoder = JSONDecoder()
    let data = try decoder.decode([bookedModel].self, from: JSONdata)
    
    //filters bookedModel with matching uname(username)
    let ret = data.filter {$0.uname == uname}
    
    return ret
}

//function to book a time slot
func addtoBooked(date: Int, roomNumber: String, uname: String, slot: [Int]) -> Void {
    //read contents of JSON file
    let JSONdata = try Data(contentsOf: path)
    var data = try decoder.decode([bookedModel].self, from: JSONdata)
    
    //adds the booking to the array of JSON objects
    data.append(bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot))
    
    //writes array of JSON objects to file
    let str = try encoder.encode(data)
    try str.write(to: path)
}
