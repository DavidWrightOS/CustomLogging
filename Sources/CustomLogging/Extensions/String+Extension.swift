//
//  String+Extension.swift
//  CustomLogging
//
//  Created by David Wright on 5/30/25.
//

import Foundation

extension String {

    var stableHashValue: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) { ($0 << 5) &+ $0 &+ Int($1) }
    }

    func clipped(maxCharacters: Int) -> String {
        String(prefix(maxCharacters))
    }

    func replaceSpacesWithUnderscores() -> String {
        self.replacingOccurrences(of: " ", with: "_")
    }

    func clean(maxCharacters: Int) -> String {
        self
            .clipped(maxCharacters: maxCharacters)
            .replaceSpacesWithUnderscores()
    }
}
