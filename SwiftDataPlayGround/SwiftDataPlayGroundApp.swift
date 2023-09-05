//
//  SwiftDataPlayGroundApp.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/05.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPlayGroundApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
