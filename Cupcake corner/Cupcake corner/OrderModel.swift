//
//  OrderModel.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 21/06/2022.
//

import Foundation

struct OrderModel: Codable {
    var type: Int
    var quantity: Int
    var extraFrosting: Bool
    var addSprinkles: Bool
    
    var name: String
    var address: String
    var city: String
    var zipCode: String
    
    var specialRequestEnabled = false {
        // we need to switch off extra frosting and sprinkles toggles, when disable special request
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}
