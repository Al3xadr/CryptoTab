import UIKit

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol
    private let tabBarController: TabBarController

    private let homeCoordinator: HomeCoordinator
    private let marketCoordinator: MarketCoordinator

    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
        let homeNavController = UINavigationController()
        let marketNavController = UINavigationController()

        self.homeCoordinator = HomeCoordinator(navigationController: homeNavController, homeViewModel: homeViewModel)
        self.marketCoordinator = MarketCoordinator(navigationController: marketNavController)

        self.tabBarController = TabBarController(
            homeCoordinator: homeCoordinator,
            marketCoordinator: marketCoordinator
        )
    }

    func start() {
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
