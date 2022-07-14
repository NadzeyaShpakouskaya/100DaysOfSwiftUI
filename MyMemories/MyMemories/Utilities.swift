//
//  Utilities.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 13/07/2022.
//

import MapKit

struct AppDefaultValue {
    static let location = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    static let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

enum PhotoPicker {
    enum Source {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
