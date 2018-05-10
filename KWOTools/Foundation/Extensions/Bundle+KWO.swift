//
//  Bundle+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/7/18.
//

import Foundation

extension Bundle {

    public static func containingFile(at filePath: String) -> Bundle? {
        let className = URL(fileURLWithPath: filePath)
            .lastPathComponent
            .components(separatedBy: ".")[0]

        guard
            let dict = Bundle.main.infoDictionary,
            var appName = dict["CFBundleName"] as? String
            else { return nil }

        appName = appName.replacingOccurrences(of: " ", with: "_")
        let namespacedClassName = appName + "." + className

        if let fileClass = NSClassFromString(namespacedClassName) {
            return Bundle(for: fileClass)
        }

        return nil
    }
}
