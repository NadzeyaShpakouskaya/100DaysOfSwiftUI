//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Nadzeya Shpakouskaya on 13/08/2022.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        VStack {
                            Spacer()
                        HStack(alignment: .bottom) {
                            Text("photo taken by \(resort.imageCredit)")
                                .font(.subheadline).italic()
                                .padding(.horizontal, 8)
                                .background(.white)
                                
                                .foregroundColor(.gray)
                                .clipShape(Capsule())
                            Spacer()
                        }
                        }.padding(4)
                    )
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                // we can limit the range of Dynamic Type sizes supported by a particular view.
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    // present array [x, y, z] as "x, y and z"
//                    Text(resort.facilities, format: .list(type: .and))
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                        .padding(.vertical)
                    Button{
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    } label: {
                        Label {
                            Text(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites")
                        } icon: {
                            Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")
                        }

                        
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            selectedFacility?.name ?? "More information",
            isPresented: $showingFacility,
            presenting: selectedFacility
        ) { _ in } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ResortView(resort: Resort.example)
            
        }.environmentObject(Favorites())
    }
}
