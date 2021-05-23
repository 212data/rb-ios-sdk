//
//  RBLogger.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import Foundation
import os

class RBLogger {
    private init() {

    }

    class func log(message: String) {
        os_log("%@.", message)
    }

}
