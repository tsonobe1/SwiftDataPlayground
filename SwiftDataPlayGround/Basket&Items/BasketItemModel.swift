//
//  Item.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/05.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var name: String
    var basket: Basket?
    
    init(timestamp: Date, name: String) {
        self.timestamp = timestamp
        self.name = name
    }
}

@Model
final class Basket {
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var items: [Item] = []
    
    init(name: String) {
        self.name = name
    }
}

