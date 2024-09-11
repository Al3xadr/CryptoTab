//
//  MainPresenter.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import UIKit

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouter?
    
    func fetchDataFromNetwork() {
        interactor?.fetchDataNetwork()
    }
    
    func dataFetched(_ data: Welcome) {
        print(data)
        view?.displayData(data)
    }
    
    func didFailToFetchData(with error: NetworkError) {
        view?.showError(error: error)
    }
}
