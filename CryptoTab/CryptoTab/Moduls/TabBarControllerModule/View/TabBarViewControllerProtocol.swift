//
//  TabBarViewControllerProtocol.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import UIKit

protocol TabBarViewControllerProtocol: UITabBarController {
    var presenter: TabBarPresenterProtocol? { get set }
    func setupTabs()
    
}
