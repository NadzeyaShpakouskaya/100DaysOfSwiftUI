//
//  DataManager.swift
//  Bookworm
//
//  Created by Nadzeya Shpakouskaya on 22/06/2022.
//

import CoreData
import Foundation

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load. Error: \(error.localizedDescription)")
            }
        }
    }
}
