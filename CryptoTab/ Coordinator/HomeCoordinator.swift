import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeViewController = HomeViewController()
        print("HomeViewController")
        navigationController.pushViewController(homeViewController, animated: false)
        }
    }


