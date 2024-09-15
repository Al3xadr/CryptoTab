//
//  TabBarViewController.swift
//  CryptoTab
//
//  Created by apple on 14.09.2024.
//


import UIKit

final class TabBarViewController: UITabBarController, TabBarViewControllerProtocol {
    weak var presenter: TabBarPresenterProtocol?
    
    init(presenter: TabBarPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabBarViewController viewDidLoad called")
        setupTabs()
        presenter?.viewDidLoad()
    }
    func setupTabs() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = true

          // Кастомизация высоты таббара
        tabBar.itemPositioning = .automatic
    }

    // Обработка выбора таба
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter?.didSelectTab(at: item.tag)
    }
}
