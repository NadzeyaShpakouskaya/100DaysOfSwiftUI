//
//  AddMemoryViewModel.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import CoreLocation
import SwiftUI

extension AddMemoryView {
    class ViewModel: ObservableObject {
        private var memory: Memory
        var dataManager: DataManager
        
        @Published var image: Image?
        @Published var showingAlert = false
        @Published var showingImagePicker = false
        @Published var inputImage: UIImage?
        @Published var name = ""
        @Published var description = ""
        
        init( dataManager: DataManager) {
            self.memory = Memory(id: UUID(), name: "", description: "", date: Date.now)
            self.dataManager = dataManager
        }
        
        func saveMemory() {
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                memory.image = jpegData
            }
            memory.name = name
            memory.description = description
            dataManager.addNewMemory(memory)
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
    }
}
