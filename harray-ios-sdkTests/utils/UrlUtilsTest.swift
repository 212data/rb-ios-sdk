//
//  UrlUtilsTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 21.04.2021.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import Foundation

import XCTest

class UrlUtilsTest: XCTestCase {
    
    func test_it_should_remove_trailing_slash_from_url_if_exists() {
        XCTAssertEqual("http://relevantbox.io", UrlUtils.removeTrailingSlash(url: "http://relevantbox.io/"))
        XCTAssertEqual("http://relevantbox.io", UrlUtils.removeTrailingSlash(url: "http://relevantbox.io"))
    }    
}
