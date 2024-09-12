//
//  CoinModel.swift
//  CryptoTab
//
//  Created by apple on 22.08.2024.
//

import Foundation
// MARK: - Welcome
//api https://api.coingecko.com/api/v3/search/trending
struct Welcome: Codable {
    let coins: [Coin]
    let nfts: [Nft]
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let marketCap1HChange: Double
    let slug: String
    let coinsCount: Int
    let data: CategoryData

    enum CodingKeys: String, CodingKey {
        case id, name
        case marketCap1HChange = "market_cap_1h_change"
        case slug
        case coinsCount = "coins_count"
        case data
    }
}

// MARK: - CategoryData
struct CategoryData: Codable {
    let marketCap: Double
    let marketCapBtc: Double
    let totalVolume: Double
    let totalVolumeBtc: Double
    let marketCapChangePercentage24H: [String: Double]
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case sparkline
    }
}

// MARK: - Coin
struct Coin: Codable {
    let item: Item
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let coinID: Int
    let name: String
    let symbol: String
    let marketCapRank: Int
    let thumb: String
    let small: String
    let large: String
    let slug: String
    let priceBtc: Double
    let score: Int
    let data: ItemData

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, small, large, slug
        case priceBtc = "price_btc"
        case score, data
    }
}

// MARK: - ItemData
struct ItemData: Codable {
    let price: Double
    let priceBtc: String
    let priceChangePercentage24H: [String: Double]
    let marketCap: String
    let marketCapBtc: String
    let totalVolume: String
    let totalVolumeBtc: String
    let sparkline: String
    let content: Content?

    enum CodingKeys: String, CodingKey {
        case price
        case priceBtc = "price_btc"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case sparkline, content
    }
}

// MARK: - Content
struct Content: Codable {
    let title, description: String
}

// MARK: - Nft
struct Nft: Codable {
    let id, name, symbol: String
    let thumb: String
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency: Double
    let floorPrice24HPercentageChange: Double
    let data: NftData

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

// MARK: - NftData
struct NftData: Codable {
    let floorPrice: String
    let floorPriceInUsd24HPercentageChange: String
    let h24Volume: String
    let h24AverageSalePrice: String
    let sparkline: String
    let content: String?

    init(floorPrice: String, floorPriceInUsd24HPercentageChange: String, h24Volume: String, h24AverageSalePrice: String, sparkline: String, content: String) {
        self.floorPrice = floorPrice
        self.floorPriceInUsd24HPercentageChange = floorPriceInUsd24HPercentageChange
        self.h24Volume = h24Volume
        self.h24AverageSalePrice = h24AverageSalePrice
        self.sparkline = sparkline
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
        case sparkline, content
    }
}
