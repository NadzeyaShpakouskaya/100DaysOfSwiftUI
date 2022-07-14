//
//  AddMemoryView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//
import MapKit
import SwiftUI

struct AddMemoryView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Memory) -> Void
    
    init(dataManager: DataManager, completion: @escaping (Memory) -> Void) {
        viewModel = ViewModel(dataManager: dataManager)
        onSave = completion
    }
    
    
    var body: some View {
        VStack{
            ScrollView{
                imageView
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                    mapView
                }.padding()
            }
            Button {
                viewModel.saveMemory()
                onSave(viewModel.memory)
                dismiss()
            } label: {
                Text("Save my memory")
            }.cyanButton(16)
        }.padding(.vertical)
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(
                    sourceType: viewModel.imageSource == .camera ? .camera : .photoLibrary,
                    image: $viewModel.inputImage
                )
            }
            .onChange(of: viewModel.inputImage){ _ in
                viewModel.loadImage()
            }
            .environmentObject(dataManager)
    }
    
    var mapView: some View {
        VStack{
            if viewModel.location != nil {
                ZStack{
                    Map(coordinateRegion: $viewModel.mapRegion)
                    PinAddingView()
                }
                .frame(height: 250)
            } else {
                Button {
                    viewModel.fetchLocation()
                } label: {
                    Text(viewModel.buttonLocationTitle)
                }
            }
        }
    }
    
    var imageView: some View {
        VStack {
            Group{
                if viewModel.image == nil {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                        .frame(height: 300)
                } else {
                    viewModel.image?
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 8)
                        .frame(height: 300)
                }
            }
            VStack {
                Spacer()
                HStack{
                    Button("Photo library") {
                        viewModel.imageSource = .library
                        viewModel.showPicker()
                    }.cyanButton(12)
                    Spacer()
                    Button("Make new photo") {
                        viewModel.imageSource = .camera
                        viewModel.showPicker()
                    }.cyanButton(12)
                }.padding(.horizontal)
                
            }
        }
    }
    
}

struct AddMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryView(dataManager: DataManager.shared, completion: {_ in})
            .environmentObject(DataManager())
    }
}

struct PinAddingView: View {
    var body: some View {
        Image(systemName: "mappin")
            .resizable()
            .scaledToFit()
            .foregroundColor(.red)
            .frame(width: 32, height: 32)
    }
}
