//
//  MainRouter.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import UIKit

final class MainRouter: MainRouterProtocol {
    static func createModule(with coinModel: Welcome) -> UIViewController {
        
        // Создание компонентов
        let networkService = NetworkService()
        let interactor = MainInteractor(networkService: networkService, coinModel: coinModel)
        let presenter = MainPresenter()
        let router = MainRouter()
        
        // Создание MainView без передачи данных
        let viewController = MainView(presenter: presenter, interactor: interactor)
        
        
        
        // Установка зависимостей
        interactor.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
        
        let navController = UINavigationController(rootViewController: viewController)
             navController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        return navController
    }
}

