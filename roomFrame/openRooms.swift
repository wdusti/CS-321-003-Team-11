import SwiftUI

public struct openModel: Codable {
    public let date: Int
    public let roomNumber: String
    public var slots: [Int]
}

public class openRooms {
    
    //URLs for finding the JSON files
    private var directory: URL
    private var path: URL

    //Creates built in decoder and encoder used to convert data into JSON format
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    //initialization
    public init() {
        //temporary URL for documents - replace dwong with USER
        self.directory = URL(string: "file:///Users/dwong/Documents")! //= FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.path = directory.appendingPathComponent("openData.json")
    }
    
    //Function is called after getting date and startTime from user through UI
    //returns end times
    public func getOpen(date: Int, startTime: Int) -> [openModel] {
        //decodes JSON data
        let JSONdata = try! Data(contentsOf: path)
        let data = try! decoder.decode([openModel].self, from: JSONdata)
    
        //mutable array of openModel to store all possible bookings
        //tldr; dynamic array list
        var ret: [openModel] = []
    
        //loop appending possible bookings
        for i in data {
            //appends an array of openModels
            if(i.date == date && i.slots.contains(startTime)) {
                //filters slots to only greater than the startTime
                let end = i.slots.filter {$0 > startTime && !i.slots.contains($0 + 15)}
                let temp = openModel(date: date, roomNumber: i.roomNumber, slots: i.slots.filter {$0 > startTime && $0 < end.min()! + 15})
        
                ret.append(temp)
            }
        }
    
        return ret
    }

    //function to add a booked room back into open
    //alternate implementation - bookedModel as input param
    public func addtoOpen(date: Int, roomNumber: String, slots: [Int]) -> Void {
        //decode JSON data
        let JSONdata = try! Data(contentsOf: path)
        var data = try! decoder.decode([openModel].self, from: JSONdata)
    
        //find JSON object matching given date and room number
        let index = data.firstIndex(where: {$0.date == date && $0.roomNumber == roomNumber})
        //combines 'booked' slots and open slots
        data[index!].slots.append(contentsOf: slots)

        //writing to file
        let str = try! encoder.encode(data)
        try! str.write(to: path)
    }

    //function to remove a period from open
    //to be used in conjunction with with booking a room
    public func removefromOpen(date: Int, roomNumber: String, startTime: Int, endTime: Int) -> [Int] {
        //decode JSON data
        let JSONdata = try! Data(contentsOf: path)
        var data = try! decoder.decode([openModel].self, from: JSONdata)
    
        //find JSON object matching given date and room number
        let index = data.firstIndex(where: {$0.date == date && $0.roomNumber == roomNumber})
        //removing a block of time
        var period = data[index!].slots
        data[index!].slots.removeAll(where: {$0 >= startTime && $0 <= endTime})
        period.removeAll(where: {$0 < startTime && $0 > endTime})
    
        //writing to file
        let str = try! encoder.encode(data)
        try! str.write(to: path)
    
        return period
    }
}
