//
//  MapView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
            if viewModel.isUnlocked{
                    ZStack {
                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                            MapAnnotation(coordinate: location.coordinates) {
                                PinPlaceView(place: location)
                                .onTapGesture {
                                    viewModel.selectedPlace = location
                                }
                            }
                        }
                        .ignoresSafeArea()
                        
                        AddRedButtonView {
                            viewModel.addNewLocation()
                        }
                        
                        PinAddingView()
             
                    }
                    .sheet(item: $viewModel.selectedPlace) { location in
                        EditLocationView(location: location) { newLocation in
                            viewModel.update(location: newLocation)
                        }
                    }
            } else {
                // button to unlock using faceID/touchID
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
                //Part Of Challenge, but we have failed alert provided by Apple.
                
                .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("\(viewModel.alertMessage)")
                }
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

    // MARK: - Subviews

struct PinPlaceView: View {
    @Environment(\.colorScheme) var colorScheme
    let place: Location
    
    var body: some View {
        VStack {
            Image(systemName: "mappin")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            Text(place.title)
                .fixedSize()
        }
        .foregroundColor( colorScheme == .dark ? .orange: .indigo)
    }
}

struct AddRedButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            Image(systemName: "plus")
                .padding()
                .background(.red.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding([.bottom, .trailing], 12)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
}

struct PinAddingView: View {
    var body: some View {
        Image(systemName: "mappin.and.ellipse")
            .resizable()
            .scaledToFit()
            .foregroundColor(.red)
            .frame(width: 44, height: 44)
    }
}
