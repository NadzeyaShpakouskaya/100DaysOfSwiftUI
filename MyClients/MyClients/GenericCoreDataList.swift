//
//  CoreDataList.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 28/06/2022.
//
import CoreData
import SwiftUI


struct GenericCoreDataList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id:\.self) { item in
            self.content(item)
        }
    }
    
    init(@ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [])
        self.content =  content
    }
}

