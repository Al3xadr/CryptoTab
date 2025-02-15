//
//  HomeCoinModel.swift
//  CryptoTab
//
//  Created by Alexandr on 23.01.2025.
//


import Foundation

struct HomeCoinModel: Hashable {
    let identifier: UUID = UUID()
    let symbol: String
    let name: String
    let image: String?
    let marketCap: String
    let fullyDilutedValuation: String
    let currentPrice: String
    let priceChange24h: String
    let priceChangePercentage24h: String
    let marketCapChangePercentage24h: String
}



extension HomeCoinModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: HomeCoinModel, rhs: HomeCoinModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
