import UIKit

final class CoinHomeCell: UICollectionViewCell {
    static let cell = "CoinHomeCell"
    //MARK: - UI
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let priceChange24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let priceChangePercentage24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let topView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bottomView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(nameLabel)
        topView.addSubview(iconImageView)
        topView.addSubview(priceLabel)
        bottomView.addSubview(currentPriceLabel)
        bottomView.addSubview(priceChange24hLabel)
        bottomView.addSubview(priceChangePercentage24hLabel)
    }
    func setupConstraints() {
        //MARK: - top View
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5),
            iconImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5),
            priceLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
            
        ])
        //MARK: - botton View
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5)
            
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        NSLayoutConstraint.activate([
            currentPriceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -5),
            currentPriceLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            currentPriceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            priceChange24hLabel.trailingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            priceChange24hLabel.topAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: 5),
            priceChange24hLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        NSLayoutConstraint.activate([
            priceChangePercentage24hLabel.trailingAnchor.constraint(equalTo: priceChange24hLabel.leadingAnchor, constant: 5),
            priceChangePercentage24hLabel.topAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: 5),
            priceChangePercentage24hLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }
}

//MARK: - setting data
extension CoinHomeCell {
    func configure(with name: String, image: UIImage?, price: String, currentPrice: String, priceChange24h: String, priceChangePercentage24h: String) {
        nameLabel.text = name
        iconImageView.image = image
        priceLabel.text = price
        currentPriceLabel.text = currentPrice
        priceChange24hLabel.text = priceChange24h
        priceChangePercentage24hLabel.text = priceChangePercentage24h
    }}
