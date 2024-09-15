//
//  TabBarPresenterProtocol.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import UIKit


protocol TabBarPresenterProtocol: AnyObject {
    var view: TabBarViewControllerProtocol? { get set }
    var router: TabBarRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectTab(at index: Int)
}
