//
//  LoggableEvent.swift
//  AIChat
//
//  Created by David Wright on 5/16/25.
//

public protocol LoggableEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var type: LogType { get }
}
