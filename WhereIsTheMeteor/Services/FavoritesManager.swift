//
//  FavoritesManager.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation
import CoreData

/// Type of storage used in CoreData PersistentContainer for use in Memory on Unit Tests
enum StorageType {
  case persistent, inMemory
}

/// Persisntace protocol for make dependency Injection.
protocol PersistenceManagerProtocol {
    func createFavoriteId(id: String) -> FavoriteMeteorLanding?
    func fetchFavoriteIds() -> [FavoriteMeteorLanding]?
    func fetchFavoriteId(withId id: String) -> FavoriteMeteorLanding?
    func updateFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding)
    func deleteFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding)
}

/// Core data favorites manager Class.
struct FavoritesManager: PersistenceManagerProtocol {
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    /// Persisntent storage type by default. We use inMemory on Unit Testing
    init(_ storageType: StorageType = .persistent) {
        self.persistentContainer = NSPersistentContainer(name: "WhereIsTheMeteor")
        if storageType == .inMemory {
              let description = NSPersistentStoreDescription()
              description.url = URL(fileURLWithPath: "/dev/null")
              self.persistentContainer.persistentStoreDescriptions = [description]
            }

        self.persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        self.mainContext = persistentContainer.viewContext
    }
    
    /// Create new FavoriteID from ID
    @discardableResult
    func createFavoriteId(id: String) -> FavoriteMeteorLanding? {
        let context = persistentContainer.viewContext
        
        let favoriteMeteorLanding = FavoriteMeteorLanding(context: context)
        
        favoriteMeteorLanding.id = id
        
        do {
            try context.save()
            return favoriteMeteorLanding
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    /// Fetch all FavoriteIds from Persistence
    func fetchFavoriteIds() -> [FavoriteMeteorLanding]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FavoriteMeteorLanding>(entityName: "FavoriteMeteorLanding")
        
        do {
            let favoriteMeteorLanding = try context.fetch(fetchRequest)
            return favoriteMeteorLanding
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    /// Fetch FavoriteId from Persistence with the same id passed through the parameter
    func fetchFavoriteId(withId id: String) -> FavoriteMeteorLanding? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FavoriteMeteorLanding>(entityName: "FavoriteMeteorLanding")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let favoriteMeteorLanding = try context.fetch(fetchRequest)
            return favoriteMeteorLanding.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    /// Update one favoriteId sended through parameter
    func updateFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    /// Remove one favoriteId sended through parameter
    func deleteFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding) {
        let context = persistentContainer.viewContext
        context.delete(favoriteMeteorLanding)
        
        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
}
