//
//  FolderListView.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/06.
//

import SwiftUI
import SwiftData

struct FolderListView: View {
    @Environment(\.modelContext) private var context
    @Query private var folders: [Folder]
    
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    ForEach(folders){ folder in
                        NavigationLink(value: folder){
                            Text(folder.name)
                        }
                    }
                }
                .navigationDestination(for: Folder.self) { folder in
                    Text(folder.name)
                }
                Button("add"){
                    let new = Folder(id: UUID(), name: "New", createdData: Date())
                    context.insert(new)
                }
            }
        }
    }
}

#Preview {
    FolderListView()
}
