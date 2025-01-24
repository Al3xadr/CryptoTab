import UIKit
final class HomeViewController: UIViewController {
    // MARK: - ViewModel init()
    private let homeViewModel: HomeViewModelProtocol?
    
    init(homeViewModel: HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var dataSource: DataSource = setupDataSource()
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<SectionModelCoin, HomeModel>
    fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionModelCoin, HomeModel>
    
    // MARK: - UI Elements
    private let NewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.activeElements
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout() // Placeholder layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupCollectionView()
        applyInitialSnapshot()
    }
}

// MARK: - Setup Methods
private extension HomeViewController {
    func addSubviews() {
        view.addSubview(NewsView)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            NewsView.topAnchor.constraint(equalTo: view.topAnchor),
            NewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NewsView.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: NewsView.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return self.createSectionLayout(for: sectionIndex)
        }
        collectionView.collectionViewLayout = layout
    }
    
}
//MARK: - DataSource applyInitialSnapshot()
private extension HomeViewController {
    
    func setupDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            switch item {
            case .coin(let coinModel):
                cell.contentView.backgroundColor = .blue // Configure your cell for a coin
                // Add your cell configuration logic using coinModel
            case .nft(let nftModel):
                cell.contentView.backgroundColor = .green // Configure your cell for an NFT
                // Add your cell configuration logic using nftModel
            }
            return cell
        }
        return dataSource
    }
    
    func createSectionLayout(for sectionIndex: Int) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func applyInitialSnapshot() {
        var snapshot = DataSourceSnapshot()

        // Add sections
        snapshot.appendSections([.coins, .nfts])

        // Add items to sections
        let coinModels = [HomeCoinModel(id: "1", name: "Bitcoin", image: URL(string: "https://example.com")!, currentPrice: "30,000", priceChange24h: "500", priceChangePercentage24h: "1.5%", marketCapChangePercentage24h: "2.0%")]
        let nftModels = [HomeNFTModel(id: "1", name: "Cool NFT", image: URL(string: "https://example.com")!, currentPrice: "0.5 ETH", priceChange24h: "0.1", priceChangePercentage24h: "20%")]

        let coinItems = coinModels.map { HomeModel.coin($0) }
        let nftItems = nftModels.map { HomeModel.nft($0) }

        snapshot.appendItems(coinItems, toSection: .coins)
        snapshot.appendItems(nftItems, toSection: .nfts)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
