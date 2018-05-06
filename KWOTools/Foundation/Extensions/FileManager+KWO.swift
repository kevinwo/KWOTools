//
//  FileManager+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 12/31/17.
//

import Foundation

extension FileManager {
    public static var documentsDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        }
    }

    public static func appGroupURL(_ identifier: String) -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: identifier)!
    }

    public static func canAccessAppGroup(_ identifier: String) -> Bool {
        return FileManager.default.isReadableFile(atPath: self.appGroupURL(identifier).path)
    }
}
