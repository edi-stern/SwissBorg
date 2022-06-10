//
//  ViewController.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UITableViewController {

    // MARK: Constants

    enum Constants {
        static let rowHeight = 92.0
        static let mainViewControllerTitle = "SwissBorg"
    }

    // MARK: Private proprietes

    private var viewModel: MainViewModel
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "PairTableViewCell"

    // MARK: SearchBar

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .done
        searchBar.sizeToFit()

        return searchBar
    }()

    // MARK: Init

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        registerCells()
        bind()
        observeSearchBar()
    }

    // MARK: Private methods

    private func setupView() {
        title = Constants.mainViewControllerTitle

        tableView.rowHeight = Constants.rowHeight
        tableView.allowsSelection = false

        tableView.tableHeaderView = searchBar
    }

    private func registerCells() {
        // Register the table view cell class and its reuse id
        tableView.register(PairTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }

    private func bind() {
        viewModel.error.subscribe(onNext: { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withTitle: "There was an error", withMessage: errorMessage)
        })
        .disposed(by: viewModel.disposeBag)

        viewModel.filteredPairs.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        })
        .disposed(by: viewModel.disposeBag)
    }
}

// MARK: TableViewDelegates

extension MainViewController {
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPairs.value.count
    }

    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let item = viewModel.filteredPairs.value[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                       for: indexPath) as? PairTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(item: item)

        return cell
    }
}

// MARK: TableViewDelegates

extension MainViewController {
    private func observeSearchBar() {
        searchBar.rx
            .text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchObserver)
            .disposed(by: viewModel.disposeBag)

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: viewModel.disposeBag)

        searchBar.rx
            .cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak searchBar] in
                searchBar?.text?.removeAll()
                searchBar?.resignFirstResponder()
            })
            .disposed(by: viewModel.disposeBag)
    }
}



