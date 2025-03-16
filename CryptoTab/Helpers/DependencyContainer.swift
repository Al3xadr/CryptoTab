final class DependencyContainer {
    private let network: NetworkServiceProtocol
    private let homeViewModel: HomeViewModelProtocol
    private let detailNetworkViewModel: DetailNetworkViewModelProtocol
    private let marketViewModel: MarketViewModelProtocol

//MARK: - create getter
    var getHomeViewModel: HomeViewModelProtocol { homeViewModel }
    var getDetailNetworkViewModel: DetailNetworkViewModelProtocol { detailNetworkViewModel }
    var getMarketViewModel: MarketViewModelProtocol { marketViewModel }
    
//MARK: - create Controller
    var homeViewController: HomeViewController {
        HomeViewController(container: self)
    }

    var marketViewController: MarketViewController {
        MarketViewController(container: self)
    }

//MARK: - create coinDetailViewController
    func coinDetailViewController(coin: HomeCoinModel) -> CoinDetailViewController {
        let detailViewModel = DetailViewModel(coin: coin, nft: nil)
        let detailViewController = CoinDetailViewController(
            viewModel: detailViewModel,
            homeViewModel: homeViewModel,
            networkViewModel: detailNetworkViewModel as! DetailNetworkViewModel
        )
        detailViewController.configure(with: coin)
        return detailViewController
    }

//MARK: - create detailNftsViewController
    func detailNftsViewController(nft: HomeNFTsModel) -> DetailNftsViewController {
        let detailViewModel = DetailViewModel(coin: nil, nft: nft)
        let detailViewController = DetailNftsViewController(
            viewModel: detailViewModel,
            homeViewModel: homeViewModel
        )
        detailViewController.configure(with: nft)
        return detailViewController
    }

//MARK: - init()
    init() {
        self.network = NetworkService()
        self.homeViewModel = HomeViewModel(networkService: network)
        self.detailNetworkViewModel = DetailNetworkViewModel(networkService: network)
        self.marketViewModel = MarketViewModel(networkService: network)
    }
}
