//
//  NetworkRequestDispatcher.swift
//  
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import Foundation

public protocol NetworkRequestDispatcing {
    func execute(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}


public final class NetworkRequestDispatcher: NetworkRequestDispatcing {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func execute(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(message: error.localizedDescription, error: error)))
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(data))
                default:
                    completion(.failure(.serverError))
                }
            }
        }
        dataTask.resume()
    }
}

