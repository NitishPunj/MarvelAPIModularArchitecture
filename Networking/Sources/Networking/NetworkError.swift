//
//  NetworkError.swift
//  
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import Foundation

public enum NetworkError: Error {
    case error(message: String, error: Error)
    case serverError
}

extension NetworkError: Equatable {
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (serverError, serverError):
            return true
        case (error(_, let error1), error(_, let error2)):
            return error1._code == error2._code
        default:
            return false
        }
    }
}
