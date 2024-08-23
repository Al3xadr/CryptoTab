//
//  NetworkService.swift
//  CryptoTab
//
//  Created by apple on 22.08.2024.
//

import Foundation


class NetworkService: NetworkServiceProtocols {
    func fetchData<T>(url: URL, httpMethod: HTTPMethod, body: (any Encodable)?, headers: [String : String]?, complition: (Result<T, NetworkServiceError>) -> Void) where T : Decodable, T : Encodable {
        
    }
    
    
}
