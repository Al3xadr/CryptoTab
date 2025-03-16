import UIKit

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let container: DependencyContainer
    private let tabBarController: TabBarController
    private let homeCoordinator: HomeCoordinator
    private let marketCoordinator: MarketCoordinator

    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
        
        let homeNavController = UINavigationController()
        let marketNavController = UINavigationController()

        self.homeCoordinator = HomeCoordinator(navigationController: homeNavController, container: container)
        self.marketCoordinator = MarketCoordinator(navigationController: marketNavController, container: container)

        self.tabBarController = TabBarController(
            homeCoordinator: homeCoordinator,
            marketCoordinator: marketCoordinator
        )
    }

    func start() {
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}

