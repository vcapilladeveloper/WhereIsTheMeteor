//
//  DataParser.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation

/// Helper for parse data from Data, infering generic type that must implement Codable protocol.
public class DataParser {
    public static func getData<T: Decodable>(from data: Data) throws -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
