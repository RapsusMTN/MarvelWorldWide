//
//  MWNetwork.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
internal class MWNetwork {
    
    // MARK: - Properties
    public static var timeout: Double?
    // TODO: Comment this functions correctly!!
    // MARK: - Functions
    /// - Summary
    ///
    ///
    ///  - Parameter
    public static func executeRequest(endpoint: MWEndpointProtocol, session: URLSession, completion: @escaping (Result<(data: Data, statusCode: Int), MWNetworkError>) -> Void) {
                
        // Create the current request with factory pattern passing specific endpoint
        guard let request = MWRequestFactory.setup(endpoint: endpoint, timeout: timeout) else {
            let tmNetworkError = MWNetworkError.invalidRequest
            completion(.failure(tmNetworkError))
            return
        }
        print("REQUEST ☄️ \(String(describing: request.url))")
        session.dataTask(with: request, completionHandler: { data, response, error in
            checkResponse(data: data, response: response, error: error) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let tuple):
                        completion(.success((data: tuple.data, statusCode: tuple.statusCode)))
                    case .failure(let tmNetworkError):
                        completion(.failure(tmNetworkError))
                    }
                }
            }
        }).resume()
    }
    
    // MARK: - Private Functions
    /// CheckResponse Function manage the result of URLRequest status code and possible errors.
    /// ```
    ///  Example discussion
    ///  ```
    ///
    /// - Parameter Data: A  parameter to check data object.
    /// - Parameter Response: The response of the URLRequest.
    /// - Parameter Error: The possible error.
    /// - Parameter Completion: The completion block to captura the success case with a tuple of (Data, StatusCode) and the failure case that returns a MWNetworkError.
    /// - Returns Void.
    private static func checkResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<(data: Data, statusCode: Int), MWNetworkError>) -> Void) {
        
        // Check the error in the response.
        if let error = error {
            let tmNetworkError = MWNetworkError.error(message: error.localizedDescription)
            completion(.failure(tmNetworkError))
            return
        }
        
        // Check the response.
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            let tmNetworkError = MWNetworkError.invalidResponse
            completion(.failure(tmNetworkError))
            return
        }
        
        completion(.success((data: data, statusCode: httpResponse.statusCode)))
    }
}
