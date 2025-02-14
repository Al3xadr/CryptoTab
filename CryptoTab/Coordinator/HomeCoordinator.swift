import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol
    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
    }

    func start() {
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
