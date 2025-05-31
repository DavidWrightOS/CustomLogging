//
//  LogType+OSLog.swift
//  AIChat
//
//  Created by David Wright on 5/30/25.
//

import OSLog

extension LogType {

    var OSLogType: OSLogType {
        switch self {
        case .info: .info
        case .analytic: .default
        case .warning: .error
        case .severe: .fault
        }
    }
}
