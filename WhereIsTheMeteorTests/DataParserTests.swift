//
//  DataParserTests.swift
//  WhereIsTheMeteorTests
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import XCTest
@testable import WhereIsTheMeteor

class DataParserTests: XCTestCase {

    
    func test_parsing_not_nil_meteor_landing() {
        let meteorLanding: [MeteorLanding]? = try? DataParser.getData(from: mockModel)
        
        XCTAssertNotNil(meteorLanding)
    }
    
    func test_parse_all_data() {
            let meteorLanding: [MeteorLanding]? = try? DataParser.getData(from: mockModel)
            
            XCTAssertEqual(meteorLanding?.count, 12)
    }
    
    func test_parsing_bad_model_data() {
        let meteorLanding: [MeteorLanding]? = try? DataParser.getData(from: mockBadModel)
        
        XCTAssertNil(meteorLanding)
    }
    
    
    
    let mockModel: Data = """
    [{"name":"Aachen","id":"1","nametype":"Valid","recclass":"L5","mass":"21","fall":"Fell","year":"1880-01-01T00:00:00.000","reclat":"50.775000","reclong":"6.083330","geolocation":{"type":"Point","coordinates":[6.08333,50.775]}}
    ,{"name":"Aarhus","id":"2","nametype":"Valid","recclass":"H6","mass":"720","fall":"Fell","year":"1951-01-01T00:00:00.000","reclat":"56.183330","reclong":"10.233330","geolocation":{"type":"Point","coordinates":[10.23333,56.18333]}}
    ,{"name":"Abee","id":"6","nametype":"Valid","recclass":"EH4","mass":"107000","fall":"Fell","year":"1952-01-01T00:00:00.000","reclat":"54.216670","reclong":"-113.000000","geolocation":{"type":"Point","coordinates":[-113,54.21667]}}
    ,{"name":"Acapulco","id":"10","nametype":"Valid","recclass":"Acapulcoite","mass":"1914","fall":"Fell","year":"1976-01-01T00:00:00.000","reclat":"16.883330","reclong":"-99.900000","geolocation":{"type":"Point","coordinates":[-99.9,16.88333]}}
    ,{"name":"Achiras","id":"370","nametype":"Valid","recclass":"L6","mass":"780","fall":"Fell","year":"1902-01-01T00:00:00.000","reclat":"-33.166670","reclong":"-64.950000","geolocation":{"type":"Point","coordinates":[-64.95,-33.16667]}}
    ,{"name":"Adhi Kot","id":"379","nametype":"Valid","recclass":"EH4","mass":"4239","fall":"Fell","year":"1919-01-01T00:00:00.000","reclat":"32.100000","reclong":"71.800000","geolocation":{"type":"Point","coordinates":[71.8,32.1]}}
    ,{"name":"Adzhi-Bogdo (stone)","id":"390","nametype":"Valid","recclass":"LL3-6","mass":"910","fall":"Fell","year":"1949-01-01T00:00:00.000","reclat":"44.833330","reclong":"95.166670","geolocation":{"type":"Point","coordinates":[95.16667,44.83333]}}
    ,{"name":"Agen","id":"392","nametype":"Valid","recclass":"H5","mass":"30000","fall":"Fell","year":"1814-01-01T00:00:00.000","reclat":"44.216670","reclong":"0.616670","geolocation":{"type":"Point","coordinates":[0.61667,44.21667]}}
    ,{"name":"Aguada","id":"398","nametype":"Valid","recclass":"L6","mass":"1620","fall":"Fell","year":"1930-01-01T00:00:00.000","reclat":"-31.600000","reclong":"-65.233330","geolocation":{"type":"Point","coordinates":[-65.23333,-31.6]}}
    ,{"name":"Aguila Blanca","id":"417","nametype":"Valid","recclass":"L","mass":"1440","fall":"Fell","year":"1920-01-01T00:00:00.000","reclat":"-30.866670","reclong":"-64.550000","geolocation":{"type":"Point","coordinates":[-64.55,-30.86667]}}
    ,{"name":"Aioun el Atrouss","id":"423","nametype":"Valid","recclass":"Diogenite-pm","mass":"1000","fall":"Fell","year":"1974-01-01T00:00:00.000","reclat":"16.398060","reclong":"-9.570280","geolocation":{"type":"Point","coordinates":[-9.57028,16.39806]}}
    ,{"name":"Aïr","id":"424","nametype":"Valid","recclass":"L6","mass":"24000","fall":"Fell","year":"1925-01-01T00:00:00.000","reclat":"19.083330","reclong":"8.383330","geolocation":{"type":"Point","coordinates":[8.38333,19.08333]}}]
    """.data(using: .utf8)!
    
