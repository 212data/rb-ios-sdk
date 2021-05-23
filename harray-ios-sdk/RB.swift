//
//  RB.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 RelevantBox. All rights reserved.
//

import Foundation
import UIKit

@objc public final class RB: NSObject {

    static var instance: RB?

    let sessionContextHolder: SessionContextHolder
    private let rb: RBConfig
    private var pushNotificationToken: String = ""
    private let applicationContextHolder: ApplicationContextHolder
    private let eventProcessorHandler: EventProcessorHandler
    private let sdkEventProcessorHandler: SDKEventProcessorHandler
    private let notificationProcessorHandler: NotificationProcessorHandler
    private let ecommerceEventProcessorHandler: EcommerceEventProcessorHandler
    private let recommendationProcessorHandler: RecommendationProcessorHandler

    private init(rbConfig: RBConfig,
                 sessionContextHolder: SessionContextHolder,
                 applicationContextHolder: ApplicationContextHolder,
                 eventProcessorHandler: EventProcessorHandler,
                 sdkEventProcessorHandler: SDKEventProcessorHandler,
                 notificationProcessorHandler: NotificationProcessorHandler,
                 ecommerceEventProcessorHandler: EcommerceEventProcessorHandler,
                 recommendationProcessorHandler: RecommendationProcessorHandler
    ) {
        self.sessionContextHolder = sessionContextHolder
        self.applicationContextHolder = applicationContextHolder
        self.eventProcessorHandler = eventProcessorHandler
        self.sdkEventProcessorHandler = sdkEventProcessorHandler
        self.notificationProcessorHandler = notificationProcessorHandler
        self.ecommerceEventProcessorHandler = ecommerceEventProcessorHandler
        self.rb = rbConfig
        self.recommendationProcessorHandler = recommendationProcessorHandler
    }

    @objc public class func configure(rbConfig: RBConfig) {
        let sessionContextHolder = SessionContextHolder()
        let applicationContextHolder = ApplicationContextHolder(userDefaults: UserDefaults.standard)
        let httpService = HttpService(sdkKey: rbConfig.getSdkKey(), session: URLSession.shared, collectorUrl: rbConfig.getCollectorUrl(), apiUrl: rbConfig.getApiUrl())
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        let deviceService = DeviceService(bundle: Bundle.main, uiDevice: UIDevice.current, uiScreen: UIScreen.main)

        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        let sdkEventProcessorHandler = SDKEventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService, deviceService: deviceService)
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: eventProcessorHandler)
        let recommendationProcessorHandler = RecommendationProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, sdkKey: rbConfig.getSdkKey(), jsonDeserializerService: JsonDeserializerService())

        instance = RB(rbConfig: rbConfig,
                sessionContextHolder: sessionContextHolder,
                applicationContextHolder: applicationContextHolder,
                eventProcessorHandler: eventProcessorHandler,
                sdkEventProcessorHandler: sdkEventProcessorHandler,
                notificationProcessorHandler: notificationProcessorHandler,
                ecommerceEventProcessorHandler: ecommerceEventProcessorHandler,
                recommendationProcessorHandler: recommendationProcessorHandler
        )
    }


    class func getInstance() -> RB {
        return instance!
    }

    @objc public class func eventing() -> EventProcessorHandler {
        let rbInstance = getInstance()
        let sessionContextHolder = rbInstance.sessionContextHolder
        if (sessionContextHolder.getSessionState() != SessionState.SESSION_STARTED) {
            rbInstance.sdkEventProcessorHandler.sessionStart()
            sessionContextHolder.startSession()
            if (rbInstance.applicationContextHolder.isNewInstallation()) {
                rbInstance.sdkEventProcessorHandler.newInstallation()
                rbInstance.applicationContextHolder.setInstallationCompleted()
            }
        }
        return rbInstance.eventProcessorHandler
    }

    @objc public class func notifications() -> NotificationProcessorHandler {
        let rbInstance = getInstance()
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        let httpService = HttpService(sdkKey: "feedback", session: URLSession.shared, collectorUrl: rbInstance.rb.getCollectorUrl(), apiUrl: rbInstance.rb.getApiUrl())
        return NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
    }

    @objc public class func login(memberId: String) {
        if "" != memberId {
            getInstance().sessionContextHolder.login(memberId: memberId)
            if "" != getInstance().pushNotificationToken {
                getInstance().eventProcessorHandler.savePushToken(deviceToken: getInstance().pushNotificationToken)
            }
        }
    }

    @objc public class func savePushToken(deviceToken: String) {
        getInstance().pushNotificationToken = deviceToken
        getInstance().eventProcessorHandler.savePushToken(deviceToken: deviceToken)
    }

    @objc public class func logout() {
        getInstance().eventProcessorHandler.removeTokenAssociation(deviceToken: getInstance().pushNotificationToken);
        getInstance().pushNotificationToken = ""
        getInstance().sessionContextHolder.logout()
    }

    @objc public class func synchronizeWith(externalParameters: Dictionary<String, Any>) {
        getInstance().sessionContextHolder.updateExternalParameters(data: externalParameters)
    }

    @objc public class func ecommerce() -> EcommerceEventProcessorHandler {
        return getInstance().ecommerceEventProcessorHandler
    }

    @objc public class func recommendations() -> RecommendationProcessorHandler {
        return getInstance().recommendationProcessorHandler
    }
}
