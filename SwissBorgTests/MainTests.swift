//
//  MainTests.swift
//  SwissBorgTests
//
//  Created by Edi Stern Private on 10.06.2022.
//

import XCTest
import RxSwift
import RxCocoa
@testable import SwissBorg

class SwissBorgTests: XCTestCase {
    
    var mainViewController: MainViewController!
    var viewModel: MainViewModel!
    var mainService: MainServiceInterface!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        mainService = MockMainService()
        viewModel = DefaultViewModel(mainService: mainService)
        mainViewController = MainViewController(viewModel: viewModel)
        disposeBag = DisposeBag()
        
        mainViewController.loadView()
        mainViewController.viewDidLoad()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        mainViewController = nil
        viewModel = nil
        mainService = nil
        disposeBag = nil
    }
    
    func testViewModelFetch() {
        XCTAssertNil(viewModel.error.value)
        XCTAssertEqual(viewModel.pairs.value.count, 6)
        XCTAssertEqual(viewModel.pairs.value.first?.symbol, "BTC")
        XCTAssertTrue(viewModel.pairs.value.contains{ $0.symbol == "LTC" && $0.lastPrice == 61.62 })
    }
    
    func testSearchObserver() {
        viewModel.searchObserver.accept("B")
        XCTAssertEqual(viewModel.filteredPairs.value.count, 2)
        XCTAssertTrue(viewModel.filteredPairs.value.contains{ $0.symbol == "CHSB" && $0.lastPrice == 0.024 })
        XCTAssertFalse(viewModel.filteredPairs.value.contains{ $0.symbol == "EOS" && $0.lastPrice == 0.024 })
    }
    
    func testViewModelErrorFetch() {
        mainService = MockErrorMainService()
        viewModel = DefaultViewModel(mainService: mainService)
        mainViewController = MainViewController(viewModel: viewModel)

        XCTAssertEqual(viewModel.error.value ?? "", "Not found error")
        XCTAssertEqual(viewModel.pairs.value.count, 0)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(mainViewController.tableView)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(mainViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertTrue(mainViewController.tableView.numberOfRows(inSection: 0) == 6)
        XCTAssertNotNil(mainViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(mainViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(mainViewController.responds(to: #selector(mainViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(mainViewController.responds(to: #selector(mainViewController.tableView(_:cellForRowAt:)))) 
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = mainViewController.tableView(mainViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? PairTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "PairTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
}
