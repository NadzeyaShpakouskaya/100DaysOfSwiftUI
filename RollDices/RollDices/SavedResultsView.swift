//
//  SavedResultsView.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 11/08/2022.
//

import SwiftUI

struct SavedResultsView: View {
    @EnvironmentObject var dataManager: LocalFileDataManager
    @State private var isAlertPresented = false
    
    let columns = [
        GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40))
    ]
    
    var body: some View {
        List{
            ForEach(dataManager.results, id: \.id) { result in
                VStack(alignment: .leading, spacing: 8){
                    Text("\(result.diceSides)-sided dices were rolled:").font(.headline).padding(.bottom, 8)
                    
//                    LazyVGrid(columns: columns, spacing: 30) {
//                        ForEach(0..<result.numberOfDices) { index in
//
//                            Text("\(result.results[index])")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 2)
//                                    .frame(width: 40, height: 40))
//                        }
//
                  
//                    }.padding(.vertical)
                    DicesGridView(results: result.results.map{ String($0) }, size: 30)
                    
                }
            }
            .onDelete(perform: removeItems(at:))
        }

        .alert("You want to delete all saved results", isPresented: $isAlertPresented) {
            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
            Button(role: .destructive, action: {
                deleteAll()
            }) {
                Text("Delete all")
            }
            
        }
        .toolbar {
            Button(role: .destructive) {
                isAlertPresented = true
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.cyan)
            }
            
        }
    }
    
    private func deleteAll() {
        dataManager.results = []
    }
    
    private func removeItems(at offsets: IndexSet) {
        dataManager.results.remove(atOffsets: offsets)
        }
}

struct SavedResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedResultsView()
    }
}
