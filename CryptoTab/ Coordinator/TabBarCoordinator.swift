import UIKit

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let tabBarController: TabBarController

    private let homeCoordinator: HomeCoordinator
    private let marketCoordinator: MarketCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        // Создаем дочерние координаторы
        let homeNavController = UINavigationController()
        let marketNavController = UINavigationController()

        self.homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        self.marketCoordinator = MarketCoordinator(navigationController: marketNavController)

        // Инициализируем TabBarController
        self.tabBarController = TabBarController(
            homeCoordinator: homeCoordinator,
            marketCoordinator: marketCoordinator
        )
    }

    func start() {
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
