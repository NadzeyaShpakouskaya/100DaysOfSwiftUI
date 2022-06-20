//
//  Order.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        
        // we need to switch off extra frosting and sprinkles toggles, when disable special request
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zipCode = ""
    
    // use computed property to check if address is valid or not
    var hasValidAddress: Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        return true
    }
    
    // use property to calculate cost the order
    
    var cost: Double {
        // $2 per cake
           var cost = Double(quantity) * 2

           // complicated cakes cost more
           cost += (Double(type) / 2)

           // $1/cake for extra frosting
           if extraFrosting {
               cost += Double(quantity)
           }

           // $0.50/cake for sprinkles
           if addSprinkles {
               cost += Double(quantity) / 2
           }

           return cost
        
    }
}
