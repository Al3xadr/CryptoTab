import UIKit
final class HomeViewController: UIViewController {
    // MARK: - ViewModel init()
    private var homeViewModel: HomeViewModelProtocol?
    private var sections = SectionModelCoin.allCases
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
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCoinCell.self, forCellWithReuseIdentifier: MainCoinCell.cell)
        collectionView.register(CoinHomeCell.self, forCellWithReuseIdentifier: CoinHomeCell.cell)

        collectionView.register(NftHomeCell.self, forCellWithReuseIdentifier: NftHomeCell.cell)
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind:
                                    UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderSupplementaryView.cell)
        
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
        homeViewModel?.getNetworkData()
        homeViewModel?.onDataUpdate = { [weak self] in
            self?.applyInitialSnapshot()
        }
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
            
            collectionView.topAnchor.constraint(equalTo: NewsView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()
    }
    
}

extension HomeViewController {
    func makeCollectionViewLayout() -> UICollectionViewLayout { UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch self?.sections[sectionIndex] {
            case .bestCoin:
                return self?.createBestCoinSection()
            case .coins:
                return self?.createCoinSection()
            case .nfts:
                return self?.createNftsSection()
            default:
                return nil
            }
        }
    }
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpasing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem])
    -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpasing
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    // MARK: - Layout BestCoin
    private func createBestCoinSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .fractionalHeight(0.9)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .fractionalWidth(0.9),
                      heightDimension: .fractionalHeight(0.30)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpasing: 5,
                                          supplementaryItems: [])
        section.contentInsets = .init(top: 5, leading: 20, bottom: 0, trailing: -20)
        return section
    }
    // MARK: - Layout TopCoin
    private func createCoinSection() -> NSCollectionLayoutSection {
        // Создание элемента
        let item = NSCollectionLayoutItem(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .fractionalHeight(1)))

        // Горизонтальная группа для списка монет
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .fractionalWidth(0.5),
                      heightDimension: .absolute(120)),
                                                       subitems: [item])

        // Создание секции
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpasing: 0,
                                          supplementaryItems: [createSupplementaryItems()])
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5, leading: 20, bottom: 10, trailing: 10)
        
        return section
    }

    private func createNftsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                .init(widthDimension: .fractionalWidth(0.45),
                      heightDimension: .fractionalHeight(0.9)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .fractionalHeight(0.2)),
                                                       subitems: [item])
        group.interItemSpacing = .flexible(20)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpasing: 5,
                                          supplementaryItems: [createSupplementaryItems()])
        section.contentInsets = .init(top: 5, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    private func createSupplementaryItems() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .estimated(40)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}
//MARK: - DataSource applyInitialSnapshot()
private extension HomeViewController {
    func setupDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .bestCoin(let bestCoinModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCoinCell.cell, for: indexPath) as? MainCoinCell else {
                    fatalError("Unable to dequeue CoinHomeCell")
                }
                cell.configure(with: self.homeViewModel, coinModel: bestCoinModel)
                return cell
            case .coin(let coinModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinHomeCell.cell, for: indexPath) as? CoinHomeCell else {
                    fatalError("Unable to dequeue CoinHomeCell")
                }
                cell.configure(with: self.homeViewModel, coinModel: coinModel)
                return cell
                
            case .nft(let nftModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NftHomeCell.cell, for: indexPath) as? NftHomeCell else {
                    fatalError("Unable to dequeue NftHomeCell")
                }
                cell.configure(with: self.homeViewModel, nftModel: nftModel)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionKind = SectionModelCoin(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            switch sectionKind {
            case .coins:
                guard let cell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderSupplementaryView.cell,
                    for: indexPath
                ) as? HeaderSupplementaryView else {
                    return UICollectionReusableView()
                }
                cell.configureHeader(categoryName: "Top Coins")
                return cell
                
            case .nfts:
                guard let cell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderSupplementaryView.cell,
                    for: indexPath
                ) as? HeaderSupplementaryView else {
                    return UICollectionReusableView()
                }
                cell.configureHeader(categoryName: "NFTs")
                return cell
                
            default:
                return UICollectionReusableView()
            }
        }

        return dataSource
    }
    
    func applyInitialSnapshot() {
        var snapshot = DataSourceSnapshot()

        snapshot.appendSections([.bestCoin, .coins, .nfts])

        guard let coinModels = homeViewModel?.coinModels else { return }
        guard let nftModels = homeViewModel?.nftModels else { return }

        let bestCoinItems: [HomeModel] = coinModels.prefix(1).map { HomeModel.bestCoin($0) }
        let coinItems: [HomeModel] = coinModels.dropFirst().map { HomeModel.coin($0) }
        let nftItems: [HomeModel] = nftModels.map { HomeModel.nft($0.toHomeNFTsModel()) }

        snapshot.appendItems(bestCoinItems, toSection: .bestCoin)
        snapshot.appendItems(coinItems, toSection: .coins)
        snapshot.appendItems(nftItems, toSection: .nfts)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

}
