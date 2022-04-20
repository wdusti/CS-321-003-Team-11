//
//  ContentView.swift
//  bookingApp
//
//  Created by Dustin Wong on 4/18/22.
//

import SwiftUI
import roomFrame

let openTest: openRooms = openRooms()

struct itemRow: Identifiable {
    let id = UUID()
    let text: String
    var open: [itemRow]?
    
    init(_ text: String) {
        self.text = text
    }
}

struct completeList: View {
    var arr = openTest.getOpen(date: 1, startTime: 15)
    var count = 0
    var items: [itemRow] = []
    var subitems: [[itemRow]] = []
    
    init() {
        arr.forEach {i in
            self.items.append(itemRow(i.roomNumber))
            
            self.subitems.append([])
            i.slots.forEach {j in
                self.subitems[count].append(itemRow(String(j)))
            }
            
            self.items[count].open = self.subitems[count]
            count += 1
        }
    }
    
    var body: some View {
        List(items, children: \.open) { item in
            HStack {
                Text(item.text)
                    .font(.system(.title3, design: .rounded))
                    .bold()
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        completeList()
    }
}