    let mockBadModel: Data = """
    [{"name":5,"id":"1","nametype":"Valid","recclass":"L5","mass":"21","fall":"Fell","year":"1880-01-01T00:00:00.000","reclat":"50.775000","reclong":"6.083330","geolocation":{"type":"Point","coordinates":[6.08333,50.775]}}
    ,{"name":"Aarhus","id":"2","nametype":"Valid","recclass":"H6","mass":"720","fall":"Fell","year":"1951-01-01T00:00:00.000","reclat":"56.183330","reclong":"10.233330","geolocation":{"type":"Point","coordinates":[10.23333,56.18333]}}
    ,{"name":"Abee","id":"6","nametype":"Valid","recclass":"EH4","mass":"107000","fall":"Fell","year":"1952-01-01T00:00:00.000","reclat":"54.216670","reclong":"-113.000000","geolocation":{"type":"Point","coordinates":[-113,54.21667]}}
    ,{"name":"Acapulco","id":"10","nametype":"Valid","recclass":"Acapulcoite","mass":"1914","fall":"Fell","year":"1976-01-01T00:00:00.000","reclat":"16.883330","reclong":"-99.900000","geolocation":{"type":"Point","coordinates":[-99.9,16.88333]}}
    ,{"name":"Achiras","id":"370","nametype":"Valid","recclass":"L6","mass":"780","fall":"Fell","year":"1902-01-01T00:00:00.000","reclat":"-33.166670","reclong":"-64.950000","geolocation":{"type":"Point","coordinates":[-64.95,-33.16667]}}
    ,{"name":"Adhi Kot","id":"379","nametype":"Valid","recclass":"EH4","mass":"4239","fall":"Fell","year":"1919-01-01T00:00:00.000","reclat":"32.100000","reclong":"71.800000","geolocation":{"type":"Point","coordinates":[71.8,32.1]}}
    ,{"name":"Adzhi-Bogdo (stone)","id":"390","nametype":"Valid","recclass":"LL3-6","mass":"910","fall":"Fell","year":"1949-01-01T00:00:00.000","reclat":"44.833330","reclong":"95.166670","geolocation":{"type":"Point","coordinates":[95.16667,44.83333]}}
    ,{"name":"Agen","id":"392","nametype":"Valid","recclass":"H5","mass":"30000","fall":"Fell","year":"1814-01-01T00:00:00.000","reclat":"44.216670","reclong":"0.616670","geolocation":{"type":"Point","coordinates":[0.61667,44.21667]}}
    ,{"name":"Aguada","id":"398","nametype":"Valid","recclass":"L6","mass":"1620","fall":"Fell","year":"1930-01-01T00:00:00.000","reclat":"-31.600000","reclong":"-65.233330","geolocation":{"type":"Point","coordinates":[-65.23333,-31.6]}}
    ,{"name":"Aguila Blanca","id":"417","nametype":"Valid","recclass":"L","mass":"1440","fall":"Fell","year":"1920-01-01T00:00:00.000","reclat":"-30.866670","reclong":"-64.550000","geolocation":{"type":"Point","coordinates":[-64.55,-30.86667]}}
    ,{"name":"Aioun el Atrouss","id":"423","nametype":"Valid","recclass":"Diogenite-pm","mass":"1000","fall":"Fell","year":"1974-01-01T00:00:00.000","reclat":"16.398060","reclong":"-9.570280","geolocation":{"type":"Point","coordinates":[-9.57028,16.39806]}}
    ,{"name":"Aïr","id":"424","nametype":"Valid","recclass":"L6","mass":"24000","fall":"Fell","year":"1925-01-01T00:00:00.000","reclat":"19.083330","reclong":"8.383330","geolocation":{"type":"Point","coordinates":[8.38333,19.08333]}}]
    """.data(using: .utf8)!

}
