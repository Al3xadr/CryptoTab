//
//  MainInteractor.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import UIKit


final class MainInteractor: MainInteractorProtocol {
    private let networkService: NetworkServiceProtocols
    weak var presenter: MainPresenterProtocol?
    var coinModel: Welcome
    
    private let api = API.getTrendingCoin
    
    init(networkService: NetworkServiceProtocols, coinModel: Welcome ) {
        self.networkService = networkService
        self.coinModel = coinModel
    }
    
    func fetchDataNetwork() {
        guard let url = api.url else {
            presenter?.didFailToFetchData(with: .badData)
            return
        }
        
        networkService.fetchData(url: url, httpMethod: .get, body: nil, headers: [:]) { [weak self] (result: Result<Welcome, NetworkError>) in
            switch result {
            case .success(let coinModel):
                print(coinModel)
                self?.presenter?.dataFetched(coinModel)
            case .failure(let error):
                self?.presenter?.didFailToFetchData(with: error)
            }
        }
    }
}

