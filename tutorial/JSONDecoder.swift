import SwiftUI

struct testModel: Decodable {
    let id: Int
    let name: String
}

let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("mockData.json")
print(path)

let str = try Data(contentsOf: path)
print(str)

let decoder = JSONDecoder()
let product = try decoder.decode([testModel].self, from: str)
print(product)

print(product[0].name)

//will be applying the concept of decoding/encoding into the read/write functions for the bookings and what not
