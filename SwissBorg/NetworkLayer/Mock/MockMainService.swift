//
//  MockMainService.swift
//  SwissBorg
//
//  Created by Eduard Stern on 08.06.2022.
//

import Foundation
import RxSwift
import Alamofire

final class MockMainService: MainServiceInterface {
    var network: NetworkServiceInterface

    init() {
        self.network = MockNetworkService()
    }

    func getPosts(symbols: String) -> Observable<[Pair]> {
        return Observable.just([Pair(symbol: "BTC", lastPrice: 33000.0),
                                Pair(symbol: "ETH", lastPrice: 3000.0),
                                Pair(symbol: "CHSB", lastPrice: 0.024),
                                Pair(symbol: "LTC", lastPrice: 61.62),
                                Pair(symbol: "XRP", lastPrice: 0.39),
                                Pair(symbol: "DSH", lastPrice:  58.37)])
    }
}

final class MockNetworkService: NetworkServiceInterface {
    func request<T>(_ urlConvertible: URLRequestConvertible) -> Observable<T> where T : Decodable, T : Encodable {
        return Observable.empty()
    }
}

    // MARK: Mock Pair
private extension Pair {
    init (symbol: String, lastPrice: Float) {
        self.symbol = symbol
        self.lastPrice = lastPrice
        bid = Float.random(in: 10000..<50000)
        bidSize = Float.random(in: 0..<5)
        ask = Float.random(in: 0..<5)
        askSize = Float.random(in: 0..<5)
        dailyChange = Float.random(in: 0..<5)
        dailyChangeRelative = Float.random(in: 0..<5)
        volume = Float.random(in: 0..<5)
        high = Float.random(in: 0..<5)
        low = Float.random(in: 0..<5)
    }
}
