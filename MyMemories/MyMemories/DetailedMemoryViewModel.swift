//
//  DetailedMemoryViewModel.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 12/07/2022.
//

import MapKit
import SwiftUI

extension DetailedMemoryView {
    
    class ViewModel: ObservableObject {
        
        @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: AppDefaultValue.location.latitude, longitude: AppDefaultValue.location.longitude), span: AppDefaultValue.span)
        @Published var mapVisible = false
        
        var image: Image {
            guard let imageData = memory.image else {
                return Image(systemName: "photo.artframe")
            }
            
            guard let uiImage = UIImage(data: imageData) else {
                return Image(systemName: "photo.artframe")
            }
            return Image(uiImage: uiImage)
        }

        
        var date: String {
            memory.date.formatted(date: .numeric, time: .omitted)
        }
        
        var name: String {
            memory.name
        }
        
        var description: String {
            memory.description
        }
        
        var location: Memory.Location? {
            memory.location
        }
        
        private var memory: Memory

        init(_ memory: Memory) {
            self.memory = memory
            if let location = location {
                mapRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: AppDefaultValue.span)
            }

        }

    }
}
