//
//  MeteorLanding.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation

// MARK: - MeteorLanding

/// Model used to parse the meteor landing model from the API.
struct MeteorLanding: Codable {
    let id: String
    let name: String
    let recclass: String
    let mass: String?
    let year: String
    let reclong: String?
    let reclat: String?
}

