import UIKit

final class MainCoinCell: UICollectionViewCell {
    static let cell = "MainCoinCell"
    
    private var viewModel: HomeViewModelProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI
    private let cellshadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor(.black).cgColor
        view.layer.shadowOpacity = 0.2 // Прозрачность тени (от 0 до 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (ширина и высота)
        view.layer.shadowRadius = 6.0 // Размытие тени (радиус)
        view.layer.cornerRadius = 8.0 // Радиус скругления углов
        view.clipsToBounds = true // Обрезаем содержимое, выходящее за пределы границ
        
        return view
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        
        return view
    }()
    
    let leftContainerView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let rightContainerView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let currentPriceStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    
    private let currentPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Price: "
        return label
    }()
    

    private let priceСhange24hStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    private let priceСhange24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Price change 24h:"
        return label
    }()
    private let priceСhange24h: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let priceChangePercentage24hStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let priceChangePercentage24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Price change per. 24h: "
        return label
    }()
    
    private let priceChangePercentage24h: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let marketCapitalizationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let fullyDilutedValuation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let MarketCapitalizationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Market Cap:"
        return label
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
}
private extension MainCoinCell {
    func setupViews() {
        contentView.addSubview(cellshadowView)
        cellshadowView.addSubview(cellView)
        cellView.addSubview(leftContainerView)
        cellView.addSubview(rightContainerView)
        leftContainerView.addSubview(nameLabel)
        leftContainerView.addSubview(iconImageView)
        
        rightContainerView.addSubview(currentPriceStackView)
        currentPriceStackView.addArrangedSubview(currentPriceLabel)
        currentPriceStackView.addArrangedSubview(currentPrice)
        
        rightContainerView.addSubview(marketCapitalizationStackView)
        marketCapitalizationStackView.addArrangedSubview(MarketCapitalizationLabel)
        marketCapitalizationStackView.addArrangedSubview(fullyDilutedValuation)
        
        rightContainerView.addSubview(priceСhange24hStackView)
        priceСhange24hStackView.addArrangedSubview(priceСhange24hLabel)
        priceСhange24hStackView.addArrangedSubview(priceСhange24h)
        
        rightContainerView.addSubview(priceChangePercentage24hStackView)
        priceChangePercentage24hStackView.addArrangedSubview(priceChangePercentage24hLabel)
        priceChangePercentage24hStackView.addArrangedSubview(priceChangePercentage24h)
        
    }
    
    func setupConstraints() {
        //MARK: - top View
        NSLayoutConstraint.activate([
            cellshadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellshadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellshadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellshadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cellView.leadingAnchor.constraint(equalTo: cellshadowView.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: cellshadowView.trailingAnchor, constant: -10),
            cellView.topAnchor.constraint(equalTo: cellshadowView.topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: cellshadowView.bottomAnchor, constant: -10)
            
        ])
        NSLayoutConstraint.activate([
            leftContainerView.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 1/3),
            leftContainerView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            leftContainerView.topAnchor.constraint(greaterThanOrEqualTo: cellView.topAnchor),
            leftContainerView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor),

            rightContainerView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            rightContainerView.leadingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            rightContainerView.topAnchor.constraint(greaterThanOrEqualTo: cellView.topAnchor),
            rightContainerView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: leftContainerView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            currentPriceStackView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: 10),
            currentPriceStackView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -10),
            currentPriceStackView.topAnchor.constraint(equalTo: rightContainerView.topAnchor, constant: 15),
            currentPriceStackView.heightAnchor.constraint(equalToConstant: 25),
            
            marketCapitalizationStackView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: 10),
            marketCapitalizationStackView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -10),
            marketCapitalizationStackView.topAnchor.constraint(equalTo: currentPriceStackView.bottomAnchor, constant: 15),
            marketCapitalizationStackView.heightAnchor.constraint(equalToConstant: 25),
            
            priceСhange24hStackView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: 10),
            priceСhange24hStackView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -10),
            priceСhange24hStackView.topAnchor.constraint(equalTo: marketCapitalizationStackView.bottomAnchor, constant: 15),
            priceСhange24hStackView.heightAnchor.constraint(equalToConstant: 25),
            
            priceChangePercentage24hStackView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: 10),
            priceChangePercentage24hStackView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -10),
            priceChangePercentage24hStackView.topAnchor.constraint(equalTo: priceСhange24hStackView.bottomAnchor, constant: 15),
            priceChangePercentage24hStackView.heightAnchor.constraint(equalToConstant: 25),

            
        ])
    }
}

extension MainCoinCell {
    func configure(with viewModel: HomeViewModelProtocol?, coinModel: HomeCoinModel) {
        self.viewModel = viewModel
        nameLabel.text = coinModel.name
        currentPrice.text = coinModel.currentPrice + "$"
        fullyDilutedValuation.text = coinModel.fullyDilutedValuation + "$"
        
        priceСhange24h.text = coinModel.priceChange24h + "$"
        priceChangePercentage24h.text = coinModel.priceChangePercentage24h + "%"
        
        if let priceChange = Double(coinModel.priceChangePercentage24h) {
            let formattedChange = priceChange > 0 ? "+\(coinModel.priceChangePercentage24h)%" : "\(coinModel.priceChangePercentage24h)%"
            priceChangePercentage24h.text = formattedChange
            if priceChange < 0 {
                priceChangePercentage24h.textColor = AppColors.redElements
                currentPrice.textColor = AppColors.redElements
                priceСhange24h.textColor = AppColors.redElements
            } else {
                priceChangePercentage24h.textColor = AppColors.activeElements
                currentPrice.textColor = AppColors.activeElements
                priceСhange24h.textColor = AppColors.activeElements
            }
        }
        
        if let imageUrlString = coinModel.image, let imageUrl = URL(string: imageUrlString) {
            viewModel?.loadImage(from: imageUrl) { [weak self] image in
                self?.iconImageView.image = image
            }
        }
    }
}
