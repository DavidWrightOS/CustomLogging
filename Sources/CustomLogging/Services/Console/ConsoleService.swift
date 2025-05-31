//
//  ConsoleService.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

import Foundation

public struct ConsoleService: LogService {

    private let logger = LogSystem()
    private var printParameters: Bool

    public init(printParameters: Bool = true) {
        self.printParameters = printParameters
    }

    public func trackEvent(event: LoggableEvent) {
        var string = "\(event.type.emoji) \(event.eventName)"

        if printParameters, let params = event.parameters, !params.isEmpty {
            let sortedKeys = params.keys.sorted()
            for key in sortedKeys {
                if let value = params[key] {
                    string += "\n  (key: \"\(key)\", value: \(value))"
                }
            }
        }

        logger.log(level: event.type, message: string)
    }

    public func trackScreenView(event: LoggableEvent) {
        trackEvent(event: event)
    }

    public func identifyUser(userId: String, name: String?, email: String?) {
        var string = """
            📈 Identify User
              userId: \(userId)
            """

        if printParameters {
            string += """
                  name: \(name ?? "nil")
                  email: \(email ?? "nil")
                """
        }

        logger.log(level: .info, message: string)
    }

    public func addUserProperties(dict: [String: Any], isHightPriority: Bool) {
        var string = """
            📈 Add User Properties (isHightPriority: \(isHightPriority.description))
            """

        if printParameters {
            let sortedKeys = dict.keys.sorted()
            for key in sortedKeys {
                if let value = dict[key] {
                    string += "\n  (key: \"\(key)\", value: \(value))"
                }
            }
        }

        logger.log(level: .info, message: string)
    }

    public func deleteUserProfile() {
        let string = """
            📈 Delete User Profile
            """

        logger.log(level: .info, message: string)
    }
}
