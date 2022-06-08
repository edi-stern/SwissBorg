//
//  ApiRouter.swift
//  SwissBorg
//
//  Created by Eduard Stern on 07.06.2022.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {

    //The endpoint name we'll call later
    case getSymbols(symbols: String)

    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        //Http method
        urlRequest.httpMethod = method.rawValue

        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: parameters)
    }

    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getSymbols:
            return .get
        }
    }

    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getSymbols:
            return "tickers"
        }
    }

    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .getSymbols(let symbols):
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constants.Parameters.symbols : symbols]
        }
    }
}
