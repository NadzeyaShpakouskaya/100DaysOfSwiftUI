//
//  MainView.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 29/06/2022.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct MainView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingAlert = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var filterName: String {
        let name = String(currentFilter.name.dropFirst(2))
        return name.titlecased()
    }

    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            imageView
                .onTapGesture { showingImagePicker = true }
            filterSettingsView
            buttonActionView
        }
        .padding()
        .onChange(of: inputImage){ _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select filter", isPresented: $showingFilterSheet) {
            filterButtonsView
        }
        .alert("Your image was saved", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    var filterSettingsView: some View {
        VStack {
            Group{
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                            .appDefaultText()
                        Spacer()
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                    }
                }
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack{
                        Text("Radius")
                            .appDefaultText()
                        Spacer()
                        Slider(value: $filterRadius, in: 0.1...1)
                            .onChange(of: filterRadius) { _ in applyProcessing() }
                    }
                }
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                            .appDefaultText()
                        Spacer()
                        Slider(value: $filterScale, in: 0.1...1)
                            .onChange(of: filterScale) { _ in applyProcessing() }
                    }
                }
            }
        }
        
    }
    
    var imageView: some View {
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.25))
            
            Text("Tap to select a picture")
                .foregroundColor(image == nil ? .secondary : .clear)
                .font(.headline)
            
            image?
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 4)
        }
    }
    
    var buttonActionView: some View {
        HStack (spacing: 12) {
            Button("Change filter") { showingFilterSheet = true }
                .tint(.indigo)
                .buttonStyle(.borderedProminent)
            
            Spacer()
            Button("Save image", action: saveImage)
                .tint(.green)
                .buttonStyle(.borderedProminent)
                .disabled(image == nil)
            
            
        }
        
    }
    
    var filterButtonsView: some View {
        VStack {
            Group {
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Gabor Gradients") { setFilter(CIFilter.gaborGradients()) }
                Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
                
            }
            Group {
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    var headerView: some View {
        Text(filterName)
            .font(.title2).bold().italic()
            .foregroundColor(.indigo)
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let startImage = CIImage(image: inputImage)
        currentFilter.setValue(startImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    private func saveImage() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        
        imageSaver.success = {
            print("Image was saved successfully")
            showingAlert = true
        }
        
        imageSaver.failed = {
            print("Error: Image wouldn't be saved. \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    private func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 100, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 50, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
        
    }
    
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        
        loadImage()
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
