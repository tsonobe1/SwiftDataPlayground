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
    
    @Query var Folders: [Folder]
    
    
    
    
    
    var body: some View {
        let _ = print(noParentFolders)
        let _ = print(Folders)
        NavigationStack{
            VStack{
                List {
                    ForEach(noParentFolders){ folder in
                        NavigationLink {
                            FolderDetail(folder: folder)
                        } label: {
                            Text(folder.name)
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

#Preview {
    FolderListView()
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
        VStack{
            ForEach(depthCounts.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("Depth: \(key), Count: \(value)")
            }
            List{
                ForEach(folder.children){ child in
                    NavigationLink {
                        FolderDetail(folder: child)
                    } label: {
                        Text(child.name)
                    }
                }
                Button("add"){
                    let new = Folder(id: UUID(), name: "New child", createdData: Date())
                    new.parent = folder
//                    try? context.save()
                    
                    folder.children.append(new)
                }
            }
        }
    }
    

    func countNodes(root: Folder?, depth: Int = 0, counts: inout [Int: Int]) {
        guard let root = root else { return }
        
        // この深さでのノード数を1つ増やす
        counts[depth, default: 0] += 1

        // 子ノードに対しても同様の処理を行う
        for child in root.children {
            countNodes(root: child, depth: depth + 1, counts: &counts)
        }
    }
}
