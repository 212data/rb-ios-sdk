//
// Created by YILDIRIM ADIGÜZEL on 23.04.2020.
// Copyright © 2020 RelevantBox. All rights reserved.
//

import XCTest

class RBTest: XCTestCase {

    func test_it_should_throw_error_when_try_to_get_instance_without_invoking_configuration() throws {
        do {
            try RB.eventing()
        } catch RBError.configuration(let message) {
            XCTAssertEqual("RB.configure(rbConfig: rbConfig) must be called before getting instance", message)
        }
    }

    func test_it_should_return_same_instance_when_get_method_called_more_than_one_time() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        let instance1 = try RB.getInstance()
        let instance2 = try RB.getInstance()
        XCTAssertEqual(instance1, instance2)
    }

    func test_it_should_log_in_with_memberId() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        RB.login(memberId: "memberId")
        XCTAssertEqual("memberId", RB.instance!.sessionContextHolder.getMemberId())
    }

    func test_it_should_not_try_to_log_in_with_member_id_when_string_is_empty() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        RB.login(memberId: "")
        XCTAssertNil(RB.instance!.sessionContextHolder.getMemberId())
    }

    func test_it_should_log_out_with_memberId() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        RB.login(memberId: "memberId")
        XCTAssertEqual("memberId", RB.instance!.sessionContextHolder.getMemberId())
        RB.logout()
        XCTAssertNil(RB.instance!.sessionContextHolder.getMemberId())
    }
    
    func test_it_should_get_ecommerce_handler() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        let handler = RB.ecommerce()
        XCTAssertEqual(String(describing: type(of: handler)), "EcommerceEventProcessorHandler")
    }
    
    func test_it_should_get_recommendations_handler() {
        RB.configure(rbConfig: RBConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.relevantbox.io"))
        let handler = RB.recommendations()
        XCTAssertEqual(String(describing: type(of: handler)), "RecommendationProcessorHandler")
    }
}
