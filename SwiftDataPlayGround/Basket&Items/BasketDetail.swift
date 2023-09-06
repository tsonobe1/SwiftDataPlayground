//
//  BasketDetail.swift
//  SwiftDataPlayGround
//
//  Created by tsonobe on 2023/09/06.
//

import SwiftUI

struct BasketDetail: View {
    @Environment(\.modelContext) private var context
    let basket: Basket
    
    var body: some View {
        VStack{
            ItemList(basket: basket)
        }
        .navigationTitle(basket.name + "TEST")
    }
}

//#Preview {
//    BasketDetail(basket: Basket)
//}
