//
//  FolderModel.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/09.

import SwiftUI
import SwiftData//


@Model
final class Folder {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var createdData: Date
    
    var parent: Folder?
    @Relationship(deleteRule:.cascade) var children: [Folder] = []
    
    init(id: UUID, name: String, createdData: Date) {
        self.id = UUID()
        self.name = name
        self.createdData = createdData
    }
}
