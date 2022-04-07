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
