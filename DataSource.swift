//
//  DataSource.swift
//  GMUBooking
//
//  Created by Emil Natour on 4/23/22.
//

import Foundation



struct RoomData: Decodable {
    var date: Int?
    var roomNumber: String?
    var slots: [Int]?
}

struct AvailableRooms: Decodable {
    var rooms: [RoomData]
}

