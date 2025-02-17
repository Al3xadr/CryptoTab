import UIKit

final class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeViewModel: HomeViewModelProtocol

    init(navigationController: UINavigationController, homeViewModel: HomeViewModelProtocol) {
        self.navigationController = navigationController
        self.homeViewModel = homeViewModel
    }
    func start() {
        let placeholderVC = UIViewController()
        placeholderVC.view.backgroundColor = .white
        placeholderVC.title = " Eror "
        navigationController.pushViewController(placeholderVC, animated: false)
    }
    
    func showDetail(for item: HomeModel) {
        switch item {
        case .bestCoin(let coinModel), .coin(let coinModel):
            let detailViewModel = DetailViewModel(coin: coinModel, nft: nil)
            let detailViewController = HomeDetailViewController(viewModel: detailViewModel, homeViewModel: homeViewModel)
            detailViewController.configure(with: coinModel)
            navigationController.pushViewController(detailViewController, animated: true)

        case .nft(let nftModel):
            let detailViewModel = DetailViewModel(coin: nil, nft: nftModel)
            let detailViewController = HomeDetailNftsViewController(viewModel: detailViewModel, homeViewModel: homeViewModel)
            detailViewController.configure(with: nftModel)
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
