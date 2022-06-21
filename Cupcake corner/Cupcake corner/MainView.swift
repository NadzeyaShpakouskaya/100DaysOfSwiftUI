//
//  MainView.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose your favorite cupcake", selection: $order.newOrder.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cupcakes: \(order.newOrder.quantity)", value: $order.newOrder.quantity, in: 3...20)
                }
                
                Section {
                    // Add animation to show frosting and sprinkles rows
                    Toggle("Any special requests?", isOn: $order.newOrder.specialRequestEnabled.animation())
                    
                    // show frosting and sprinkles only if special request is toggled
                    if order.newOrder.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.newOrder.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.newOrder.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery address details")
                    }
                }
            }.navigationTitle("Cupcake Corner")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
