import UIKit

enum SectionModelCoin: Hashable {
    case coins
    case nfts
}

enum HomeModel: Hashable {
    case coin(HomeCoinModel)
    case nft(HomeNFTModel)
}
