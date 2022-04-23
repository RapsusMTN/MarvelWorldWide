//
//  EnvironmentProperty.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/**
 This struct get the Keys from Info.Plist file associated by the environments
*/
public struct EnvironmentProperty: EnvironmentPropertyProtocol {
    // MARK: - Properties
    public static var KEY_ENVIRONMENT: String {
        Bundle.main.object(forInfoDictionaryKey: "KEY_ENVIRONMENT") as? String ?? "No key"
    }
    public static var PUBLIC_API_KEY: String {
        Bundle.main.object(forInfoDictionaryKey: "PUBLIC_API_KEY") as? String ?? "No key"
    }
    public static var PRIVATE_API_KEY: String {
        Bundle.main.object(forInfoDictionaryKey: "PRIVATE_API_KEY") as? String ?? "No key"
    }
    public static var MARVEL_URL_BASE_KEY: String {
        Bundle.main.object(forInfoDictionaryKey: "MARVEL_URL_BASE_KEY") as? String ?? "No key"
    }
}
