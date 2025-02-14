import  UIKit
struct NFTResponse: Codable {
    let collections: [NFTsElement]
    let next: String?
}

struct NFTsElement: Codable {
    let collection: String
    let name: String
    let description: String?
    let imageURL: String?
    let bannerImageURL: String?
    let owner: String
    let safelistStatus: String?
    let category: String?
    let isDisabled: Bool?
    let isNsfw: Bool?
    let traitOffersEnabled: Bool?
    let collectionOffersEnabled: Bool?
    let openseaURL: String?
    let projectURL: String?
    let wikiURL: String?
    let discordURL: String?
    let telegramURL: String?
    let twitterUsername: String?
    let instagramUsername: String?
    let contracts: [Contract]?
    
    enum CodingKeys: String, CodingKey {
        case collection, name, description
        case imageURL = "image_url"
        case bannerImageURL = "banner_image_url"
        case owner
        case safelistStatus = "safelist_status"
        case category
        case isDisabled = "is_disabled"
        case isNsfw = "is_nsfw"
        case traitOffersEnabled = "trait_offers_enabled"
        case collectionOffersEnabled = "collection_offers_enabled"
        case openseaURL = "opensea_url"
        case projectURL = "project_url"
        case wikiURL = "wiki_url"
        case discordURL = "discord_url"
        case telegramURL = "telegram_url"
        case twitterUsername = "twitter_username"
        case instagramUsername = "instagram_username"
        case contracts
    }
}

struct Contract: Codable {
    let address: String
    let chain: String
}

extension NFTsElement {
    func toHomeNFTsModel() -> HomeNFTsModel {
        return HomeNFTsModel(
            collection: collection,
            name: name,
            description: description,
            imageURL: imageURL,
            owner: owner,
            safelistStatus: safelistStatus,
            category: category,
            openseaURL: openseaURL,
            contracts: contracts?.map { HomeNFTsModel.Contract(address: $0.address, chain: $0.chain) }
        )
    }
}


