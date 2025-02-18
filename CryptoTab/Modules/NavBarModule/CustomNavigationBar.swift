import UIKit

final class CustomNavigationBar: UINavigationBar {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector")// Укажите своё изображение
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30),

        ])
    }
}

extension CustomNavigationBar {
    func hideLogo(_ hidden: Bool) {
        logoImageView.isHidden = hidden
    }
}
