//
//  NetworkServiceProtocols.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation


protocol NetworkServiceProtocols {
    func fetchData<T: Codable>(
        url: URL,
        httpMethod: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        complition: (Result<T, NetworkServiceError>) -> Void)
}
