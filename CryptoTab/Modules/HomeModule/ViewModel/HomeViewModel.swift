import UIKit

protocol HomeViewModelProtocol {
    var onDataUpdate: (() -> Void)? { get set } // Callback для уведомления об обновлении данных
    var coinModels: [HomeCoinModel] { get }    // Преобразованные данные о монетах
    var nftModels: [HomeNFTModel] { get }      // Преобразованные данные о NFT
    func getNetwrokData()
}

final class HomeViewModel: HomeViewModelProtocol {
    private var networkService: NetworkServiceProtocol
    private let api = API.getTrendingCoin
    
    // Хранилища данных
    private(set) var coinModels: [HomeCoinModel] = []
    private(set) var nftModels: [HomeNFTModel] = []
    
    // Callback для уведомления о новых данных
    var onDataUpdate: (() -> Void)?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getNetwrokData() {
        guard let url = api.url else { return }
        
        networkService.fetchData(url: url, httpMethod: .get, body: nil, headers: [:]) { [weak self] (result: Result<Welcome, NetworkError>) in
            switch result {
            case .success(let data):
                self?.processData(data)
            case .failure(let failure):
                self?.handleError(failure)
            }
        }
    }
    
    private func processData(_ data: Welcome) {
        // Преобразование данных
        self.coinModels = data.toHomeCoinModels()
        self.nftModels = data.toHomeNFTModels()
        
        // Уведомление об обновлении данных
        DispatchQueue.main.async { [weak self] in
            self?.onDataUpdate?()
        }
    }
    
    private func handleError(_ error: NetworkError) {
        // Обработка ошибок (например, логирование)
        print("Error occurred: \(error)")
    }
}
