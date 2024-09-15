//
//  PortfolioRouter.swift
//  CryptoTab
//
//  Created by apple on 15.09.2024.
//

import UIKit

final class PortfolioRouter: PortfolioRouterProtocol {
    static func createModule() -> UIViewController {
        let interactor = PortfolioInteractor()
        let presenter = PortfolioPresenter()
        let view = PortfolioViewController(presenter: presenter)
        let router = PortfolioRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        
        let navController = UINavigationController(rootViewController: view)
        navController.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "folder"), tag: 2)
        return navController
    }
    
    
}


