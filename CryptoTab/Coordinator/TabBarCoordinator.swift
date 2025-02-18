import UIKit

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol
    private let detailNetworkViewModel: DetailNetworkViewModelProtocol
    private let marketViewModel: MarketViewModelProtocol
    private let tabBarController: TabBarController

    private let homeCoordinator: HomeCoordinator
    private let marketCoordinator: MarketCoordinator

    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol, detailNetworkViewModel: DetailNetworkViewModel, marketViewModel: MarketViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
        self.detailNetworkViewModel = detailNetworkViewModel
        self.marketViewModel = marketViewModel
        
        let homeNavController = UINavigationController()
        let marketNavController = UINavigationController()

        self.homeCoordinator = HomeCoordinator(navigationController: homeNavController, homeViewModel: homeViewModel, detailNetworkViewModel: detailNetworkViewModel)
        self.marketCoordinator = MarketCoordinator(navigationController: marketNavController, marketViewModel: marketViewModel)

        self.tabBarController = TabBarController(
            homeCoordinator: homeCoordinator,
            marketCoordinator: marketCoordinator
        )
    }

    func start() {
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
