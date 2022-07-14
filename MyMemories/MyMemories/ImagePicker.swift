//
//  ImagePicker.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // We bind image to our parent swiftui view
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    // Nested coordinator for swiftui
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // we add parent parameter to communicate with parent PickerView
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//
//            // if there's no changes or selected view, just exit
//            guard let provider = results.first?.itemProvider else { return }
//
//            // check we can load selected image
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, error in
//                    Task { @MainActor in
//                     self.parent.image = image as? UIImage
//                    }
//                }
//            }
//        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                        parent.image = image
                    }
                    parent.presentationMode.wrappedValue.dismiss()
                }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    //MARK: - UIViewControllerRepresentable
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//
//        let pickerVC = PHPickerViewController(configuration: config)
//        pickerVC.delegate = context.coordinator
//        return pickerVC
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//    }
//

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}
