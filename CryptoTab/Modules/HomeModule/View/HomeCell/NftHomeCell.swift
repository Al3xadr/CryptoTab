import UIKit

final class NftHomeCell: UICollectionViewCell {
    private var viewModel: HomeViewModelProtocol?
    static let cell = "NftHomeCell"

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - UI
    
    private let cellshadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor(.black).cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6.0
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        
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
    
    private let imageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        
        return view
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupConstraints()
    }
    

}

//MARK: - setup View Constraints
private extension NftHomeCell {
    func setupViews() {
        contentView.addSubview(cellshadowView)
        cellshadowView.addSubview(cellView)
        cellView.addSubview(imageView)
        imageView.addSubview(iconImageView)
        cellView.addSubview(nameLabel)

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
            cellView.bottomAnchor.constraint(equalTo: cellshadowView.bottomAnchor, constant: -10),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 4/5)
        ])

        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            iconImageView.topAnchor.constraint(equalTo: imageView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            
        ])
   
    }
}

//MARK: - setting data
extension NftHomeCell {
    func configure(with viewModel: HomeViewModelProtocol?, nftModel: HomeNFTsModel) {
        self.viewModel = viewModel
        nameLabel.text = nftModel.name
        iconImageView.image = UIImage(named: "placeholder")
        if let imageUrlString = nftModel.imageURL, let imageUrl = URL(string: imageUrlString) {
            viewModel?.loadImage(from: imageUrl) { [weak self] image in
                self?.iconImageView.image = image
            }
        }
    }

}

