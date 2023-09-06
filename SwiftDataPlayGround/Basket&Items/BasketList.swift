//
//  BasketList.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/06.
//

import SwiftUI
import SwiftData

struct BasketList: View {
    @Environment(\.modelContext) private var context
    @Query private var baskets: [Basket]
    
    private func newItem(){
        let new = Basket(name: "newBasket")
        context.insert(new)
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let basket = baskets[index]
            context.delete(basket)
        }
    }
    
    private func update(_ basket: Basket){
        basket.name = "New 2"
        try? context.save()
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(baskets, id: \.self) { basket in
                        NavigationLink(value: basket){
                            Text(basket.name)
                       
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationDestination(for: Basket.self) { basket in
                    BasketDetail(basket: basket)
                }
                
                Button("Add basket") {
                    newItem()
                }
            }
            
        }
    }
    
}

#Preview {
    BasketList()
        .modelContainer(for: [Basket.self])
}
