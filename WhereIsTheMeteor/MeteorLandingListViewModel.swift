//
//  MeteorLandingListViewModel.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation

enum MeteorLandingSortBy: String, CaseIterable {
    case alphabeticaly
    case size
    case recclass
    case year
    
}

class MeteorLandingListViewModel {
    
    let minimumYear = 1900
    let cellIdentifier = "meteorLandingCell"
    let meteorLandingSortBy = MeteorLandingSortBy.allCases
    
    var meteorLanding: [MeteorLanding] = []
    var updateUI: (() -> ())?
    var fetchDataYear: Int = 1900
    var fetchRepository: MeteorLandingRepositoryProtocol
    var meteorLandingSortType: MeteorLandingSortBy = .alphabeticaly
    var favoritesManager: PersistenceManagerProtocol
    
    init(_ fetchRepository: MeteorLandingRepositoryProtocol = MeteorLandingRepository(),
         favoritesManager: PersistenceManagerProtocol = FavoritesManager()) {
        self.fetchRepository = fetchRepository
        self.favoritesManager = favoritesManager
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoritesManager.fetchFavoriteId(withId: id) != nil
    }
    
    func addOrRemoveFavorite(_ id: String) {
        if let favoriteMeteorLanding = favoritesManager.fetchFavoriteId(withId: id) {
            favoritesManager.deleteFavoriteId(favoriteMeteorLanding: favoriteMeteorLanding)
        } else {
            favoritesManager.createFavoriteId(id: id)
        }
        DispatchQueue.main.async { [weak self] in
            self?.updateUI?()
        }
    }
    
    func refreshData(_ meteorLandings: [MeteorLanding]) {
        self.meteorLanding = meteorLandings.filter{ $0.reclat != nil && $0.reclong != nil }
        self.sortMeteorLandings()
        DispatchQueue.main.async { [weak self] in
            self?.updateUI?()
        }
    }
    
    func sortMeteorLandings() {
        meteorLanding = meteorLanding.sorted(by: { lhs, rhs in
            switch meteorLandingSortType {
            case .alphabeticaly:
                return lhs.name < rhs.name
            case .size:
                guard let lhsMass = lhs.mass, let rhsMass = rhs.mass else { return true }
                return lhsMass > rhsMass
            case .recclass:
                return lhs.recclass < rhs.recclass
            case .year:
                return lhs.year < rhs.year
            }
        })
    }
    
    func update(_ sortType: MeteorLandingSortBy) {
        self.meteorLandingSortType = sortType
        sortMeteorLandings()
        DispatchQueue.main.async { [weak self] in
            self?.updateUI?()
        }
    }
    
    func update(_ year: Int) {
        fetchDataYear = year
        fecthData()
    }
    
    func constructURLForFecthFiltered() -> URL? {
        guard let baseUrl = EnvUtils.getConfiguration(with: "BASE_URL") else { return nil }
        guard let urlEncoded = "$where=year>='\(fetchDataYear)-01-01T00:00:00'".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        guard let url = URL(string: "\(baseUrl)gh4g-9sfh.json?\(urlEncoded)") else { return nil }
        return url
    }
}

// MARK: - Fetch data from repositories
extension MeteorLandingListViewModel {
    func fecthData() {
        guard let url = constructURLForFecthFiltered() else { return }
        fetchRepository.fetchMeteorLandings(url) { [weak self] result in
            switch result {
            case .success(let meteorLandings):
                self?.refreshData(meteorLandings)
            case .failure(let error):
                print("error -\(error.localizedDescription)")
            }
        }
        
    }
    
    func fetchFavorites() {
        
    }
}
