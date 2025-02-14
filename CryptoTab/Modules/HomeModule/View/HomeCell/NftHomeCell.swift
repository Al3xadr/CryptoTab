import UIKit

final class NftHomeCell: UICollectionViewCell {
    private var viewModel: HomeViewModelProtocol?
    init(viewModel: HomeViewModelProtocol, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    static let cell = "NftHomeCell"
    //MARK: - UI
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.numberOfLines = 1
//        return label
//    }()
    
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
//    
//    private let currentPriceLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    private let priceChange24hLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.numberOfLines = 1
//        return label
//    }()
    
    private let topView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//    private let bottomView: UIView = {
//        let imageView = UIView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    

}

//MARK: - setup View Constraints
private extension NftHomeCell {
    func setupViews() {
        contentView.addSubview(topView)
        //contentView.addSubview(bottomView)
        //bottomView.addSubview(nameLabel)
        topView.addSubview(iconImageView)
        topView.addSubview(priceLabel)
        //bottomView.addSubview(currentPriceLabel)
       // bottomView.addSubview(priceChange24hLabel)
    }
    func setupConstraints() {
        //MARK: - top View
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
//        NSLayoutConstraint.activate([
//            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            bottomView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
//            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            
//        ])
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5),
            priceLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
            
        ])
        //MARK: - botton View
//        NSLayoutConstraint.activate([
//            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5)
//            
//        ])
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
//            nameLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
//            nameLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//        ])
        
//        NSLayoutConstraint.activate([
//            currentPriceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -5),
//            currentPriceLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
//            currentPriceLabel.heightAnchor.constraint(equalToConstant: 20),
//        ])
        
//        NSLayoutConstraint.activate([
//            priceChange24hLabel.trailingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
//            priceChange24hLabel.topAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: 5),
//            priceChange24hLabel.heightAnchor.constraint(equalToConstant: 20),
//        ])
//        
    }
}

//MARK: - setting data
extension NftHomeCell {
    func configure(with viewModel: HomeViewModelProtocol?, nftModel: HomeNFTsModel) {
        self.viewModel = viewModel
        priceLabel.text = nftModel.name
        if let imageUrlString = nftModel.imageURL, let imageUrl = URL(string: imageUrlString) {
            viewModel?.loadImage(from: imageUrl) { [weak self] image in
                self?.iconImageView.image = image
            }
        }
    }

}

