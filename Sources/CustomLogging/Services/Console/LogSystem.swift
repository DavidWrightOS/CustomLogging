//
//  LogSystem.swift
//  AIChat
//
//  Created by David Wright on 5/30/25.
//

import OSLog

actor LogSystem {

    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ConsoleLogger")

    private func log(level: OSLogType, message: String) {
        logger.log(level: level, "\(message)")
    }

    nonisolated func log(level: LogType, message: String) {
        Task {
            await log(level: level.OSLogType, message: message)
        }
    }
}
