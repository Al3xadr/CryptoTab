//
//  MainView.swift
//  CryptoTab
//
//  Created by apple on 11.09.2024.
//


import UIKit

final class MainView: UIViewController, MainViewProtocol {
    weak var presenter: MainPresenterProtocol?
    var interactor: MainInteractor?
    
    init(presenter: MainPresenterProtocol, interactor: MainInteractor) {
        self.presenter = presenter
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //presenter?.fetchDataFromNetwork()
        //interactor?.fetchDataNetwork()
    }
    
    func displayData(_ data: Welcome) {
        
    }
    
    func showError(error: NetworkError) {
        
    }
}
