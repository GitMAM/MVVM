//
//  FeedViewModel.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

final class FeedViewModel: NSObject {

    private var dataLoader: FeedLoaderProtocol

    var posts: Box<[Post]?> = Box(nil)

    var title: String {
        return "Feed"
    }

    init(dataLoader: FeedLoaderProtocol = FeedLoader()) {
        self.dataLoader = dataLoader
        super.init()
        loadData()
    }

    private func loadData() {
        dataLoader.loadFeed { [weak self] (response) in
            switch response {
            case .success(let result):
                self?.posts.value = result.body
            case .failure(_):
                // do something with the error
                break
            }
        }
    }
}
