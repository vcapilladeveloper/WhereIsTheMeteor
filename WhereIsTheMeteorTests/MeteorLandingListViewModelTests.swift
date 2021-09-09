//
//  MeteorLandingListViewModelTests.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import XCTest
@testable import WhereIsTheMeteor

class MeteorLandingListViewModelTests: XCTestCase {

    var sut: MeteorLandingListViewModel!
    
    override func setUp() {
        super.setUp()
        sut = MeteorLandingListViewModel(MockMeteorLandingRepository())
    }
    
    func test_construct_url_not_nil() {
        let url = sut.constructURLForFecthFiltered()
        XCTAssertNotNil(url)
    }
    
    func test_validate_url() {
        sut.update(10)
        let urlYear10 = sut.constructURLForFecthFiltered()
        XCTAssertEqual(urlYear10?.absoluteString, "https://data.nasa.gov/resource/gh4g-9sfh.json?$where=year%3E=\'10-01-01T00%3A00%3A00\'")
        sut.update(50)
        let urlYear50 = sut.constructURLForFecthFiltered()
        XCTAssertEqual(urlYear50?.absoluteString, "https://data.nasa.gov/resource/gh4g-9sfh.json?$where=year%3E=\'50-01-01T00%3A00%3A00\'")
    }
    
    func test_fecth_data_modify_colection() {
        XCTAssertEqual(sut.meteorLanding.count, 0)
        sut.fecthData()
        XCTAssertEqual(sut.meteorLanding.count, 1)
    }

}
