//
//  NetworkServiceError.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation
enum NetworkServiceError: Error {
    case BadData
    case BadResponse
    case badRequest
    case BadDecode
    case BadEncode
    case unknown(String)
}
