//
//  DetailedMemoryViewModel.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 12/07/2022.
//

import SwiftUI

extension DetailedMemoryView {
    
    class ViewModel: ObservableObject {
        private var memory: Memory
        
        var image: Image {
            guard let imageData = memory.image else {
                return Image(systemName: "photo.artframe")
            }
            
            guard let uiImage = UIImage(data: imageData) else {
                return Image(systemName: "photo.artframe")
            }
            return Image(uiImage: uiImage)
        }
        var name: String {
            memory.name
        }
        var description: String {
            memory.description
        }
        
        var date: String {
            memory.date.formatted(date: .numeric, time: .omitted)
        }
        
        init(_ memory: Memory) {
            self.memory = memory
        }
    }
}
