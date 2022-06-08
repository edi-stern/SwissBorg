//
//  Constants.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation

enum Constants {

    //The API's base URL
    static let baseUrl = "https://api-pub.bitfinex.com/v2"

    // Symbols used for request
    static let symbols = "tBTCUSD,tETHUSD,tCHSB:USD,tLTCUSD,tXRPUSD,tDSHUSD, tRRTUSD,tEOSUSD,tSANUSD,tDATUSD,tSNTUSD,tDOGE:USD,tLUNA:USD,tMATIC:USD,tNEXO:USD,tOCEAN:USD,tBEST:USD, tAAVE:USD,tPLUUSD,tFILUSD"

    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let symbols = "symbols"
    }

    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
