//
//  ApiGetJsonRequest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 29.01.2021.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import XCTest

class ApiGetJsonRequestTest: XCTestCase {
    
    func test_it_should_construct_get_api_request() {
        let apiGetJsonRequest = ApiGetJsonRequest(endpoint: "http://api.relevantbox.io/get?param=value")
        
        let urlRequest = apiGetJsonRequest.getUrlRequest()
        
        XCTAssertEqual("http://api.relevantbox.io/get?param=value", urlRequest.url?.absoluteString)
        XCTAssertEqual("GET", urlRequest.httpMethod!)
        XCTAssertEqual("application/json", urlRequest.value(forHTTPHeaderField: "Accept")!)
    }
}
