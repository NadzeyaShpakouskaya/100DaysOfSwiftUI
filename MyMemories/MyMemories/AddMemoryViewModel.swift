//
//  AddMemoryViewModel.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import MapKit
import SwiftUI

extension AddMemoryView {
    class ViewModel: ObservableObject {
        private var memory: Memory
        private var dataManager: DataManager
        private let locationFetcher = LocationFetcher()
        
        @Published var image: Image?
        @Published var showingImagePicker = false
        @Published var inputImage: UIImage?
        @Published var name = ""
        @Published var description = ""
        @Published var mapRegion = MKCoordinateRegion(center: AppDefaultValue.location, span: AppDefaultValue.span)
        @Published var location: CLLocationCoordinate2D?
        @Published var buttonLocationTitle = "Add location to memory"
        @Published var imageSource: PhotoPicker.Source = .library
        
        
        init(dataManager: DataManager) {
            self.memory = Memory(id: UUID(), name: "", description: "", date: Date.now, location: Memory.Location(latitude: AppDefaultValue.location.latitude, longitude: AppDefaultValue.location.latitude))
            self.dataManager = dataManager
        }
        
        func saveMemory() {
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                memory.image = jpegData
            }
            memory.name = name
            memory.description = description

            memory.location = Memory.Location(latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
           
            dataManager.addNewMemory(memory)
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func fetchLocation() {
            checkLocation()
            if let locationFetched = locationFetcher.lastKnownLocation {
                print("Your location is \(locationFetched)")
                location = locationFetched
                mapRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: locationFetched.latitude,
                        longitude: locationFetched.longitude
                    ),
                    span:AppDefaultValue.span
                )
            } else {
                print("Your location is unknown")
            }
        }
        
        private func checkLocation() {
            locationFetcher.start()
            buttonLocationTitle = "Find my current location"
        }
        
        func showPicker() {
            if imageSource == .camera {
                if !PhotoPicker.checkPermissions() {
                    print("There is no camera on the device")
                    return
                }
            }
                
            showingImagePicker = true
        }
        
    }
}
