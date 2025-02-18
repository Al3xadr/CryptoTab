import UIKit

protocol DetailNetworkViewModelProtocol {
    func fetchCoinDetails(with coinID: String, completion: @escaping (Result<[CoinElement], NetworkError>) -> Void)
}

final class DetailNetworkViewModel: DetailNetworkViewModelProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCoinDetails(with coinID: String, completion: @escaping (Result<[CoinElement], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(coinID)") else {
            completion(.failure(.badRequest))
            return
        }
        
        networkService.fetchData(url: url, httpMethod: .get, body: nil, headers: nil, apiKey: nil) { result in
            completion(result)
        }
    }
}
