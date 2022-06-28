//
//  CachedFriend+CoreDataProperties.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var fromUser: NSSet?
    
    public var wrappedName: String {
        name ?? "unknown person"
    }
    
    public var wrappedId: String {
        id ?? UUID().uuidString
    }

}

// MARK: Generated accessors for fromUser
extension CachedFriend {

    @objc(addFromUserObject:)
    @NSManaged public func addToFromUser(_ value: CachedUser)

    @objc(removeFromUserObject:)
    @NSManaged public func removeFromFromUser(_ value: CachedUser)

    @objc(addFromUser:)
    @NSManaged public func addToFromUser(_ values: NSSet)

    @objc(removeFromUser:)
    @NSManaged public func removeFromFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
