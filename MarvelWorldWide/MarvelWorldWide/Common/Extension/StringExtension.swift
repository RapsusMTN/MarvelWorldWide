//
//  StringExtension.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
