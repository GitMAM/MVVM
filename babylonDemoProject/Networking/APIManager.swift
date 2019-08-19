//
//  APIManager.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

final class APIManager {

    fileprivate static let mainURL = Constants.apiURL

    typealias APIClientCompletion = (APIResult<Data?>) -> Void

    private let session = URLSession.shared
    private let baseURL = URL(string: Constants.apiURL)


    func request(for call:APICallType ,with key: Any = "", _ completion: @escaping APIClientCompletion) {

        var request = URLRequest(url: URL(call, with: key))
        
        request.httpMethod = call.httpMethod
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 20.0

        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed)); return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }

}


fileprivate extension URL {
    init(_ call: APICallType, with key: Any) {
            guard let url = URL(string: APIManager.mainURL + call.path(with: key)) else{
                fatalError("Couldn't build URL \(call) \(APIManager.mainURL)")
            }
            self = url
    }
}
