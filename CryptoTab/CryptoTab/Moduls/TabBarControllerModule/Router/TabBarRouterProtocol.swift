//
//  TabBarRouterProtocol.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import UIKit


protocol TabBarRouterProtocol: AnyObject {
    static func createModule() -> UITabBarController
    func showFirstModule()
    func showSecondModule()
}
