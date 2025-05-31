//
//  FirebaseCrashlyticsService.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

import FirebaseCrashlytics

public struct FirebaseCrashlyticsService: LogService {

    public init() { }

    public func trackEvent(event: LoggableEvent) {
        switch event.type {
        case .info, .analytic, .warning:
            break
        case .severe:
            let error = NSError(
                domain: event.eventName,
                code: event.eventName.stableHashValue,
                userInfo: event.parameters
            )
            Crashlytics.crashlytics().record(error: error, userInfo: event.parameters)
        }
    }

    public func trackScreenView(event: LoggableEvent) {
        trackEvent(event: event)
    }

    public func identifyUser(userId: String, name: String?, email: String?) {
        Crashlytics.crashlytics().setUserID(userId)

        if let name {
            Crashlytics.crashlytics().setCustomValue(name, forKey: "account_name")
        }
        if let email {
            Crashlytics.crashlytics().setCustomValue(email, forKey: "account_email")
        }
    }
    
    public func addUserProperties(dict: [String: Any], isHightPriority: Bool) {
        guard isHightPriority else { return }
        for (key, value) in dict {
            Crashlytics.crashlytics().setCustomValue(value, forKey: key)
        }
    }
    
    public func deleteUserProfile() {
        Crashlytics.crashlytics().setUserID("new")
    }
}
