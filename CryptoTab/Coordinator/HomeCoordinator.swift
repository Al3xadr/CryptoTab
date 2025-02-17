import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol
    private let detailCoordinator: DetailCoordinator  // 👈 Добавили DetailCoordinator

    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
        self.detailCoordinator = DetailCoordinator(navigationController: navigationController, homeViewModel: homeViewModel) // 👈 Инициализация
    }

    func start() {
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        homeViewController.onItemSelected = { [weak self] item in
            self?.detailCoordinator.showDetail(for: item) // 👈 Используем DetailCoordinator
        }
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
