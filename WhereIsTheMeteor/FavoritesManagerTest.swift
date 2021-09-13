//
//  FavoritesManagerTest.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 13/9/21.
//

import XCTest
import CoreData
@testable import WhereIsTheMeteor

class FavoritesManagerTest: XCTestCase {

    var sut: FavoritesManager!
    
    override func setUp() {
        super.setUp()
        sut = FavoritesManager(.inMemory)
    }

    func test_add_favorite() {
        addThreeElementsToFavorites()
        XCTAssertEqual(sut.fetchFavoriteIds()?.count, 3)
    }
    
    func test_fetch_all_favorites() {
        XCTAssertEqual(sut.fetchFavoriteIds()?.count, 0)
        addThreeElementsToFavorites()
        XCTAssertEqual(sut.fetchFavoriteIds()?.count, 3)
    }
    
    func test_fecth_one_favorite() {
        addThreeElementsToFavorites()
        XCTAssertEqual(sut.fetchFavoriteId(withId: "234")?.id, "234")
    }
    
    fileprivate func addThreeElementsToFavorites() {
        sut.createFavoriteId(id: "123")
        sut.createFavoriteId(id: "234")
        sut.createFavoriteId(id: "345")
    }
    
    func test_update_favorite() {
        addThreeElementsToFavorites()
        guard let favorite = sut.fetchFavoriteId(withId: "234") else {
            XCTAssert(false)
            return
        }
        favorite.id = "567"
        sut.updateFavoriteId(favoriteMeteorLanding: favorite)
        guard let updatedFavorite = sut.fetchFavoriteId(withId: "567") else {
            XCTAssert(false)
            return
        }
        XCTAssertEqual(updatedFavorite.id, "567")
    }
    
    func test_remove_favorite() {
        addThreeElementsToFavorites()
        XCTAssertEqual(sut.fetchFavoriteIds()?.count, 3)
        guard let favorite = sut.fetchFavoriteId(withId: "234") else {
            XCTAssert(false)
            return
        }
        sut.deleteFavoriteId(favoriteMeteorLanding: favorite)
        XCTAssertEqual(sut.fetchFavoriteIds()?.count, 2)
        
    }
}
