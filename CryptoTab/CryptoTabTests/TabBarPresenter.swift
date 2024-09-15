//
//  TabBarPresenter.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import UIKit

final class TabBarPresenter: TabBarPresenterProtocol {

    
    var view: TabBarViewControllerProtocol?
    var router: TabBarRouterProtocol?

    init(router: TabBarRouterProtocol) {
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectTab(at index: Int) {
        switch index {
        case 0:
            router?.showFirstModule()
        case 1:
            router?.showSecondModule()
        default:
            break
        }
    }
    
}


