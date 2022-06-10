//
//  MainViewModel.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation
import RxSwift
import RxRelay

// MARK: ViewModelProtocl

protocol MainViewModel {
    var error: BehaviorRelay<String?> { get }
    var mainService: MainServiceInterface { get }
    var disposeBag: DisposeBag { get }
    var pairs: BehaviorRelay<[Pair]> { get }
    var filteredPairs: BehaviorRelay<[Pair]> { get }
    var searchObserver: BehaviorRelay<String> { get }
    func fetchData()
}

// MARK: DefaultViewModel

final class DefaultViewModel: MainViewModel {
    
    // MARK: Variables
    var error = BehaviorRelay<String?>(value: nil)
    var mainService: MainServiceInterface
    var disposeBag = DisposeBag()
    var pairs = BehaviorRelay<[Pair]>(value: [])
    var filteredPairs = BehaviorRelay<[Pair]>(value: [])
    var searchObserver = BehaviorRelay<String>(value: "")
    
    // MARK: Init
    
    init(mainService: MainServiceInterface) {
        self.mainService = mainService
        
        Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
            .startWith(0)
            .subscribe(onNext: { [weak self] _ in
                self?.fetchData()
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(pairs, searchObserver)
            .asDriver(onErrorJustReturn: ([], ""))
            .drive(onNext: { [weak self] pairs, text in
                self?.filteredPairs.accept(text.isEmpty ? pairs : pairs.filter { $0.name.contains(text.uppercased()) })
            })
            .disposed(by: disposeBag)
    }
    
    internal func fetchData() {
        mainService.getPosts(symbols: Constants.symbols)
            .subscribe(onNext: { [weak self] pairs in
                self?.pairs.accept(pairs)
            }, onError: { [weak self] error in
                switch error {
                case ApiError.conflict:
                    self?.error.accept("Conflict error")
                case ApiError.forbidden:
                    self?.error.accept("Forbidden error")
                case ApiError.notFound:
                    self?.error.accept("Not found error")
                default:
                    self?.error.accept("Unknown error: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
    }
    
}
