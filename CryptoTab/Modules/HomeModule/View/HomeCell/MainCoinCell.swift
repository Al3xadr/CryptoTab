import UIKit

final class MainCoinCell: UICollectionViewCell {
    static let cell = "MainCoinCell"
    
    private var viewModel: HomeViewModelProtocol?
    init(viewModel: HomeViewModelProtocol, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
}
private extension MainCoinCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
    }
    
    func setupConstraints() {
        //MARK: - top View
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //iconImageView.widthAnchor.constraint(equalToConstant: 100),
            //iconImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5)
        ])
    }
}

extension MainCoinCell {
    func configure(with viewModel: HomeViewModelProtocol?, imageUrl: URL?, name: String) {
        self.viewModel = viewModel
        //nameLabel.text = name
        nameLabel.text = name
        //currentPriceLabel.text = currentPrice
        //priceChange24hLabel.text = priceChange24h
        
        if let url = imageUrl {
            viewModel?.loadImage(from: url) { [weak self] image in
                self?.iconImageView.image = image
            }
        } else {
            iconImageView.image = nil
        }
    }
}
