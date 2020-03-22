//
//  APISerivce.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class APIService {
    static let shared = APIService()
    let sessionManager: SessionManager

    init() {
        let serverTrustPolicy: [String: ServerTrustPolicy] = [:]
        let conf = URLSessionConfiguration.default
        let delegate = SessionDelegate()
        sessionManager = SessionManager(configuration: conf, delegate: delegate, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicy))
    }

    func request(endpoint: Endpoint, completion: @escaping (Swift.Result<JSON, Error>) -> Void) {
        self.sessionManager.request(endpoint.path, method: endpoint.httpMethod, parameters: endpoint.parameter, encoding: endpoint.encoding, headers: endpoint.header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(.success(json))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
