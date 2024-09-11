//
//  MainRouterProtocol.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//

import UIKit

protocol MainRouterProtocol {
    static func createModule(with coinModel: Welcome) -> UIViewController
}
