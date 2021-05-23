//
//  XennConfig.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 20.04.2021.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import Foundation

@objc public class RBConfig: NSObject {
    
    private let sdkKey: String
    private var collectorUrl: String = Constants.RB_COLLECTOR_URL.rawValue
    private var apiUrl: String = Constants.RB_API_URL.rawValue

    private init(sdkKey: String, collectorUrl: String) {
        self.sdkKey = sdkKey
        self.collectorUrl = collectorUrl
    }
    
    public static func create(sdkKey: String, collectorUrl: String) -> RBConfig {
        return RBConfig(sdkKey: sdkKey, collectorUrl: getValidUrl(url: collectorUrl))
    }

    public func apiUrl(url: String) -> RBConfig {
        self.apiUrl = RBConfig.getValidUrl(url: url)
        return self
    }

    public func getSdkKey() -> String {
        return self.sdkKey
    }

    public func getCollectorUrl() -> String {
        return self.collectorUrl
    }

    public func getApiUrl() -> String {
        return self.apiUrl
    }
    
    private static func getValidUrl(url: String) -> String {
        return UrlUtils.removeTrailingSlash(url: url)
    }
}
