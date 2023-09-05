//
//  Item.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/05.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
