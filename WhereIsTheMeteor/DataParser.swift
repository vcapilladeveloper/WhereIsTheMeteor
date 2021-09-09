//
//  DataParser.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation
public class DataParser {
    public static func getData<T: Codable>(from data: Data) throws -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
