//
//  NetworkServiceError.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation


enum NetworkError: Error {
    case badData
    case badResponse
    case badRequest
    case badDecode
    case badEncode
    case unknown(String)
}
