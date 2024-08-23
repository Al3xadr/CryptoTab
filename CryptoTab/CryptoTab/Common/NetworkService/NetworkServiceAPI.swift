//
//  NetworkServiceAPI.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation
//https://api.coingecko.com/api/v3/search/trending
enum API {
    private static let baseURl = "https://api.coingecko.com/api/v3"
    
    case getCoin

    private var endpoint: String {
        switch self {
        case .getCoin:
            return "/search/trending"
        }
    }
    var url: URL? {
        return URL(string: API.baseURl + endpoint)
    }
}

