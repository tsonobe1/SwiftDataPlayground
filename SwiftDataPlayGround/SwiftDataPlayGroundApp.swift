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
            TabView() {
                FolderListView()
                    .tag(1)
                    .tabItem {
                        Label("List", systemImage: "folder")
                    }
                FolderNest()
                    .tag(2)
                    .tabItem {
                        Label("Nest", systemImage: "folder.fill")
                    }
               
            }
        }
        .modelContainer(for: Folder.self)
    }
}
