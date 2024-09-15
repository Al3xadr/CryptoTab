//
//  PortfolioViewController.swift
//  CryptoTab
//
//  Created by apple on 15.09.2024.
//

import UIKit

final class PortfolioViewController: UIViewController, PortfolioViewControllerProtocol {
    var presenter: PortfolioPresenterProtocol
    
    init(presenter: PortfolioPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
}
