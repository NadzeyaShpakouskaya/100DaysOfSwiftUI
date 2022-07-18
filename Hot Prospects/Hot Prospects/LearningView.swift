//
//  LearningView.swift
//  Hot Prospects
//
//  Created by Nadzeya Shpakouskaya on 15/07/2022.
//

import SamplePackage
import SwiftUI
import UserNotifications

// MARK - Environment Object

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    var body: some View {
        Text(user.name)
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct UserView: View {
    @StateObject private var user = User()
    
    var body: some View {
        VStack(spacing: 20) {
            EditView()
            DisplayView()
        }.environmentObject(user)
    }
}

    // MARK: - TabViews

struct TabsView: View {
    @State private var selectedTab = "One"

       var body: some View {
           TabView(selection: $selectedTab) {
               Text("Tab 1")
                   .onTapGesture {
                       selectedTab = "Two"
                   }
                   .tabItem {
                       Label("One", systemImage: "star")
                   }
                   .tag("One")

               Text("Tab 2")
                   .tabItem {
                       Label("Two", systemImage: "circle")
                   }
                   .tag("Two")
           }
       }
}

    // MARK: - Manually publishing Observable Object

@MainActor class DelayedUpdater: ObservableObject {
//  Automatically notify when value changed
//    @Published var value = 0
    
    var value = 0 {
        // we trigger to notify that object changed by  objectWillChange.send()
        // we can add additional functionality if needed.
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManualPublishedView: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

    // MARK: - Result Type

struct ResultTypeView: View {
    @State private var output = ""

    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        let fetchTask = Task { () -> String in
                let url = URL(string: "https://hws.dev/readings.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let readings = try JSONDecoder().decode([Double].self, from: data)
                return "Found \(readings.count) readings"
            }
        
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
    }
}

    // MARK: - Context Menu

struct ContextMenuView: View {
    
    @State private var backgroundColor = Color.red

        var body: some View {
            VStack {
                Text("Hello, World!")
                    .padding()
                    .background(backgroundColor)

                Text("Change Color")
                    .padding()
                    .contextMenu {
                        Button {
                            backgroundColor = .red
                        } label: {
                            Label("Red", systemImage: "checkmark.circle.fill")
                        }

                        Button("Green") {
                            backgroundColor = .green
                        }

                        Button("Blue") {
                            backgroundColor = .blue
                        }
                    }
            }
        }
}

    // MARK: - custom row swipe actions to a List

struct CustomSwipeActionView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Hi")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                    Button {
                        print("Edit")
                    } label: {
                        Label("Edit", systemImage: "star.circle")
                    }.tint(.cyan)
                }
            // specify left/right by edge
                .swipeActions(edge: .leading) {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    // change color of button
                    .tint(.orange)
                }
        }
    }
}

    // MARK: - User Notifications

struct UserNotificationsView: View {
    
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                ) { success, error in
                    if success {
                         print("All set!")
                     } else if let error = error {
                         print(error.localizedDescription)
                     }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

    // MARK: - SamplePackage

struct SamplePackageView: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        
               Text(results)
    }
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map {String($0)}
        return strings.joined(separator: ", ")
    }
}

struct LearningView: View {
    var body: some View {
       SamplePackageView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
