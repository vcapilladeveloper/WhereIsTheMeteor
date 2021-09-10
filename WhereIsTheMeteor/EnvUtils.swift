//
//  EnvUtils.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation

/// Helper for get data from BuildSettings
/// Add User-Defined data inside BuildSettings and relate in Info.plist. i.e: KEY -> ${KEY}
final class EnvUtils {
    static func getConfiguration(with key: String) -> String? {
        if let value = Bundle.main.infoDictionary?[key] as? String {
            return value
        }
        return nil
    }
}
