import UIKit

final class CoinDetailViewController: UIViewController {
    private var homeViewModel: HomeViewModelProtocol
    private let viewModel: DetailViewModel
    private let networkViewModel: DetailNetworkViewModel

    init(viewModel: DetailViewModel, homeViewModel: HomeViewModelProtocol, networkViewModel: DetailNetworkViewModel) {
        self.viewModel = viewModel
        self.homeViewModel = homeViewModel
        self.networkViewModel = networkViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 12
        return view
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private let highLowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
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

// MARK: - Конфигурация данных
extension CoinDetailViewController {
    func configure(with coin: HomeCoinModel) {
        nameLabel.text = coin.name

        if let imageUrlString = coin.image, let imageUrl = URL(string: imageUrlString) {
            homeViewModel.loadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            }
        }
        networkViewModel.fetchCoinDetails(with: coin.id) { [weak self] result in
            switch result {
            case .success(let coinData):
                DispatchQueue.main.async {
                    self?.updateUI(with: coinData.first)
                }
            case .failure(let error):
                print("Ошибка при получении данных о монете: \(error)")
            }
        }
    }

    private func updateUI(with coin: CoinElement?) {
        guard let coin = coin else { return }

        priceLabel.text = "💰 Цена: $\(String(format: "%.2f", coin.currentPrice))"
        marketCapLabel.text = "📈 Капитализация: $\(formatNumber(Double(coin.marketCap)))"
        volumeLabel.text = "📊 Объем 24ч: $\(formatNumber(coin.totalVolume))"
        priceChangeLabel.text = "📉 Изменение: \(String(format: "%.2f", coin.priceChangePercentage24H))%"
        highLowLabel.text = "🔼 MAX: $\(String(format: "%.2f", coin.high24H)) | 🔽 MIN: $\(String(format: "%.2f", coin.low24H))"
    }

    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

// MARK: - UI
private extension CoinDetailViewController {
    func setupViews() {
        view.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(marketCapLabel)
        view.addSubview(volumeLabel)
        view.addSubview(priceChangeLabel)
        view.addSubview(highLowLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            iconContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconContainerView.widthAnchor.constraint(equalToConstant: 220),
            iconContainerView.heightAnchor.constraint(equalToConstant: 220),


            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconContainerView.widthAnchor, constant: -20),
            iconImageView.heightAnchor.constraint(equalTo: iconContainerView.heightAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            marketCapLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            marketCapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            volumeLabel.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor, constant: 10),
            volumeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            priceChangeLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 10),
            priceChangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            highLowLabel.topAnchor.constraint(equalTo: priceChangeLabel.bottomAnchor, constant: 10),
            highLowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension CoinDetailViewController {
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
