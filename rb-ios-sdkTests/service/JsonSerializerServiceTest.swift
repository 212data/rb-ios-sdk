//
// Created by YILDIRIM ADIGÜZEL on 23.04.2020.
// Copyright © 2020 RelevantBox. All rights reserved.
//

import XCTest

class JsonSerializerServiceTest: XCTestCase {
    func it_should_convert_object_to_json_string() {
        let innerParameters: Dictionary<String, Any> = ["inner": true, "itemCount": 2, "itemName": "testing"]
        let parameters: Dictionary<String, Any> = ["foo": "bar", "relevantbox": "is_the_best", "success": true, "price": 123.2, "eventCount": 5, "inner": innerParameters]
        let jsonSerializerService = JsonSerializerService()

        let result = jsonSerializerService.serialize(value: parameters)

        XCTAssertEqual("\"{\"foo\":\"bar\",\"success\":true,\"inner\":{\"itemName\":\"testing\",\"inner\":true,\"itemCount\":2},\"relevantbox\":\"is_the_best\",\"eventCount\":5,\"price\":123.2}\"", result!)
    }
}
