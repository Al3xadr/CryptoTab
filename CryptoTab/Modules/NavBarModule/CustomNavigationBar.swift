import UIKit

final class CustomNavigationBar: UINavigationBar {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector")// Укажите своё изображение
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = AppColors.activeElements
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBar()
    }
    
}
private extension CustomNavigationBar {
    func setupBar() {
        isTranslucent = false
        addSubview(logoImageView)
        addSubview(searchButton)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30),

            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension CustomNavigationBar {
    func setSearchAction(target: Any, action: Selector) {
        searchButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
