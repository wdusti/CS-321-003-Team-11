import Foundation
import SwiftUI

struct openModel: Codable {
    let date: Int
    let roomNumber: String
    var slots: [Int]
}

public class openRooms {
    
    //Finds the file in the document directory
    private var directory: URL //= FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private var path: URL //= directory!.appendingPathComponent("openData.json")

    //Creates built in decoder and encoder used to convert data into JSON format
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    //initialization
    public init() throws {
        self.directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(self.directory)
        self.path = directory.appendingPathComponent("openData.json")
    }
    
    //Function is called after getting date and startTime from user through UI
    //returns end times
    func getOpen(date: Int, startTime: Int) throws -> [openModel] {
        //decodes JSON data
        let JSONdata = try Data(contentsOf: path)
        let data = try decoder.decode([openModel].self, from: JSONdata)
    
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
    /*
    What to do with this. In the UI, you will need to display the room number and the end times.
    The room number will be given as the return is an array of openModel.
    The end times are the slots of the returned struct.
    */
    }

    //function to add a booked room back into open
    //alternate implementation - bookedModel as input param
    func addtoOpen(date: Int, roomNumber: String, slots: [Int]) throws -> Void {
        //decode JSON data
        let JSONdata = try Data(contentsOf: path)
        var data = try decoder.decode([openModel].self, from: JSONdata)
    
        //find JSON object matching given date and room number
        let index = data.firstIndex(where: {$0.date == date && $0.roomNumber == roomNumber})
        //combines 'booked' slots and open slots
        data[index!].slots.append(contentsOf: slots)

        //writing to file
        let str = try encoder.encode(data)
        try str.write(to: path)
    }

    //function to remove a period from open
    //to be used in conjunction with with booking a room
    func removefromOpen(date: Int, roomNumber: String, startTime: Int, endTime: Int) throws -> [Int] {
        //decode JSON data
        let JSONdata = try Data(contentsOf: path)
        var data = try decoder.decode([openModel].self, from: JSONdata)
    
        //find JSON object matching given date and room number
        let index = data.firstIndex(where: {$0.date == date && $0.roomNumber == roomNumber})
        //removing a block of time
        var period = data[index!].slots
        data[index!].slots.removeAll(where: {$0 >= startTime && $0 <= endTime})
        period.removeAll(where: {$0 < startTime && $0 > endTime})
    
        //writing to file
        let str = try encoder.encode(data)
        try str.write(to: path)
    
        return period
    }
}
