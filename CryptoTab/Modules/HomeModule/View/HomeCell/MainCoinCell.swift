import UIKit
final class MainCoinCell: UICollectionViewCell {
    static let cell = "MainCoinCell"
    private var viewModel: HomeViewModelProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    private let cellShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8.0
        view.layer.cornerRadius = 12.0
        return view
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        return view
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemGray6.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let currentPrice: UILabel = createLabel(fontSize: 16, weight: .medium)
    private let priceСhange24h: UILabel = createLabel(fontSize: 16, weight: .medium)
    private let priceChangePercentage24h: UILabel = createLabel(fontSize: 16, weight: .medium)
    private let fullyDilutedValuation: UILabel = createLabel(fontSize: 16, weight: .medium)
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGradientLayer()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cellShadowView.layer.shadowPath = UIBezierPath(roundedRect: cellShadowView.bounds, cornerRadius: 12.0).cgPath
    }
    
}

private extension MainCoinCell {
    static func createLabel(fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }
    
    func createStackView(label: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.text = label
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }
    
    
    func setupGradientLayer() {
        gradientLayer.frame = bounds
        cellView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupViews() {
        contentView.addSubview(cellShadowView)
        cellShadowView.addSubview(cellView)
        
        cellView.addSubview(iconImageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(stackView)
        
        stackView.addArrangedSubview(createStackView(label: "Price:", valueLabel: currentPrice))
        stackView.addArrangedSubview(createStackView(label: "Market Cap:", valueLabel: fullyDilutedValuation))
        stackView.addArrangedSubview(createStackView(label: "Price Change 24h:", valueLabel: priceСhange24h))
        stackView.addArrangedSubview(createStackView(label: "Percent Change 24h:", valueLabel: priceChangePercentage24h))
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cellShadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            cellShadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            cellView.topAnchor.constraint(equalTo: cellShadowView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: cellShadowView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: cellShadowView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: cellShadowView.bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            iconImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: -15)
        ])
    }
}
extension MainCoinCell {
    func configure(with viewModel: HomeViewModelProtocol?, coinModel: HomeCoinModel) {
        self.viewModel = viewModel
        nameLabel.text = coinModel.name
        currentPrice.text = "\(coinModel.currentPrice)$"
        fullyDilutedValuation.text = "\(coinModel.fullyDilutedValuation)$"
        priceСhange24h.text = "\(coinModel.priceChange24h)$"
        priceChangePercentage24h.text = "\(coinModel.priceChangePercentage24h)%"
        
        if let priceChange = Double(coinModel.priceChangePercentage24h) {
            let isPositive = priceChange > 0
            priceChangePercentage24h.text = isPositive ? "+\(coinModel.priceChangePercentage24h)%" : "\(coinModel.priceChangePercentage24h)%"
            let color = isPositive ? AppColors.activeElements : AppColors.redElements
            priceChangePercentage24h.textColor = color
            currentPrice.textColor = color
            priceСhange24h.textColor = color
        }
        
        if let imageUrlString = coinModel.image, let imageUrl = URL(string: imageUrlString) {
            viewModel?.loadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            }
        }
    }
}
