//
//  User.swift
//  BoardgamesLovers
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import Foundation
// TO DO: User should conform Protocol
protocol UserData {
    var id: String { get }
    var isActive: Bool {get}
    var name: String {get}
    var age: Int {get}
    var company: String {get}
    var email: String {get}
    var address: String {get}
    var about: String {get}
    var registered: Date {get}
    var tags: [String] {get}
    var friends: [FriendData] {get set}
}

protocol FriendData {
    var id: String { get }
    var name: String { get}
}

struct Friend: Codable {
    let id: String
    let name: String
}

struct User: Codable {
    var friends: [Friend]
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
//    let friends: [Friend]
    
    static let testUser = User(
        friends: [
            Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            Friend(id: "7ef1899e-96e4-4a76-8047-0e49f35d2b2c", name: "Josefina Rivas"),
            Friend(id: "d09ffb09-8adc-48e1-a532-b99ae72473d4", name: "Russo Carlson"),
            
        ], id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
        isActive: false,
        name: "Alford Rodriguez",
        age: 21,
        company: "Imkan",
        email: "alfordrodriguez@imkan.com",
        address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
        about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
        registered: Date.now,
        tags: [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ])
}
