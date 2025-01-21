import UIKit


final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    

}

//MARK: - setupTabBar()
extension TabBarController {
    private func setupTabBar() {
        let floatingTabBar = FloatingTabBar()
               setValue(floatingTabBar, forKey: "tabBar")
        tabBar.tintColor = AppColors.activeElements
        tabBar.backgroundColor = AppColors.mainBackgroundColor
        tabBar.barTintColor = AppColors.mainBackgroundColor
        tabBar.unselectedItemTintColor = AppColors.inactiveElements
        tabBar.isTranslucent = true

        tabBar.itemPositioning = .automatic
    }
}
//MARK: - setupViewControllers()
extension TabBarController {
    private func setupViewControllers() {
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let secondViewController = MarketViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: "Market",
            image: UIImage(systemName: "handbag"),
            selectedImage: UIImage(systemName: "handbag.fill")
        )

        viewControllers = [firstViewController, secondViewController]
    }
}
