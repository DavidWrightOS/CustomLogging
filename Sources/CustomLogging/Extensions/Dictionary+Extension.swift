//
//  Dictionary+Extension.swift
//  CustomLogging
//
//  Created by David Wright on 5/30/25.
//

import Foundation

extension Dictionary where Key == String {

    mutating func first(upTo maxItems: Int) {
        var counter: Int = 0
        for (key, _) in self {
            if counter >= maxItems {
                removeValue(forKey: key)
            } else {
                counter += 1
            }
        }
    }
}
