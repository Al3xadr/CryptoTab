import UIKit

final class CustomNavigationController: UINavigationController {

    private let customNavigationBar = CustomNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
}
private extension CustomNavigationController {
    func setupNavigationBarAppearance() {
        setValue(customNavigationBar, forKey: "navigationBar")
        view.backgroundColor = AppColors.mainBackgroundColor
    }
}

