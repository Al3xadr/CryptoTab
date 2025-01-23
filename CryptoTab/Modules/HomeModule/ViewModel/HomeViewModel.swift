import UIKit

protocol HomeViewModelProtocol {
    func getNetwrokData()
}

final class HomeViewModel: HomeViewModelProtocol {
    private var networkService: NetworkServiceProtocol
    private let api = API.getTrendingCoin
    var coinModel: Welcome?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getNetwrokData() {
        guard let url = api.url else {return}
        
        networkService.fetchData(url: url, httpMethod: .get, body: nil, headers: [:]) { [weak self] (result: Result<Welcome, NetworkError>)  in
            switch result {
            case .success(let data):
                self?.coinModel = data
                print(data)
            case .failure(let failure):
                switch failure {
                case .badData:
                    print("badData")
                case .badResponse:
                    print("badResponse")
                case .badRequest:
                    print("badRequest")
                case .badDecode:
                    print("badDecode")
                case .badEncode:
                    print("badEncode")
                case .unknown(_):
                    print("unknown")
                }
            }
        }
    }
    
    
}
