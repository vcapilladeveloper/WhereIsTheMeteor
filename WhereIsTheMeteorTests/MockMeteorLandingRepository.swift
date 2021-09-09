//
//  MockMeteorLandingRepository.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation
@testable import WhereIsTheMeteor

class MockMeteorLandingRepository: MeteorLandingRepositoryProtocol {
    func fetchMeteorLandings(_ url: URL, completion: @escaping (Result<[MeteorLanding], Error>) -> ()) {
        completion(.success([MeteorLanding(id: "1", name: "name", recclass: "recclass", mass: "123", year: "1900", reclong: "0.0", reclat: "0.0")]))
    }
}
