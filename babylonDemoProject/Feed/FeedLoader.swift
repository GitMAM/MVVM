//
//  FeedLoader.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation
import Disk

typealias FeedResponseCompletion = (APIResult<[Post]>) -> Void

protocol FeedLoaderProtocol {
    func loadFeed(completion: @escaping FeedResponseCompletion)
}

final class FeedLoader: FeedLoaderProtocol {
    
    private let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadFeed(completion: @escaping FeedResponseCompletion) {
        // Better to use connectivity here. The data doesn't change so we load first from the disk.
        if Disk.exists("Feed.json", in: .caches) {
            do {
                let retrievedPosts = try Disk.retrieve("Feed.json", from: .caches, as: [Post].self)
                let apiResponse = APIResponse<[Post]>(statusCode: 200, body: retrievedPosts)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(.decodingFailure)); return
            }
        } else {
            apiManager.request(for: .posts) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try response.decode(to: [Post].self)
                        completion(.success(decodedData))
                        if !Disk.exists("Feed.json", in: .caches) {
                            try Disk.save(decodedData.body, to: .caches, as: "Feed.json")
                        }
                    } catch {
                        completion(.failure(.decodingFailure)); return
                    }
                case .failure(_):
                    completion(.failure(.requestFailed)); return
                }
            }
        }
    }
}




