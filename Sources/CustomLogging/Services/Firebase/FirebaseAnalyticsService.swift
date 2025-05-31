//
//  FirebaseAnalyticsService.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

import FirebaseAnalytics
import Foundation

public struct FirebaseAnalyticsService: LogService {

    public static var appInstanceID: String? {
        Analytics.appInstanceID()
    }

    public init() { }

    public func trackEvent(event: LoggableEvent) {
        guard event.type != .info else { return }

        var parameters = event.parameters ?? [:]

        // Fix any values that are bad types
        for (key, value) in parameters {
            if let date = value as? Date, let string = convertToString(date) {
                parameters[key] = string
            } else if let array = value as? [Any] {
                if let string = convertToString(array) {
                    parameters[key] = string
                } else {
                    parameters[key] = nil
                }
            }
        }

        // Fix key length limits
        for (key, value) in parameters where key.count > 40 {
            parameters.removeValue(forKey: key)
            let newKey = key.clean(maxCharacters: 40)
            parameters[newKey] = value
        }

        // Fix value length limits
        for (key, value) in parameters {
            if let string = value as? String {
                parameters[key] = string.clean(maxCharacters: 100)
            }
        }

        parameters.first(upTo: 25)

        let name = event.eventName.clean(maxCharacters: 40)
        Analytics.logEvent(name, parameters: parameters.isEmpty ? nil : parameters)
    }

    public func trackScreenView(event: LoggableEvent) {
        let name = event.eventName.clean(maxCharacters: 40)

        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: name
        ])
    }

    public func identifyUser(userId: String, name: String?, email: String?) {
        Analytics.setUserID(userId)

        if let name {
            Analytics.setUserProperty(name, forName: "account_name")
        }
        if let email {
            Analytics.setUserProperty(email, forName: "account_email")
        }
    }
    
    public func addUserProperties(dict: [String: Any], isHightPriority: Bool) {
        guard isHightPriority else { return }

        for (key, value) in dict {
            if let string = convertToString(value) {
                let key = key.clean(maxCharacters: 24)
                let string = string.clean(maxCharacters: 100)
                Analytics.setUserProperty(string, forName: key)
            }
        }
    }
    
    public func deleteUserProfile() {

    }

    private func convertToString(_ value: Any) -> String? {
        switch value {
        case let value as String:
            return value
        case let value as Int:
            return String(value)
        case let value as Double:
            return String(value)
        case let value as Float:
            return String(value)
        case let value as Bool:
            return String(value)
        case let value as Date:
            return value.formatted(date: .abbreviated, time: .shortened)
        case let array as [Any]:
            return array.compactMap { convertToString($0) }.sorted().joined(separator: ", ")
        case let value as CustomStringConvertible:
            return value.description
        default:
            return nil
        }
    }
}
