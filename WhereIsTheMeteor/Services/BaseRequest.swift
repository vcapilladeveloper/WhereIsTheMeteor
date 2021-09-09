//
//  BaseRequest.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

class BaseRequest: Request {
    private var request: URLRequest
    
    init(urlRequest: URLRequest) {
        self.request = urlRequest
    }
    
    var urlRequest: URLRequest {
        /// Headers
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
