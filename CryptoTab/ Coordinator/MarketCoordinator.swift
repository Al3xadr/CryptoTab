import UIKit

final class MarketCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let marketViewController = MarketViewController()
        navigationController.pushViewController(marketViewController, animated: false)
    }
}

