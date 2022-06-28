//
//  LocalDataManager.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import CoreData
import SwiftUI

class LocalDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "MyClients")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load. Error: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        
    }
    
    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
