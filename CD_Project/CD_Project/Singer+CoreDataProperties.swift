//
//  Singer+CoreDataProperties.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastname: String?
    
    public var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    public var wrappedLastName: String {
        lastname ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
