
import UIKit

final class HomeDetailNftsViewController: UIViewController {
    private var homeViewModel: HomeViewModelProtocol?
    private let viewModel: DetailViewModel

    init(viewModel: DetailViewModel, homeViewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - UI
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.itemTitle
        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationControllerViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupNavigationControllerViewWillDisappear()
    }
}

extension HomeDetailNftsViewController {
    func configure(with nftModel: HomeNFTsModel) {
        nameLabel.text = nftModel.name
        if let imageUrlString = nftModel.imageURL, let imageUrl = URL(string: imageUrlString) {
            homeViewModel?.loadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            }
        }
    }
}
private extension HomeDetailNftsViewController {
    func setupViews() {
        view.addSubview(iconImageView)
        view.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 200),
            iconImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
}

private extension HomeDetailNftsViewController {
    func setupNavigationControllerViewWillAppear() {
        (navigationController?.navigationBar as? CustomNavigationBar)?.hideLogo(true)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    func setupNavigationControllerViewWillDisappear() {
        (navigationController?.navigationBar as? CustomNavigationBar)?.hideLogo(false)
    }
}

