//
//  SettingRouter.swift
//  CryptoTab
//
//  Created by apple on 15.09.2024.
//

import UIKit

final class SettingRouter: SettingRouterProtocol {
    static func createModule() -> UIViewController {
        let presenter = SettingPresenter()
        let interactor = SettingInteractor()
        let router = SettingRouter()
        let view = SettingViewController(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        
        let navController = UINavigationController(rootViewController: view)
        navController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape"), tag: 3)
        return navController
    }
    
    
}
