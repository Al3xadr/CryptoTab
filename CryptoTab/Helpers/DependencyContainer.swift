final class DependencyContainer {
    let network: NetworkServiceProtocol
    let homeViewModel: HomeViewModelProtocol
    let detailNetworkViewModel: DetailNetworkViewModelProtocol
    
    init() {
        self.network = NetworkService()
        self.homeViewModel = HomeViewModel(networkService: network)
        self.detailNetworkViewModel = DetailNetworkViewModel(networkService: network)
    }
}
