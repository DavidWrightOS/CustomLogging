//
//  LogManager.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

import SwiftUI

@MainActor
@Observable
public class LogManager {

    private let services: [LogService]

    public init(services: [LogService] = []) {
        self.services = services
    }

    func trackEvent(eventName: String, parameters: [String: Any]? = nil, type: LogType = .analytic) {
        let event = AnyLoggableEvent(eventName: eventName, parameters: parameters, type: type)
        for service in services {
            service.trackEvent(event: event)
        }
    }

    func trackEvent(event: AnyLoggableEvent) {
        for service in services {
            service.trackEvent(event: event)
        }
    }

    func trackEvent(event: LoggableEvent) {
        for service in services {
            service.trackEvent(event: event)
        }
    }

    func trackScreenView(event: LoggableEvent) {
        for service in services {
            service.trackScreenView(event: event)
        }
    }

    func identifyUser(userId: String, name: String?, email: String?) {
        for service in services {
            service.identifyUser(userId: userId, name: name, email: email)
        }
    }

    func addUserProperties(dict: [String: Any], isHighPriority: Bool = false) {
        for service in services {
            service.addUserProperties(dict: dict, isHightPriority: isHighPriority)
        }
    }

    func deleteUserProfile() {
        for service in services {
            service.deleteUserProfile()
        }
    }
}
