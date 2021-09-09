//
//  MeteorLandingRepository.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation

protocol MeteorLandingRepositoryProtocol {
    func fetchMeteorLandings(_ url: URL, completion: @escaping (Result<[MeteorLanding], Error>)->())
}

class MeteorLandingRepository: MeteorLandingRepositoryProtocol {
    func fetchMeteorLandings(_ url: URL, completion: @escaping (Result<[MeteorLanding], Error>) -> ()) {
        guard let authToken = EnvUtils.getConfiguration(with: "AUTH_TOKEN") else { return }
        NetworkClient(session: URLSession.shared).get(url, header: ["X-App-Token": authToken]) { result in
            switch result {
            case .success(let data):
                do {
                    let meteorLanding: [MeteorLanding]? = try DataParser.getData(from: data)
                        completion(.success(meteorLanding ?? []))
                } catch (let parseError) {
                    print(parseError)
                    completion(.failure(parseError))
                }
               
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
