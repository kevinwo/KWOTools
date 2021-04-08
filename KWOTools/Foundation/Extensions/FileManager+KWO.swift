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

    public static func creationDate(forItemAt url: URL) -> Date? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
        else {
            return nil
        }

        return attributes[.creationDate] as? Date
    }

    public static var documentsDirectoryCreationDate: Date? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }

        return creationDate(forItemAt: documentsURL)
    }
}
