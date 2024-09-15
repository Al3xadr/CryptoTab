//
//  NFTsRouter.swift
//  CryptoTab
//
//  Created by apple on 15.09.2024.
//

import UIKit

final class NFTsRouter: NFTsRouterProtocol {
    static func createModule() -> UIViewController {
        let interactor = NFTsInteractor()
        let presenter = NFTsPresenter()
        let view = NFTsViewController(presenter: presenter)
        let router = NFTsRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        
        let navController = UINavigationController(rootViewController: view)
        navController.tabBarItem =  UITabBarItem(title: "NFT", image: UIImage(systemName: "n.circle"), tag: 1)
        return navController
    }
    
    
}
