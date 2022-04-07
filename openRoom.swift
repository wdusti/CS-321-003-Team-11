import SwiftUI

struct openModel: Decodable {
    let date: Int
    let roomNumber: String
    let slots: [Int]
}

//Finds the file in the document directory
let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("openData.json")

//Gets the contents of the file as Data
let JSONdata = try Data(contentsOf: path)

//Creates built in decoder and decodes the data into the protocol defined by openModel
let decoder = JSONDecoder()
let data = try decoder.decode([openModel].self, from: JSONdata)

//Function to get rooms open on the given date and startTime
func getOpen(date: Int, startTime: Int) -> [openModel] {
    //mutable array of openModel to store all possible bookings
    //tldr; dynamic array list
    var ret: [openModel] = []
    
    //loop appending possible bookings
    for i in data {
        //currently only adds rooms with the given date
        if(i.date == date) {
            ret.append(i)
        }
    }
    
    //returns all possible start times on the given date for the room
    return ret
}
