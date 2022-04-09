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

//Function is called after getting date and startTime from user through UI
//returns end times
func getOpen(date: Int, startTime: Int) -> [openModel] {
    //mutable array of openModel to store all possible bookings
    //tldr; dynamic array list
    var ret: [openModel] = []
    
    //loop appending possible bookings
    for i in data {
        //appends an array of openModels
        if(i.date == date && i.slots.contains(startTime)) {
            //filters slots to consecutive slots greater than startTime
            let end = i.slots.filter {$0 > startTime && !i.slots.contains($0 + 15)}
            let temp = openModel(date: date, roomNumber: i.roomNumber, slots: i.slots.filter {$0 > startTime && $0 <= end.min()!})
            
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

