//
//  FileManager+Extension.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
