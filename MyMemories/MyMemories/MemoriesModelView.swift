//
//  MemoriesModelView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation
import SwiftUI


extension MemoriesListView {
    class ViewModel: ObservableObject {
        var dataManager: DataManager

        @Published var memories = [Memory]()
        @Published var showingAddMemoryView = false
        
        init(dataManager: DataManager) {
            self.dataManager = dataManager
            memories = dataManager.loadData()
        }
        
        func removeItems(at offsets: IndexSet) {
            dataManager.memories.remove(atOffsets: offsets)
            dataManager.save()
        }
        
        func showAddNewMemory() {
            showingAddMemoryView = true
        }
        func prepareImageFor(_ memory: Memory) -> Image {
            guard let imageData = memory.image else {
                return Image(systemName: "photo.artframe")
            }
            
            guard let uiImage = UIImage(data: imageData) else {
                return Image(systemName: "photo.artframe")
            }
            return Image(uiImage: uiImage)
        }
    }
}
