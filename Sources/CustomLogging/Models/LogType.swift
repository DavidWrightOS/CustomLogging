//
//  LogType.swift
//  AIChat
//
//  Created by David Wright on 5/30/25.
//

public enum LogType: Int, Sendable {
    /// User `info` for informative tasks. These are not condidered analytics, issues, or errors.
    case info // 0
    /// Default type for analytics.
    case analytic // 1
    /// Issues or errors that should not occur, but will not negatively affect the user experience.
    case warning // 2
    /// Issues or errors that negatively affect the user experience.
    case severe // 3

    var emoji: String {
        switch self {
        case .info: "👋"
        case .analytic: "📈"
        case .warning: "⚠️"
        case .severe: "🚨"
        }
    }
}
