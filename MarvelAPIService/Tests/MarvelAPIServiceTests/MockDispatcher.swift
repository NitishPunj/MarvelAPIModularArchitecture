//
//  File.swift
//  
//
//  Created by Sharma, Nitish X on 04/10/2021.
//
import Networking
import Foundation

final class MockDispatcher: NetworkRequestDispatcing {
    
    var data: Data?
    var throwError = false
    
    func execute(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        throwError ? completion(.failure(.serverError)) : completion(.success(data))
    }
}

