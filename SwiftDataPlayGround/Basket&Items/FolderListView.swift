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
    @Query(filter: #Predicate<Folder> { $0.parent == nil },
             sort: [SortDescriptor(\.createdData)] )
    var noParentFolders: [Folder]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                ScrollView {
                    ForEach(noParentFolders){ folder in
                        NavigationLink {
                            FolderDetail(folder: folder)
                        } label: {
                            HStack{
                                Image(systemName: "folder")
                                Text(folder.name)
                            }
                            .foregroundStyle(.blue.gradient)
                            .frame(maxWidth: .infinity)
                            .border(.blue)
                        }
                    }
                }
                Button("add"){
                    let new = Folder(id: UUID(), name: "New", createdData: Date())
                    context.insert(new)
                }
                Button("All Delete"){
                    try?context.delete(model: Folder.self, includeSubclasses: false)
                }
            }
            .navigationTitle("Folders")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}




struct ParentPathView: View {
    let folder: Folder
    
    var body: some View {
        Text(generateParentPath(for: folder))
            .font(.footnote)
            .foregroundStyle(.secondary)
            .bold()
    }
    
    func generateParentPath(for folder: Folder) -> String {
        var path = ""
        var currentFolder: Folder? = folder.parent  // 最初に親に移動
        while let folder = currentFolder {
            if !path.isEmpty {
                path = " > " + path
            }
            path = folder.name + path
            currentFolder = folder.parent
        }
        if !path.isEmpty {
            path += " > "
        }
        return path
    }
}

struct FolderDetail: View {
    @Environment(\.modelContext) private var context
    let folder: Folder
    
    // 各深さでのフォルダ数を計算する
    var depthCounts: [Int: Int] {
        var counts: [Int: Int] = [:]
        countDepth(for: folder, currentDepth: 0, counts: &counts)
        return counts
    }
    
    // 再帰的に深さとその階層でのフォルダ数を計算
    private func countDepth(for folder: Folder, currentDepth: Int, counts: inout [Int: Int]) {
        counts[currentDepth, default: 0] += 1
        for child in folder.children {
            countDepth(for: child, currentDepth: currentDepth + 1, counts: &counts)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: ParentPath
            if folder.parent != nil {
                ScrollView(.horizontal, showsIndicators: false){
                    ParentPathView(folder: folder)
                }
            }
            
            // MARK: Folder Name
            HStack(alignment: .lastTextBaseline){
                Text(folder.name)
                    .font(.title)
                Text(folder.createdData, style: .date)
            }
            
            VStack(alignment: .leading){
                // Depth
                ForEach(depthCounts.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    Text("Depth: \(key), Count: \(value)")
                        .font(.caption)
                }
                
                // MARK: Children
                
                DisclosureGroup {
                    ScrollView{
                        ForEach(folder.children){ child in
                            NavigationLink {
                                FolderDetail(folder: child)
                            } label: {
                                HStack{
                                    Image(systemName: "folder")
                                    Text(child.name)
                                }
                            }
                        }
                        Button("add"){
                            let new = Folder(id: UUID(), name: "New child", createdData: Date())
                            new.parent = folder
                            folder.children.append(new)
                        }
                    }
                } label: {
                    Text("SubGoals")
                }

                
                
                
                
                
            }
        }
    }
}












struct FolderNest: View {
    @Environment(\.modelContext) private var context
    @Query(filter: #Predicate<Folder> { $0.parent == nil },
             sort: [SortDescriptor(\.createdData)] )
    var noParentFolders: [Folder]

    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView {
                    ForEach(noParentFolders){ folder in
                        FolderRow(folder: folder)
                    }
                }
                Button("add"){
                    let new = Folder(id: UUID(), name: "New", createdData: Date())
                    context.insert(new)
                }
                Button("All Delete"){
                    try?context.delete(model: Folder.self, includeSubclasses: false)
                }
            }
            .navigationTitle("Folders")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FolderRow: View {
    let folder: Folder
    @State private var isExpanded: Bool = false

    
    var body: some View {
        VStack{
            HStack{
                Text(folder.name)
                    .frame(maxWidth: .infinity)
                    .border(.blue)
                
                if !folder.children.isEmpty {
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 20))
                        .padding(.trailing, 20)
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                }
            }
            if isExpanded {
                ForEach(folder.children) { child in
                    FolderRow(folder: child)
                        .padding(.leading)
                }
            }
        }
    }
}
