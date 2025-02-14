import UIKit

enum SectionModelCoin: Int, Hashable, CaseIterable {
    case bestCoin
    case coins
    case nfts
    
    var title: String {
        switch self {
        case .bestCoin:
            return "bestCoin"
        case .coins:
            return "coins"
        case .nfts:
            return "nfts"
        }
    }
}

enum HomeModel: Hashable {
    case bestCoin(HomeCoinModel)
    case coin(HomeCoinModel)
    case nft(HomeNFTsModel)
}
