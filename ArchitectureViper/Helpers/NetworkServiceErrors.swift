//
//  NetworkServiceErrors.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 18/09/23.
//

import Foundation

enum NetworkServiceErrors: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case noConnection
    case decodeFailure
    
    var localizedDescription: String {
        switch self {
            
        case .invalidURL:
            return "Invalid URL, cannot continue with request."
        case .requestFailed(_):
            return "Something went wrong, the request failed."
        case .invalidResponse:
            return "Invalid Response."
        case .invalidData:
            return "Invalid Data."
        case .noConnection:
            return "No data retrieved, please check your internet connection."
        case .decodeFailure:
            return "Decode failed, please check your JSON properties."
        }
    }
}
