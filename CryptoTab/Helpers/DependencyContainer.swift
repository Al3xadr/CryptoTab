final class DependencyContainer {
    let network: NetworkServiceProtocol
    let homeViewModel: HomeViewModelProtocol
    let detailNetworkViewModel: DetailNetworkViewModelProtocol
    let marketViewModel: MarketViewModelProtocol
    
    init() {
        self.network = NetworkService()
        self.homeViewModel = HomeViewModel(networkService: network)
        self.detailNetworkViewModel = DetailNetworkViewModel(networkService: network)
        self.marketViewModel = MarketViewModel(networkService: network)
    }
}
