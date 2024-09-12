//
//  NetworkServiceURL.swift
//  CryptoTab
//
//  Created by apple on 23.08.2024.
//

import Foundation

enum API {
    private static let baseURL = "https://api.coingecko.com/api/v3"

    case getTrendingCoin

    private var endpoint: String {
        switch self {
        case .getTrendingCoin:
            return "/search/trending"
        }
    }

    var url: URL? {
        return URL(string: API.baseURL + endpoint)
    }
}
