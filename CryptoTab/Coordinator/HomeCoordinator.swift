import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol
    private let detailCoordinator: DetailCoordinator  // 👈 Добавили DetailCoordinator
    private let detailNetworkViewModel: DetailNetworkViewModelProtocol

    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol, detailNetworkViewModel: DetailNetworkViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
        self.detailNetworkViewModel = detailNetworkViewModel
        self.detailCoordinator = DetailCoordinator(navigationController: navigationController, homeViewModel: homeViewModel, detailNetworkViewModel: detailNetworkViewModel) // 👈 Инициализация
    }

    func start() {
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        homeViewController.onItemSelected = { [weak self] item in
            self?.detailCoordinator.showDetail(for: item) // 👈 Используем DetailCoordinator
        }
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
