//
//  DataManager.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//

import CoreData
import Foundation

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "CDProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load. Error: \(error.localizedDescription)")
                return
            }
            
            // resolve conflicts for constraints in Entities and merge the same property objects
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
