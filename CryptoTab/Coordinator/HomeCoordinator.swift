import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let container: DependencyContainer
    private let detailCoordinator: DetailCoordinator

    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
        self.detailCoordinator = DetailCoordinator(navigationController: navigationController, container: container)
    }

    func start() {
        let homeViewController = container.homeViewController
        homeViewController.onItemSelected = { [weak self] item in
            self?.detailCoordinator.showDetail(for: item)
        }
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
