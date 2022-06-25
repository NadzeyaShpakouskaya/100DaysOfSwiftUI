//
//  Country+CoreDataProperties.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedFullName: String {
        fullName ?? "Unknown country"
    }
    
    public var wrappedShortName: String {
        shortName ?? "Unknown country"
    }
    
    public var candiesArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
