//
//  MemoriesListView.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import SwiftUI

struct MemoriesListView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView{
            List{
                
                ForEach(viewModel.memories, id: \.id) { memory in
                    NavigationLink {
                        DetailedMemoryView(memory: memory)
                    } label: {
                        HStack {
                            viewModel.prepareImageFor(memory)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            VStack (alignment: .leading){
                                Text(memory.name)
                                    .font(.headline)
                                Text(memory.date.formatted(date: .numeric, time: .omitted))
                                    .font(.subheadline)
                            }
                        }
                    }
                }.onDelete(perform:
                            withAnimation {
                    viewModel.removeItems(at:)
                })
                
                
                
            }
            .navigationTitle("My memories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.showAddNewMemory()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.cyan)
                }
            }.sheet(isPresented: $viewModel.showingAddMemoryView) {
                AddMemoryView(dataManager: dataManager) { memory in
                    viewModel.addToList(memory)
                }
            }
            .environmentObject(dataManager)
        }
    }
    
    init(dataManager: DataManager) {
        self.viewModel = ViewModel(dataManager: dataManager)
    }
    
}

struct MemoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesListView(dataManager: DataManager.shared)
    }
}
