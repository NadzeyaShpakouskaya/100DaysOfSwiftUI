//
//  DetailedMemoryView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//
import MapKit
import SwiftUI

struct DetailedMemoryView: View {
    let memory: Memory
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            viewModel.image
                .resizable()
                .scaledToFit()
                .padding()
            VStack{
                Text(viewModel.description)
                    .font(.title3.italic())
                Divider()
                Text("Created on ") + Text(viewModel.date).font(.headline)
            }
            
            
            Toggle("Show place", isOn: $viewModel.mapVisible)
            Spacer()
            Group {
                if viewModel.mapVisible {
                        Map(coordinateRegion: $viewModel.mapRegion)
                }
                
            }
        }
        .padding()
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    init(memory: Memory) {
        self.memory = memory
        viewModel = ViewModel(memory)
    }
    
}

struct DetailedMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedMemoryView(memory: Memory.testMemory)
    }
}
