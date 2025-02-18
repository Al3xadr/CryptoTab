import UIKit

final class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .green
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceChangeLabel)
        contentView.addSubview(marketCapLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
        
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            priceLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            priceChangeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            priceChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            marketCapLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            marketCapLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }


    
    func configure(with coin: HomeCoinModel) {
        nameLabel.text = coin.name
        priceLabel.text = "💰 \(coin.currentPrice)$"

        let priceChange = Double(coin.priceChangePercentage24h) ?? 0
        if priceChange > 0 {
            priceChangeLabel.text = "+\(coin.priceChangePercentage24h)%"
            priceChangeLabel.textColor = .green
        } else if priceChange < 0 {
            priceChangeLabel.text = "\(coin.priceChangePercentage24h)%"
            priceChangeLabel.textColor = .red
        } else {
            priceChangeLabel.text = "\(coin.priceChangePercentage24h)%"
            priceChangeLabel.textColor = .gray
        }
        marketCapLabel.text = "📈 Market Cap: \(coin.marketCap)"
        
        if let imageUrl = coin.image, let url = URL(string: imageUrl) {
            loadImage(from: url)
        } else {
            iconImageView.image = UIImage(systemName: "questionmark.circle.fill")
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.iconImageView.image = image
            }
        }.resume()
    }
}
