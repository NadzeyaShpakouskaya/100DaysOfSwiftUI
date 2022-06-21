//
//  Order.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
// to conform Codable protocol
    enum CodingKeys: CodingKey {
        case newOrder
    }
 
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var newOrder = OrderModel(type: 0, quantity: 3, extraFrosting: false, addSprinkles: false, name: "", address: "", city: "", zipCode: "")
    
    // use computed property to check if address is valid or not
    var hasValidAddress: Bool {
        if newOrder.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || newOrder.address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || newOrder.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || newOrder.zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    // use property to calculate cost the order
    var cost: Double {
        // $2 per cake
        var cost = Double(newOrder.quantity) * 2

           // complicated cakes cost more
        cost += (Double(newOrder.type) / 2)

           // $1/cake for extra frosting
        if newOrder.extraFrosting {
            cost += Double(newOrder.quantity)
           }
        
           // $0.50/cake for sprinkles
        if newOrder.addSprinkles {
            cost += Double(newOrder.quantity) / 2
           }

           return cost
    }
    
// to conform Decodable protocol
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        newOrder = try container.decode(OrderModel.self, forKey: .newOrder)
    }

    // we can use empty init for our order
    init(){}

// to conform Encodable protocol
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(newOrder, forKey: .newOrder)
    }
}
