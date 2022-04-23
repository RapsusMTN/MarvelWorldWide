//
//  ResponseGenericModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/**
 This struct is generic for all responses.
 */
public struct ResponseModel<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: DataResponse<T>
}

public struct DataResponse<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
/**
 Response model error
 */
public struct ResponseError: Decodable {
    let code: Int
    let status: String
}
