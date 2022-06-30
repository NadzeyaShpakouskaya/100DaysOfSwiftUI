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
    
    var FilterSettingsView: some View {


            HStack() {
                VStack(alignment: .leading, spacing: 20){
                    Text("Intensity")
                    Text("Radius")
                    Text("Scale")
                }
                VStack{
                    Slider(value: $filterIntensity)
                        .disabled(!currentFilter.inputKeys.contains(kCIInputIntensityKey))
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                    Slider(value: $filterRadius, in: 0...1)
                        .disabled(!currentFilter.inputKeys.contains(kCIInputRadiusKey))
                        .onChange(of: filterRadius) { _ in applyProcessing() }
                    Slider(value: $filterScale, in: 0...1)
                        .disabled(!currentFilter.inputKeys.contains(kCIInputScaleKey))
                        .onChange(of: filterScale) { _ in applyProcessing() }
                }
                
            }

    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(filterName)
                    .font(.title2).bold().italic()
                    .foregroundColor(.secondary)
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
                .onTapGesture {
                    showingImagePicker = true
                }
                Group{
                HStack() {
                    VStack(alignment: .leading, spacing: 20){
                        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        Text("Intensity")
                        }
                        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        Text("Radius")
                        }
                        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        Text("Scale")
                        }
                    }
                    VStack{
        
                        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity) { _ in applyProcessing() }
                        }
                        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        Slider(value: $filterRadius, in: 0.1...1)
                        
                            .onChange(of: filterRadius) { _ in applyProcessing() }
                        }
                        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        Slider(value: $filterScale, in: 0.1...1)

                            .onChange(of: filterScale) { _ in applyProcessing() }
                            
                        }
                    }
                    }
                    
                }.padding()
            
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save image", action: saveImage)
                        .disabled(image == nil)
                    
                }.padding()
            }
            .padding()
            .navigationTitle("Instafilter")
            .onChange(of: inputImage){ _ in
                loadImage()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select filter", isPresented: $showingFilterSheet) {
                Group {
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Gabor Gradients") { setFilter(CIFilter.gaborGradients()) }
                Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
             
                }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
                
            }
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let startImage = CIImage(image: inputImage)
        currentFilter.setValue(startImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    private func saveImage() {
        guard let processedImage = processedImage else {
            return
        }
        let imageSaver = ImageSaver()
 
      
        imageSaver.success = {
            print("Image was saved successfully")
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
            currentFilter.setValue(filterRadius * 250, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
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
