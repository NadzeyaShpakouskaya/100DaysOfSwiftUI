//
//  AddMemoryView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import SwiftUI

struct AddMemoryView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var dataManager: DataManager
    
    @Environment(\.dismiss) var dismiss
    
    init(dataManager: DataManager) {
        viewModel = ViewModel(dataManager: dataManager)
    }
    
    var body: some View {
        VStack {
            Form {
                imageView
                    .onTapGesture { viewModel.showingImagePicker = true }
                TextField("Name", text: $viewModel.name)
                TextField("Description", text: $viewModel.description)
            }
            Spacer()
            Button {
                viewModel.saveMemory()
                dismiss()
            } label: {
                Text("Save my memory")
                
            }
        }.padding(.bottom)
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage){ _ in
                viewModel.loadImage()
            }
            .environmentObject(dataManager)
    }
    
    var imageView: some View {
        ZStack {
            if viewModel.image == nil {
            Rectangle()
                .fill(.gray.opacity(0.25))
            
            Text("Tap to select a picture")
                    .foregroundColor(viewModel.image == nil ? .secondary : .clear)
                .font(.headline)
            }
            viewModel.image?
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 4)
            
        }
        .frame(height: 200)
    }
    
 
    
    
}

struct AddMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryView(dataManager: DataManager.shared)
    }
}
