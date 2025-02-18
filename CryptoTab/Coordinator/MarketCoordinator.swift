import UIKit

final class MarketCoordinator: Coordinator {
    var navigationController: UINavigationController
    let marketViewModel: MarketViewModelProtocol
    init(navigationController: UINavigationController, marketViewModel: MarketViewModelProtocol) {
        self.navigationController = navigationController
        self.marketViewModel = marketViewModel
    }

    func start() {
        let marketViewController = MarketViewController(viewModel: marketViewModel)
        navigationController.pushViewController(marketViewController, animated: false)
    }
}

