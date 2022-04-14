import SwiftUI

public struct bookedModel: Codable, Equatable {
    public let date: Int
    public let roomNumber: String
    public let uname: String
    public var slot: [Int]
}

public class bookedRoom {
    
    private let directory: URL
    private let path: URL

    //Creates built in decoder and encoder
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    public init() {
        //temporary fix, replace dwong with user folder on path
        self.directory = URL(string: "file:///Users/dwong/Documents")! //= FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.path = directory.appendingPathComponent("bookedData.json")
    }

    //Function to return the user's booked rooms
    //str = the uname of the user
    public func getBooked(uname: String) -> [bookedModel] {
        //read data as JSON
        let JSONdata = try! Data(contentsOf: path)
        let data = try! decoder.decode([bookedModel].self, from: JSONdata)
    
        //filters bookedModel with matching uname(username)
        let ret = data.filter {$0.uname == uname}
    
        return ret
    }

    //function to book a time slot
    public func addtoBooked(date: Int, roomNumber: String, uname: String, slot: [Int]) -> Void {
        //read contents of JSON file
        let JSONdata = try! Data(contentsOf: path)
        var data = try! decoder.decode([bookedModel].self, from: JSONdata)
    
        //adds the booking to the array of JSON objects
        data.append(bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot))
    
        //writes array of JSON objects to file
        let str = try! encoder.encode(data)
        try! str.write(to: path)
    }

    //function to cancel a booked time slot
    //FIXME - should return what was removed, to be added to the openRooms
    public func removefromBooked(date: Int, roomNumber: String, uname: String, slot: [Int]) -> Void {
        //read contents of JSON file
        let JSONdata = try! Data(contentsOf: path)
        var data = try! decoder.decode([bookedModel].self, from: JSONdata)
    
        //removes bookedModel from array of JSON objects
        data.removeAll(where: {$0 == bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot)})
    
        //writes array of JSON objects to file
        let str = try! encoder.encode(data)
        try! str.write(to: path)
    }
}
