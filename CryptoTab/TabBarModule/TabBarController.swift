import UIKit


final class TabBarController: UITabBarController {
    
    private let homeCoordinator: HomeCoordinator
    private let marketCoordinator: MarketCoordinator

    init(homeCoordinator: HomeCoordinator, marketCoordinator: MarketCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.marketCoordinator = marketCoordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
}

// MARK: - TabBar Setup
extension TabBarController {
    private func setupTabBar() {
        tabBar.tintColor = AppColors.activeElements
        tabBar.backgroundColor = AppColors.mainBackgroundColor
        tabBar.barTintColor = AppColors.mainBackgroundColor
        tabBar.unselectedItemTintColor = AppColors.inactiveElements
        tabBar.isTranslucent = true
    }

    private func setupViewControllers() {
        homeCoordinator.start()
        marketCoordinator.start()

        // Настраиваем TabBarItem для каждого контроллера
        homeCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        marketCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Market",
            image: UIImage(systemName: "handbag"),
            selectedImage: UIImage(systemName: "handbag.fill")
        )

        viewControllers = [
            homeCoordinator.navigationController,
            marketCoordinator.navigationController
        ]
    }
}
