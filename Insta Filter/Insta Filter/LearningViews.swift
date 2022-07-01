//
//  ContentView.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 29/06/2022.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select image") { showingImagePicker = true }
            
            Button("Save Image") {
                guard let selectedImage = selectedImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: selectedImage)
            }
        }.sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }.onChange(of: selectedImage) { _ in
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct ImageFilterView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        
        // convert image to UIImage, it's optional, need to unwrap
        guard let inputImage = UIImage(named: "example") else { return }
        // convert to CIImage
        let ciImage = CIImage(image: inputImage)
        
        // create context and default filter to work with ciImage
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = ciImage
        
        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 300, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
            
        }
        
        
        // create imaged transformed with filter above
        guard let outputImage = currentFilter.outputImage else { return }
        
        // create new CIImage from context
        if let newCIImage = context.createCGImage(outputImage, from: outputImage.extent) {
            // transform to UIImage
            let uiImage = UIImage(cgImage: newCIImage)
            // transform to SwiftUI Image
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
