//
//  ApiError.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500

    var description: String {
        switch self {
        case .forbidden:
            return "Forbidden error"
        case .notFound:
            return "Not found error"
        case .conflict:
            return "Conflict error"
        case .internalServerError:
            return "Internal server error"
        }
    }
}
