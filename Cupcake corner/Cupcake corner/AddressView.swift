//
//  AddressView.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.newOrder.name)
                TextField("Address", text: $order.newOrder.address)
                TextField("City", text: $order.newOrder.city)
                TextField("Zip code", text: $order.newOrder.zipCode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Proceed to checkout")
                }
            }.disabled(!order.hasValidAddress)
        }.navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
