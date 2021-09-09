//
//  NetworkClientTests.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import XCTest
@testable import WhereIsTheMeteor

class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        sut = NetworkClient(session: session)
    }

    func test_get_request_with_URL() {

            guard let url = URL(string: "https://mockurl") else {
                fatalError("URL can't be empty")
            }
            
        sut.get(url) { result in
                // Return data
            }
            
            XCTAssert(session.lastURL == url)
            
        }
        
        func test_get_resume_called() {
            
            let dataTask = MockURLSessionDataTask()
            session.nextDataTask = dataTask
            
            guard let url = URL(string: "https://mockurl") else {
                fatalError("URL can't be empty")
            }
            
            sut.get(url) { result in
                // Return data
            }
            
            XCTAssert(dataTask.resumeWasCalled)
        }
        
        func test_get_should_return_data() {
            let expectedData = "{}".data(using: .utf8)
            
            session.nextData = expectedData
            
            var actualData: Data?
            sut.get(URL(string: "http://mockurl")!) { result in
                switch result {
                case .success(let data):
                    actualData = data
                default:
                    return
                }
            }
            
            XCTAssertNotNil(actualData)
        }
        
    
}
