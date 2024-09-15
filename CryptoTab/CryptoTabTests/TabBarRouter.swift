//
//  TabBarRouter.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import UIKit


final class TabBarRouter: TabBarRouterProtocol {
    func showFirstModule() {
        print("First Module Selected")
    }
    
    func showSecondModule() {
        print("Second Module Selected")
    }
    
    weak var viewController: UITabBarController?
    
    static func createModule() -> UITabBarController {
        let router: TabBarRouterProtocol = TabBarRouter()
        
        let presenter: TabBarPresenterProtocol  = TabBarPresenter(router: router)
        
        let tabBarView = TabBarViewController(presenter: presenter)
        
        
        tabBarView.presenter = presenter
        presenter.view = tabBarView
        presenter.router = router
        
        let firstModule = MainRouter.createModule(with: Welcome(coins: [], nfts: [], categories: []))

        tabBarView.viewControllers = [firstModule]
        
        return tabBarView
    }
    
}

