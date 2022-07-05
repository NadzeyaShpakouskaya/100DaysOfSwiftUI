//
//  MapView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    )
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        Text(location.title)
                            .fixedSize()
                    }.onTapGesture {
                        selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            
            Circle()
                .fill(.blue).opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        let new = Location(id: UUID(),
                                           title: "New location",
                                           description: "",
                                           latitude: mapRegion.center.latitude,
                                           longitude: mapRegion.center.longitude)
                        locations.append(new)
                        
                        
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .sheet(item: $selectedPlace) { location in
            EditLocationView(location: location) { newLocation in
                if let index = locations.firstIndex(of: location) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
