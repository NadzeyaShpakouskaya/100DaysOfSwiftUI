//
//  DetailedMemoryView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import SwiftUI

struct DetailedMemoryView: View {
    let memory: Memory
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            viewModel.image.resizable().scaledToFit().padding()
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.description)
                    .font(.title2).italic()
                Text("Created on ") + Text(viewModel.date).font(.headline)
            }
            Spacer()
            
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
