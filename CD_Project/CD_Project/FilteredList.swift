//
//  FilteredList.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
//    let sortDescriptors: [NSSortDescriptor]
    let sortDescriptors: [SortDescriptor<T>]
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id:\.self) { item in
            self.content(item)
        }
    }
    
    //init to filter using predicates 'BEGINSWITH' for key and value of Entity
    
    init(filteringKey: String, filteringValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filteringKey, filteringValue))
        self.content =  content
        self.sortDescriptors = []
    }
    
    init(filteringKey: String, filteringValue: String, filterUsing: FilteringPredicate, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
    
        let predicate = NSPredicate(format: "%K \(filterUsing.rawValue) %@", filteringKey, filteringValue)
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: predicate)
        self.content =  content
        self.sortDescriptors = sortDescriptors
    }
     
}

enum FilteringPredicate: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case contains = "CONTAINS"
    case containsInsensitive = "CONTAINS[c]"
    case matches = "MATCHES"
    case belongsTo = "IN"
    case like = "LIKE"
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
