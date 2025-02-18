import UIKit
enum SortOption {
    case price
    case marketCap
    case priceChange
}
protocol MarketViewModelProtocol {
    var coinModels: [HomeCoinModel] { get }
    var filteredCoins: [HomeCoinModel] { get }
    var onDataUpdate: (() -> Void)? { get set }
    
    func fetchCoins()
    func searchCoins(query: String)
    func sortCoins(by option: SortOption)

}

final class MarketViewModel: MarketViewModelProtocol {
    var onDataUpdate: (() -> Void)?
    

    
    private let networkService: NetworkServiceProtocol
    private(set) var coinModels: [HomeCoinModel] = []
    var filteredCoins: [HomeCoinModel] = []
    
    private let apiCoins = API.getTrendingCoin
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCoins() {
        var coins: [CoinElement] = []
        guard let coinURL = apiCoins.url else { return }
        
        networkService.fetchData(url: coinURL,
                                 httpMethod: .get,
                                 body: nil,
                                 headers: nil,
                                 apiKey: nil) { [weak self] (result: Result<[CoinElement], NetworkError>) in
            switch result {
            case .success(let fetchedCoins):
                coins = fetchedCoins
                self?.filteredCoins = fetchedCoins.toHomeCoinModels()
                self?.coinModels = fetchedCoins.toHomeCoinModels()
                self?.onDataUpdate?()
            case .failure(let error):
                print("❌ Ошибка загрузки данных: \(error.localizedDescription)")
            }
        }
    }
    private func processData(_ coins: [CoinElement]) {
        self.coinModels = coins.toHomeCoinModels()
        onDataUpdate?()
    }
    
    func searchCoins(query: String) {
        if query.isEmpty {
            filteredCoins = coinModels
        } else {
            filteredCoins = coinModels.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
        onDataUpdate?()
    }

    
    func sortCoins(by option: SortOption) {
        switch option {
        case .price:
            filteredCoins.sort { $0.currentPrice > $1.currentPrice }
        case .marketCap:
            filteredCoins.sort { $0.marketCap > $1.marketCap }
        case .priceChange:
            filteredCoins.sort { $0.priceChangePercentage24h > $1.priceChangePercentage24h }
        }
        onDataUpdate?()
    }
}
