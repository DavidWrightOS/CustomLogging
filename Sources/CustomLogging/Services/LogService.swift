//
//  LogService.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

public protocol LogService {
    func identifyUser(userId: String, name: String?, email: String?)
    func addUserProperties(dict: [String: Any], isHightPriority: Bool)
    func deleteUserProfile()

    func trackEvent(event: LoggableEvent)
    func trackScreenView(event: LoggableEvent)
}
