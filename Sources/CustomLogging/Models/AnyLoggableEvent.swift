//
//  AnyLoggableEvent.swift
//  AIChat
//
//  Created by David Wright on 5/30/25.
//

public struct AnyLoggableEvent: LoggableEvent {
    public var eventName: String
    public var parameters: [String: Any]?
    public var type: LogType

    public init(
        eventName: String,
        parameters: [String: Any]? = nil,
        type: LogType = .analytic
    ) {
        self.eventName = eventName
        self.parameters = parameters
        self.type = type
    }
}
