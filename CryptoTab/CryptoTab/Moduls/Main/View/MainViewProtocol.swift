//
//  MainViewProtocol.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import Foundation
protocol MainViewProtocol: AnyObject {
    func displayData(_ data: Welcome)
    func showError(error: NetworkError)
}
