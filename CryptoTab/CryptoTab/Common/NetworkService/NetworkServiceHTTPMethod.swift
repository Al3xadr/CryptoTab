//
//  NetworkServiceHTTPMethod.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation


struct HTTPMethod {
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")
    static let delete = HTTPMethod(rawValue: "DELETE")
    
    let rawValue: String
}
