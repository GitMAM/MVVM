//
//  PostDetailsViewModel.swift
//  babylonDemoProject
//
//  Created by Mohamed on 13/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

typealias UserResponseCompletion = (APIResult<User>) -> Void
typealias CommentsResponseCompletion = (APIResult<[Comment]>) -> Void


protocol PostDetailProtocol {
    func loadUserDetails(key: Any, completion: @escaping UserResponseCompletion)
    func loadComments(key: Any, completion: @escaping CommentsResponseCompletion)
}

final class PostDetailsLoader: PostDetailProtocol {

    private let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    internal func loadUserDetails(key: Any, completion: @escaping UserResponseCompletion) {
        apiManager.request(for: .author, with: key) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try response.decode(to: User.self)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingFailure)); return
                }
            case .failure(_):
                 completion(.failure(.requestFailed)); return
            }
        }
    }

    internal func loadComments(key: Any, completion: @escaping CommentsResponseCompletion) {
        apiManager.request(for: .comments, with: key) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try response.decode(to: [Comment].self)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingFailure)); return
                }
            case .failure(_):
                completion(.failure(.requestFailed)); return
            }
        }
    }
}
