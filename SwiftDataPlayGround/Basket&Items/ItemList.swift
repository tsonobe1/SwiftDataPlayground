//
//  ItemList.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/06.
//

import SwiftUI
import SwiftData

struct ItemList: View {
    @Environment(\.modelContext) private var context
    
    @State private var showReviewScreen: Bool = false
    
    @Bindable var basket: Basket
    
    
    var body: some View {
        VStack{
            //            let _ = print(items)
            List {
                if basket.items.isEmpty {
                    ContentUnavailableView {
                        Label("No Item", systemImage: "shippingbox.fill")
                    } description: {
                        Text("No items")
                    }
                } else {
                    ForEach(basket.items, id: \.self) { item in
                        VStack{
                            Text(item.name)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Add"){
                            let newItem = Item(timestamp: Date(), name: "New")
                            basket.items.append(newItem)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ItemList(items: [])
//}
