final class DependencyContainer {
    let network: NetworkServiceProtocol
    let homeViewModel: HomeViewModelProtocol
    
    init() {
        self.network = NetworkService()
        self.homeViewModel = HomeViewModel(networkService: network)
    }
}
