import UIKit

protocol HomeViewModelProtocol {
    var onDataUpdate: (() -> Void)? { get set }
    var coinModels: [HomeCoinModel] { get }
    var nftModels: [NFTsElement] { get }
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func getNetworkData()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private var networkService: NetworkServiceProtocol
    private let apiCoins = API.getTrendingCoin
    private let apiNFTs = API.getTrendingNFTs
    private let nftApiKey = API.NftApiKey
    
    private(set) var coinModels: [HomeCoinModel] = []
    private(set) var nftModels: [NFTsElement] = []
    
    // Кэш изображений
    private var imageCache = NSCache<NSURL, UIImage>()
    var onDataUpdate: (() -> Void)?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getNetworkData() {
        guard let coinURL = apiCoins.url, let nftURL = apiNFTs.url else { return }
        
        let dispatchGroup = DispatchGroup()
        var coins: [CoinElement] = []
        var nfts: [NFTsElement] = []
        
        dispatchGroup.enter()
        networkService.fetchData(url: coinURL, httpMethod: .get, body: nil, headers: ["accept": "application/json"], apiKey: nil) { [weak self] (result: Result<[CoinElement], NetworkError>) in
            switch result {
            case .success(let fetchedCoins):
                coins = fetchedCoins
            case .failure(let error):
                self?.handleError(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkService.fetchData(url: nftURL, httpMethod: .get, body: nil, headers: ["accept": "application/json"], apiKey: nftApiKey) { [weak self] (result: Result<NFTResponse, NetworkError>) in
            switch result {
            case .success(let fetchedNFTResponse):
                nfts = fetchedNFTResponse.collections
            case .failure(let error):
                self?.handleError(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.processData(coins, nfts)
        }
    }
    
    private func processData(_ coinData: [CoinElement], _ nftCollections: [NFTsElement]) {
        self.coinModels = coinData.toHomeCoinModels()
        self.nftModels = nftCollections
        onDataUpdate?()
    }
    
    private func handleError(_ error: NetworkError) {
        print("Error occurred: \(error)")
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            self.imageCache.setObject(image, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
