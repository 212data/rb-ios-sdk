//
//  XennConfigTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 21.04.2021.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import XCTest

class RBConfigTest: XCTestCase {
    
    func test_it_should_create_rb_config() {
        
        let rbConfig = RBConfig.create(sdkKey: "sdkKey", collectorUrl: "https://c.relevantbox.io")
        
        XCTAssertEqual("sdkKey", rbConfig.getSdkKey())
        XCTAssertEqual("https://c.relevantbox.io", rbConfig.getCollectorUrl())
        XCTAssertEqual("https://api.relevantbox.io", rbConfig.getApiUrl())
    }
    
    func test_it_should_create_rb_config_with_custom_apiUrl() {
        
        let rbConfig = RBConfig
            .create(sdkKey: "sdkKey", collectorUrl: "https://c.relevantbox.io/")
            .apiUrl(url: "https://myapi.relevantbox.io/")
        
        XCTAssertEqual("sdkKey", rbConfig.getSdkKey())
        XCTAssertEqual("https://c.relevantbox.io", rbConfig.getCollectorUrl())
        XCTAssertEqual("https://myapi.relevantbox.io", rbConfig.getApiUrl())
    }
}
