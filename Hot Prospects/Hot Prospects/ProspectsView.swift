//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Nadzeya Shpakouskaya on 19/07/2022.
//
import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case all, contacted, uncontacted
    }
    
    let filter: FilterType
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingSorting = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
                            .resizable()
                            .scaledToFill()                            .frame(width: 40, height: 40)
                            .foregroundColor(prospect.isContacted ? .green : .gray)
                            .padding(.horizontal, 16)
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }.swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        showingSorting = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    .contextMenu {
                        sortingButtons
//                        Button {
//                            prospects.toggle(.nameAscending)
//                        } label: {
//
//                            Text("By name")
//
//                        }
//
//                        Button {
//                            prospects.toggle(.dateDescending)
//                        } label: {
//
//                            Text("By added lately")
//
//                        }
//
//                        Button {
//                            prospects.toggle(.dateAscending)
//                        } label: {
//
//                            Text("By added firstly")
//
//                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
            .confirmationDialog("Sorting order", isPresented: $showingSorting) {
                sortingButtons
            }
        }
    }
    
    var sortingButtons: some View {
        VStack{
        Button {
            prospects.toggle(.nameAscending)
        } label: {
            
            Text("By name")
            
        }
        
        Button {
            prospects.toggle(.dateDescending)
        } label: {
            
            Text("By added lately")
            
        }
        
        Button {
            prospects.toggle(.dateAscending)
        } label: {
            
            Text("By added firstly")
            
        }
        }
    }
    
    var title: String {
        switch filter {
        case .all: return "Everyone"
        case .contacted: return "Contacted Persons"
        case .uncontacted: return "Uncontacted Persons"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .all:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // Test settings
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let data):
            let details = data.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .all)
            .environmentObject(Prospects())
    }
}
