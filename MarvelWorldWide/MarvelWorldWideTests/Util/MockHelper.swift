//
//  MockHelper.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation
import XCTest

func getMockFromBundle(name: String, extensionFile: String = "json", bundleClass: XCTestCase) -> Data {
    let bundle = Bundle(for: type(of: bundleClass))
    guard let fileUrl = bundle.url(forResource: name, withExtension: extensionFile),
        let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Missing mock")
    }
    return data
}
