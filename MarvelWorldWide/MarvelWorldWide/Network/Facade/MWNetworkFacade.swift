//
//  MWNetworkFacade.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/**
 Facade pattern responsible of match all responses and match status code or errors
 */
public class MWNetworkFacade {
    
    public static func executeRequest<T: Decodable>(endpoint: MWEndpointProtocol, model: T.Type, session: URLSession, completion: @escaping (Result<ResponseModel<T>, MWNetworkError>) -> Void) {
        executeInternalRequest(endpoint: endpoint, model: model, session: session, completion: completion)
    }
    ///
    /// This functions execute and match the different Result types.
    /// ```
    ///  Example discussion
    ///  ```
    /// - Parameter Endpoint: The endpoint to launch URLRequest
    /// - Parameter Model: The generic decodable model
    /// - Parameter Session: The URLSession instantiated
    /// - Parameter Completion: This completion capture the model Parsed in the success case and the MWNetworkError in the failure case
    ///  - SeeAlso URLSession official Apple Documentation.
    ///  - Returns Void.
    private static func executeInternalRequest<T: Decodable>(endpoint: MWEndpointProtocol, model: T.Type, session: URLSession, completion: @escaping (Result<ResponseModel<T>, MWNetworkError>) -> Void) {
        
        MWNetwork.executeRequest(endpoint: endpoint, session: session) { result in
            switch result {
            case .success(let responseTuple):
                switch responseTuple.statusCode {
                case 200...299:
                    do {
                        let dataParsed = try Parser<ResponseModel<T>>.parseData(responseTuple.data)
                        print("✅\(responseTuple.statusCode) OK")
                        completion(.success(dataParsed))
                    } catch let error {
                        print(error)
                        let mwNetworkError = MWNetworkError.parserError(message: error.localizedDescription)
                        completion(.failure(mwNetworkError))
                    }
                    // All errors handle here! (400..500)
                default:
                    do {
                        let dataParsed = try Parser<ResponseError>.parseData(responseTuple.data)
                        print("❌\(responseTuple.statusCode) KO")
                        let mwNetworkError = MWNetworkError.error(message: dataParsed.status)
                        completion(.failure(mwNetworkError))
                    } catch let error {
                        print(error)
                        let mwNetworkError = MWNetworkError.parserError(message: error.localizedDescription)
                        completion(.failure(mwNetworkError))
                    }
                }
            case .failure(let mwNetworkError):
                completion(.failure(mwNetworkError))
            }
        }
    }
}
