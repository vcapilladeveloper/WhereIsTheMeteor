//
//  EnvUtilsTests.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import XCTest
@testable import WhereIsTheMeteor
class EnvUtilsTests: XCTestCase {

    func test_bundle_identifier_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = EnvUtils.getConfiguration(with: "CFBundleIdentifier")
        XCTAssertEqual(value, "com.vcapilladeveloper.WhereIsTheMeteor")
    }
    
    func test_empty_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = EnvUtils.getConfiguration(with: "")
        XCTAssertNil(value)
    }
    
    func test_base_url_not_empty_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = EnvUtils.getConfiguration(with: "BASE_URL")
        XCTAssertNotNil(value)
    }

}
