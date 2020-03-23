//
//  Endpoint.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum Endpoint {
    case getCountry
    case getProfile
    case searchCountry(param: [String: Any])
}

extension Endpoint {
    var path: String {
        switch self {
        case .getCountry:
            return Constant.baseUrl + "/v1/stats"
        case .getProfile:
            return Constant.baseUrl + "asdf"
        case .searchCountry:
            return Constant.baseUrl + "/v1/stats"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCountry, .searchCountry:
            return .get
        default:
            return .post
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getCountry:
            return nil
        case .searchCountry(let param):
            return param
        default:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getCountry, .searchCountry:
            return [
                "X-RapidAPI-Key": "d05d1a66a9msh49e2c79802753e3p137c3ejsn260c3cd4d7ce",
                "Content-Type": "application/json",
            ]
        default:
            return [
                "Authorization": "Bearer ",
                "Content-Type": "application/json",
            ]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCountry, .searchCountry:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
}
