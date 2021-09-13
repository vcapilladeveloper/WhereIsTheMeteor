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
    // MARK: - Properties
    let minimumYear = 1900
    let cellIdentifier = "meteorLandingCell"
    let meteorLandingSortBy = MeteorLandingSortBy.allCases
    
    var meteorLanding: [MeteorLanding] = []
    var updateUI: (() -> ())?
    var showError: ((String) -> ())?
    var fetchDataYear: Int = 1900
    var fetchRepository: MeteorLandingRepositoryProtocol
    var meteorLandingSortType: MeteorLandingSortBy = .alphabeticaly
    var favoritesManager: PersistenceManagerProtocol
    
    /// Init fot the VM wich controls the logic of the MeteorLanding List
    /// - Parameters:
    ///   - fetchRepository: DI for MeteorLoading Repository
    ///   - favoritesManager: DI for PersistenceManager
    init(_ fetchRepository: MeteorLandingRepositoryProtocol = MeteorLandingRepository(),
         favoritesManager: PersistenceManagerProtocol = FavoritesManager()) {
        self.fetchRepository = fetchRepository
        self.favoritesManager = favoritesManager
    }
    
    // TODO: Make more generic, too many litterals
    /// Builder for URL, using fetchDataYear
    func constructURLForFecthFiltered() -> URL? {
        guard let baseUrl = EnvUtils.getConfiguration(with: "BASE_URL") else { return nil }
        guard let urlEncoded = "$where=year>='\(fetchDataYear)-01-01T00:00:00'".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        guard let url = URL(string: "\(baseUrl)gh4g-9sfh.json?\(urlEncoded)") else { return nil }
        return url
    }
}

// MARK: - Fetch and manage Meteor Landings
extension MeteorLandingListViewModel {
    
    /// Using repository, take the Meteor Landings
    func fecthData() {
        guard let url = constructURLForFecthFiltered() else { return }
        fetchRepository.fetchMeteorLandings(url) { [weak self] result in
            switch result {
            case .success(let meteorLandings):
                self?.refreshData(meteorLandings)
            case .failure(let error):
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    /// Filter and sort meteorLandings and run the updateUI function if its set by the owner
    private func refreshData(_ meteorLandings: [MeteorLanding]) {
        self.meteorLanding = cleanNoCoordinates(meteorLandings)
        self.sortMeteorLandings()
        DispatchQueue.main.async { [weak self] in
            self?.updateUI?()
        }
    }
    
    /// Filter for NO-Coordinates meteor landings
    private func cleanNoCoordinates(_ meteorLandings: [MeteorLanding]) -> [MeteorLanding]{
        meteorLandings.filter{ $0.reclat != nil && $0.reclong != nil }
    }
    
    /// Using the sort type selected by the user, sort the meteor landings
    private func sortMeteorLandings() {
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
    
    /// Recive selected sortType from owner, replace it, reorder and update UI
    func update(_ sortType: MeteorLandingSortBy) {
        self.meteorLandingSortType = sortType
        sortMeteorLandings()
        DispatchQueue.main.async { [weak self] in
            self?.updateUI?()
        }
    }
    
    /// Update the year used like 'from year' on the request data.
    func update(_ year: Int) {
        fetchDataYear = year
        fecthData()
    }
    
}

// MARK: Manage Favorites
extension MeteorLandingListViewModel {
    
    /// Used for check if one ID is inside the favorite persisntence model
    func isFavorite(_ id: String) -> Bool {
        favoritesManager.fetchFavoriteId(withId: id) != nil
    }
    
    /// With an ID, set or remove from favorite persistence model and after that, update UI
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
    
    
}
