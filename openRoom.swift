import SwiftUI

struct openModel: Decodable {
    let date: Int
    let roomNumber: String
    var slots: [Int]
}

//Finds the file in the document directory
private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("openData.json")

//Gets the contents of the file as Data
private let JSONdata = try Data(contentsOf: path)

//Creates built in decoder and decodes the data into the protocol defined by openModel
private let decoder = JSONDecoder()
private let data = try decoder.decode([openModel].self, from: JSONdata)

//Function to get rooms open on the given date and startTime
func getOpen(date: Int, startTime: Int) -> [openModel] {
    //mutable array of openModel to store all possible bookings
    //tldr; dynamic array list
    var ret: [openModel] = []
    
    //loop appending possible bookings
    for i in data {
        //adds the openModel if the date has the given startTime
        if(i.date == date && i.slots.contains(startTime)) {
            ret.append(i)
        }
    }
    
    return ret
}
