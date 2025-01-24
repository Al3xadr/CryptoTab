//
//  HomeCoinModel.swift
//  CryptoTab
//
//  Created by Alexandr on 23.01.2025.
//


import Foundation

struct HomeCoinModel: Hashable {
    let identifier: UUID = UUID()
    let id: String
    let name: String
    let image: URL
    let currentPrice: String
    let priceChange24h: String
    let priceChangePercentage24h: String
    let marketCapChangePercentage24h: String
}

struct HomeNFTModel: Hashable {
    let identifier: UUID = UUID()
    let id: String
    let name: String
    let image: URL
    let currentPrice: String
    let priceChange24h: String
    let priceChangePercentage24h: String
}

extension HomeCoinModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: HomeCoinModel, rhs: HomeCoinModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

extension HomeNFTModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: HomeNFTModel, rhs: HomeNFTModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
