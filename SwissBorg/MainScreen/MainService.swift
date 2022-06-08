//
//  MainControllerService.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation
import RxSwift

protocol MainServiceInterface {
    var network: NetworkServiceInterface { get }

    func getPosts(symbols: String) -> Observable<[Pair]>
}

class MainService: MainServiceInterface {
    var network: NetworkServiceInterface

    init(networkService: NetworkServiceInterface) {
        self.network = networkService
    }

    func getPosts(symbols: String) -> Observable<[Pair]> {
        return network.request(ApiRouter.getSymbols(symbols: symbols))
    }
}
