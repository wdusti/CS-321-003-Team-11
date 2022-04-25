import SwiftUI

public struct bookedModel: Codable, Equatable {
    public let date: Int
    public let roomNumber: String
    public let uname: String
    public var slot: [Int]
}

public class BookedRooms {
    
    private let directory: URL
    private let path: URL

    //Creates built in decoder and encoder
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    public init() {
            if let relativePath = Bundle.main.path(forResource: "bookedData", ofType: "json") {
                    let relativePathUrl = URL(fileURLWithPath: relativePath)
                    self.path = relativePathUrl
                    self.directory = relativePathUrl //possible redundancy
            } else {
                    self.path = URL(fileURLWithPath: "")
                    self.directory = URL(fileURLWithPath: "")
                    #warning("this line should not be triggered")
                }
        }
    //Function to get all booked rooms from user
    public func getAllBooksRooms() -> [bookedModel] {
               //read data as JSON
               let JSONdata = try! Data(contentsOf: path)
               let data = try! decoder.decode([bookedModel].self, from: JSONdata)
            return data
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

    private func createBookedDataJSONfile(bookedModelAry: [bookedModel]) -> [bookedModel]? {
           // Transform array into data and save it into file
        guard let data = try? JSONSerialization.data(withJSONObject:  bookedModelAry, options: []), let _ = try? data.write(to: self.path, options: []) else {
            return nil
        }
        var bookedModelAry = try? decoder.decode([bookedModel].self, from: data)
        return bookedModelAry
    }
    //function to book a time slot
    // return value -> the booked room `bookedModel`
    public func addtoBooked(date: Int, roomNumber: String, uname: String = "temp@gmu.edu", slot: [Int]) -> [bookedModel]? {

        //read file or create it if does not exist
        guard let JSONdata = try? Data(contentsOf: path), var bookedDataAry = try? decoder.decode([bookedModel].self, from: JSONdata) else {
            let bookModel = bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot)
            let savedBookModel = createBookedDataJSONfile(bookedModelAry: [bookModel])
            return savedBookModel }
        let bookedModel = bookedModel(date: date, roomNumber: roomNumber, uname: uname, slot: slot)
        //adds the booking to the array of JSON objects
        bookedDataAry.append(bookedModel)

        //writes array of JSON objects to file
        let str = try! encoder.encode(bookedDataAry)
        try! str.write(to: path)
        return bookedDataAry
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
