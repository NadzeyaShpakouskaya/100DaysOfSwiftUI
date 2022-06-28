//
//  CachedUser+CoreDataProperties.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedId: String {
        id ?? UUID().uuidString
    }
    public var wrappedName: String {
        name ?? "unknown name"
    }
    public var wrappedAge: Int {
        Int(age)
    }
    public var wrappedCompany: String {
        company ?? "n/a"
    }
    public var wrappedEmail: String {
        email ?? "n/a"
    }
    public var wrappedAddress: String {
        address ?? "n/a"
    }
    public var wrappedAbout: String {
        about ?? "info is missed"
    }
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: [String] {
        tags?.components(separatedBy: ",") ?? []
    }
    
    public var friendsList: [CachedFriend] {
       let set = friends as? Set<CachedFriend> ?? []
        return Array(set)
    }
    
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
