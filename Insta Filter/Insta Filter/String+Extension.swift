//
//  String+Extension.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 30/06/2022.
//

import Foundation

extension String {

        func titlecased() -> String {
            return self.replacingOccurrences(
                of: "([A-Z])",
                with: " $1",
                options: .regularExpression,
                range: self.range(of: self)
            )
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .capitalized
        }
    
}
