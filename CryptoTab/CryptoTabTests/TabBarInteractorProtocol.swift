//
//  TabBarInteractorProtocol.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//

import Foundation

protocol TabBarInteractorInputProtocol: AnyObject {
    var presenter: TabBarInteractorOutputProtocol? { get set }
    
}
protocol TabBarInteractorOutputProtocol: AnyObject {}
