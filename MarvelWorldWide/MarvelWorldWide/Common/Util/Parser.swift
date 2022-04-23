//
//  Parser.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/// Struct responsible for parse the result of the request. The parser only parse to the model that implement decodable protocol
public struct Parser<T: Decodable> {
    /**
     Parse the data result from the response to specific model
     
     - Parameter data: data from response from the request
     - Parameter model: data model that will be parsed to model type
     
     - Returns: body of the request with the information of the file to be uploaded
     */
    static func parseData(_ data: Data) throws -> T {
         try JSONDecoder().decode(T.self, from: data)
    }
}
