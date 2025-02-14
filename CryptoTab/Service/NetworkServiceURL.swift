import UIKit

struct API {
    static let getTrendingCoin = API(urlString: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false")
    
    static let getTrendingNFTs = API(urlString: "https://api.opensea.io/api/v2/collections?chain=ethereum&limit=100")
    static let NftApiKey = ""
    let urlString: String
    
    var url: URL? {
        return URL(string: urlString)
    }
}
