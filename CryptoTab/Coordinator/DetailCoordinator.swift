import UIKit

final class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let container: DependencyContainer

    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let placeholderVC = UIViewController()
        placeholderVC.view.backgroundColor = .white
        placeholderVC.title = "Error"
        navigationController.pushViewController(placeholderVC, animated: false)
    }

    func showDetail(for item: HomeModel) {
        switch item {
        case .bestCoin(let coinModel), .coin(let coinModel):
            let detailViewController = container.coinDetailViewController(coin: coinModel)
            navigationController.pushViewController(detailViewController, animated: true)

        case .nft(let nftModel):
            let detailViewController = container.detailNftsViewController(nft: nftModel)
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
