import SwiftUI

struct bookedModel: Decodable {
    let date: Int
    let roomNumber: String
    let uname: String
    var slot: [Int]
}

private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("bookedData.json")

//Gets the contents of the file as Data
private let JSONdata = try Data(contentsOf: path)

//Creates built in decoder and decodes the data into the protocol defined by openModel
private let decoder = JSONDecoder()
private let data = try decoder.decode([bookedModel].self, from: JSONdata)

//Function to return the user's booked rooms
//str = the uname of the user
func getBooked(str: String) -> [bookedModel] {
    //return value, array of bookedModel
    var ret: [bookedModel] = []
    
    //loop to append each bookedModel
    for i in data {
        //checks for uname match
        if(i.uname == str) {
            ret.append(i)
        }
    }
    
    return ret
}
