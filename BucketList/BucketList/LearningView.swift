//
//  ContentView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 04/07/2022.
//

import LocalAuthentication
import MapKit
import SwiftUI


enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct DocumentDirectoryView: View {
    @State private var loadingState = LoadingState.loading
     var fileName: String {
         "UserData.txt"
     }
     var body: some View {
         
         VStack{
             switch loadingState {
             case .loading:
                 LoadingView()
             case .success:
                 SuccessView()
             case .failed:
                 FailedView()
             }
             
             Text("Hello, world!")
                 .onTapGesture {
                     let str = "My test message"
                     let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                     do {
                         try str.write(to: url, atomically: true, encoding:  .utf8)
                         // read from saved  message.txt file
                         let input = try String(contentsOf: url)
                         print(input)
                     } catch {
                         print(error.localizedDescription)
                     }
                 }
             Button("Save user") {
                 let user = User(id: UUID(), name: "User 1", age: 25)
                 let url = getDocumentsDirectory().appendingPathComponent(fileName)
                 do {
                     let str = try String(data: JSONEncoder().encode(user), encoding: .utf8)
                     try str?.write(to: url, atomically: true, encoding:  .utf8)
                 } catch {
                     print(error.localizedDescription)
                 }
                 loadingState = .success
             }
             Button("Load user") {
                 loadingState = .failed
                 let userData: User  = FileManager.default.decode(fileName)
                 print(userData.name)
             }
         }
     }
     
     func getDocumentsDirectory() -> URL {
         // find all possible documents directories for this user
         let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         // just send back the first one, which ought to be the only one
         return paths[0]
     }
}
// MAPKIT Intro

struct LocationLearning: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapLearningView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    let locations = [
        LocationLearning(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        LocationLearning(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//            default pin marker
//            MapMarker(coordinate: location.coordinate)
            
            // detailed Annotation with custom SwiftUI
            // and tap gesture
            MapAnnotation(coordinate: location.coordinate) {
                NavigationLink {
                                Text(location.name)
                            } label: {
                                Circle()
                                    .stroke(.red, lineWidth: 3)
                                    .frame(width: 44, height: 44)
                            }
               }
        } .navigationTitle("London Explorer")
    }
}


struct LearningView: View {

    var body: some View {
        NavigationView{
        VStack {
            AuthView()
            }
        }
    }
}

struct AuthView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}

struct User: Codable {
    let id: UUID
    let name: String
    let age: Int
    
    enum CodingKey: String, Decodable {
        case id, name, age
    }
    
}

extension FileManager {
    
    // Method allows to decode local file and return generic confirming decodable protocol
    /// file: - file name like "message.txt"
    func decode<T:Codable>(_ file: String) -> T {
        let url =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(file)
        
        guard let string = try? String(contentsOf: url) else {
            
            fatalError("ERROR: Couldn't load data from \(file)")
        }
        print(string)
        guard let data = string.data(using: .utf8) else {
            fatalError("Error: Couldn't convert string to data")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let fetchedData = try? decoder.decode(T.self, from: data) else {
            fatalError("ERROR: Couldn't decode data from \(file)")
        }
        return fetchedData
    }
    
}

