import UIKit

final class MarketViewController: UIViewController {
    
    private var viewModel: MarketViewModelProtocol
    private let refreshControl = UIRefreshControl()
    
    init(container: DependencyContainer) {
        self.viewModel = container.getMarketViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "🔎 Поиск криптовалюты"
        return searchBar
    }()
    
    private let sortSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["💰 Цена", "📈 Капитализация", "📉 Изм. 24ч"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        bindViewModel()
        viewModel.fetchCoins()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(sortSegmentedControl)
        view.addSubview(tableView)
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            sortSegmentedControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            sortSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sortSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: sortSegmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        sortSegmentedControl.addTarget(self, action: #selector(sortCoins), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc private func refreshData() {
        viewModel.fetchCoins()
    }
    
    @objc private func sortCoins() {
        let sortOption: SortOption
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0: sortOption = .price
        case 1: sortOption = .marketCap
        case 2: sortOption = .priceChange
        default: return
        }
        viewModel.sortCoins(by: sortOption)
    }
}

// MARK: - UITableViewDataSource
extension MarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            return UITableViewCell()
        }
        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension MarketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        //let selectedCoin = viewModel.filteredCoins[indexPath.row]
//        // Открытие деталей монеты
//    }
}

// MARK: - UISearchBarDelegate
extension MarketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCoins(query: searchText)
    }
}
