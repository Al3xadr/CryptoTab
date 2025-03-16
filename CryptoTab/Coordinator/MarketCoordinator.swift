import UIKit

final class MarketCoordinator: Coordinator {
    var navigationController: UINavigationController
    let container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let marketViewController = container.marketViewController
        navigationController.pushViewController(marketViewController, animated: false)
    }
}

