//
//  NetworkClient.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation

/// Protocol for help to mock URLSession
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

//MARK: Conform the protocol

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

/// Make URLSessionDataTask implements URLSessionDataTaskProtocol
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionDataTaskProtocol {
    func resume()
}

/// Typealias for return type in escaping completion on data task,
typealias completeResult = Result<Data, Error>

/// Class for make requests to the API Rest (Only GET method for this project)
class NetworkClient {
    
    
    private let session: URLSessionProtocol
    
    /// Init that waits some object that conforms URLSessionProtocol, making DI for better testability
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /// Function for make a GET request, with URL and header if is needed (like X-App-Header property)
    func get(_ url: URL, header: [String: String]? = nil, completion: @escaping (completeResult)->()) {
        var request = URLRequest(url: url)
        if let header = header {
            request.allHTTPHeaderFields = header
        }
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
