//
//  PresenterProtocol.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func fetchDataFromNetwork()
    func dataFetched(_ data: Welcome)
    func didFailToFetchData(with error: NetworkError)
}
