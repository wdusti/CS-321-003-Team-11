import SwiftUI

struct bookedModel: Codable, Equatable {
    let date: Int
    let roomNumber: String
    let uname: String
    var slot: [Int]
}
public class bookedRoom {
    private let directory: URL //= FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private let path: URL //= directory!.appendingPathComponent("bookedData.json")

    //Creates built in decoder and encoder
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    public init() {
        self.directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.path = directory.appendingPathComponent("bookedData.json")
    }

    //Function to return the user's booked rooms
    //str = the uname of the user
    func getBooked(uname: String) throws -> [bookedModel] {
        //read data as JSON
        let JSONdata = try Data(contentsOf: path)
        let data = try decoder.decode([bookedModel].self, from: JSONdata)
    
        //filters bookedModel with matching uname(username)
        let ret = data.filter {$0.uname == uname}
    
        return ret
    }

    //function to book a time slot
    func addtoBooked(date: Int, roomNumber: String, uname: String, slot: [Int]) throws -> Void {
        //read contents of JSON file
        let JSONdata = try Data(contentsOf: path)
        var data = try decoder.decode([bookedModel].self, from: JSONdata)
    
        //adds the booking to the array of JSON objects
        data.append(bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot))
    
        //writes array of JSON objects to file
        let str = try encoder.encode(data)
        try str.write(to: path)
    }

    //function to cancel a booked time slot
    func removefromBooked(date: Int, roomNumber: String, uname: String, slot: [Int]) throws -> Void {
        //read contents of JSON file
        let JSONdata = try Data(contentsOf: path)
        var data = try decoder.decode([bookedModel].self, from: JSONdata)
    
        //removes bookedModel from array of JSON objects
        data.removeAll(where: {$0 == bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot)})
    
        //writes array of JSON objects to file
        let str = try encoder.encode(data)
        try str.write(to: path)
    }
}
