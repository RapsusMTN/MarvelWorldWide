//
//  MWNetworkError.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/// Main struct of Network errors.
/// - All of cases need to introduce a param to print the error description.
///
///
public enum MWNetworkError: Error {
    case error(message: String)
    case parserError(message: String)
    case invalidRequest
    case invalidResponse
    case badRequest(message: String)
    case unAuthorized(message: String)
    case internalServer(message: String)
    case saveModelDataBaseError
    case getModelDataBaseError
    
    public var description: String {
        switch self {
        case .error(let message), .parserError(let message), .badRequest(let message), .unAuthorized(let message), .internalServer(let message):
            return message
        case .invalidResponse:
            return "Invalid Response Error"
        case .invalidRequest:
            return "Invalid Request Error"
        case .saveModelDataBaseError:
            return "No se han podido almacenar los datos en la caché"
        case .getModelDataBaseError:
            return "No se han podido recuperar los datos de la caché"
        }
    }
}
