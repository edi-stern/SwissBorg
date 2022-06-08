//
//  Pair.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation


// MARK: Pair

struct Pair: Codable {
    let symbol: String
    let bid: Float
    let bidSize: Float
    let ask: Float
    let askSize: Float
    let dailyChange: Float
    let dailyChangeRelative: Float
    let lastPrice: Float
    let volume: Float
    let high: Float
    let low: Float

    var name: String {
        var name = symbol.replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "USD", with: "")
        guard let tIndex = symbol.firstIndex(of: "t") else {
            return name
        }
        name.remove(at: tIndex)
        return name
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        symbol = try container.decode(String.self)
        bid = try container.decode(Float.self)
        bidSize = try container.decode(Float.self)
        ask = try container.decode(Float.self)
        askSize = try container.decode(Float.self)
        dailyChange = try container.decode(Float.self)
        dailyChangeRelative = try container.decode(Float.self)
        lastPrice = try container.decode(Float.self)
        volume = try container.decode(Float.self)
        high = try container.decode(Float.self)
        low = try container.decode(Float.self)
    }
}
