import UIKit

final class DetailViewModel {
    let coin: HomeCoinModel?
    let nft: HomeNFTsModel?

    init(coin: HomeCoinModel?, nft: HomeNFTsModel?) {
        self.coin = coin
        self.nft = nft
    }

    var itemTitle: String {
        if let coin = coin {
            return "Coin: \(coin.name)"
        } else if let nft = nft {
            return "NFT: \(nft.name)"
        } else {
            return "Детали"
        }
    }
}
