//
//  ImagePicker.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 29/06/2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // We bind image to our parent swiftui view
    @Binding var image: UIImage?
    
    // Nested coordinator for swiftui
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // we add parent parameter to communicate with parent PickerView
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            // if there's no changes or selected view, just exit
            guard let provider = results.first?.itemProvider else { return }
            
            // check we can load selected image
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    //MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = context.coordinator
        return pickerVC
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    

}
