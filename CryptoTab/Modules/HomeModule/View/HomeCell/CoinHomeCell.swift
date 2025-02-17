import UIKit

final class CoinHomeCell: UICollectionViewCell {
    static let cell = "CoinHomeCell"
    
    private var viewModel: HomeViewModelProtocol?
   
    //MARK: - UI Elements
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
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let symbolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let priceChangePercentage24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellShadowView.layer.shadowPath = UIBezierPath(roundedRect: cellShadowView.bounds, cornerRadius: 12.0).cgPath
    }


    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI Setup
private extension CoinHomeCell {
    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        cellView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupViews() {
        contentView.addSubview(cellShadowView)
        cellShadowView.addSubview(cellView)
        cellView.layer.insertSublayer(gradientLayer, at: 0)
        
        cellView.addSubview(iconImageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(symbolNameLabel)
        cellView.addSubview(currentPriceLabel)
        cellView.addSubview(priceChangePercentage24hLabel)
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
            
            iconImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            symbolNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            symbolNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            symbolNameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            currentPriceLabel.topAnchor.constraint(equalTo: symbolNameLabel.bottomAnchor, constant: 10),
            currentPriceLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            currentPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            priceChangePercentage24hLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 5),
            priceChangePercentage24hLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            priceChangePercentage24hLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            priceChangePercentage24hLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
        ])
    }

}

//MARK: - Data Configuration
extension CoinHomeCell {
    func configure(with viewModel: HomeViewModelProtocol?, coinModel: HomeCoinModel) {
        self.viewModel = viewModel
        nameLabel.text = coinModel.name
        symbolNameLabel.text = coinModel.symbol.uppercased() + "/USD"
        currentPriceLabel.text = "\(coinModel.currentPrice)$"
        
        if let priceChange = Double(coinModel.priceChangePercentage24h) {
            let isPositive = priceChange > 0
            priceChangePercentage24hLabel.text = isPositive ? "+\(coinModel.priceChangePercentage24h)%" : "\(coinModel.priceChangePercentage24h)%"
            let color = isPositive ? UIColor.systemGreen : UIColor.systemRed
            priceChangePercentage24hLabel.textColor = color
            currentPriceLabel.textColor = color
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
