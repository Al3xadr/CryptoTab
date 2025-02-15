import UIKit

final class CoinHomeCell: UICollectionViewCell {
    static let cell = "CoinHomeCell"
    
    private var viewModel: HomeViewModelProtocol?
   
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
    
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private let symbolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.textAlignment = .left
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
    

    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
  

    private let priceChangePercentage24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//MARK: - setup View Constraints
private extension CoinHomeCell {
    func setupViews() {
        contentView.addSubview(cellshadowView)
        cellshadowView.addSubview(cellView)
        cellView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(symbolNameLabel)
        horizontalStackView.addArrangedSubview(priceChangePercentage24hLabel)

        cellView.addSubview(nameLabel)
        cellView.addSubview(iconImageView)
        cellView.addSubview(currentPriceLabel)
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
            iconImageView.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 5),
            iconImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
            
        ])

        NSLayoutConstraint.activate([
            currentPriceLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            currentPriceLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5),
            currentPriceLabel.trailingAnchor.constraint(lessThanOrEqualTo: iconImageView.leadingAnchor, constant: -5),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            horizontalStackView.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(lessThanOrEqualTo: cellView.trailingAnchor, constant: -10),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        

        
    }
}

//MARK: - setting data
extension CoinHomeCell {
    func configure(with viewModel: HomeViewModelProtocol?, coinModel: HomeCoinModel) {
        self.viewModel = viewModel
        nameLabel.text = coinModel.name
        currentPriceLabel.text = coinModel.currentPrice + "$"
        symbolNameLabel.text = coinModel.symbol.uppercased() + "/USD"
        
        if let priceChange = Double(coinModel.priceChangePercentage24h) {
            let formattedChange = priceChange > 0 ? "+\(coinModel.priceChangePercentage24h)%" : "\(coinModel.priceChangePercentage24h)%"
            priceChangePercentage24hLabel.text = formattedChange
            
            if priceChange < 0 {
                priceChangePercentage24hLabel.textColor = AppColors.redElements
                currentPriceLabel.textColor = AppColors.redElements
            } else {
                priceChangePercentage24hLabel.textColor = AppColors.activeElements
                currentPriceLabel.textColor = AppColors.activeElements
            }
        } else {
            priceChangePercentage24hLabel.text = coinModel.priceChangePercentage24h + "%"
        }

        symbolNameLabel.textColor = .black
        nameLabel.textColor = .black

        if let imageUrlString = coinModel.image, let imageUrl = URL(string: imageUrlString) {
            viewModel?.loadImage(from: imageUrl) { [weak self] image in
                self?.iconImageView.image = image
            }
        }
    }
}

