//
//  FavoritesManager.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation
import CoreData

protocol PersistenceManagerProtocol {
    func createFavoriteId(id: String) -> FavoriteMeteorLanding?
    func fetchFavoriteIds() -> [FavoriteMeteorLanding]?
    func fetchFavoriteId(withId id: String) -> FavoriteMeteorLanding?
    func updateFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding)
    func deleteFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding)
}

struct FavoritesManager: PersistenceManagerProtocol {
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "WhereIsTheMeteor")
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
    }
    
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
    
    func updateFavoriteId(favoriteMeteorLanding: FavoriteMeteorLanding) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
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
