//
//  PostDetailViewModel.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

final class PostDetailViewModel: NSObject {

    private(set) var post: Post

    private var dataLoader: PostDetailProtocol

    var title: String {
        return "Post"
    }

    var postTitle: String {
        return post.title
    }

    var postBody: String {
        return post.body
    }

    var userName: Box<String?> = Box(nil)
    var numberOfComment: Box<Int?> = Box(nil)

    init(dataLoader: PostDetailProtocol = PostDetailsLoader(), post: Post) {
        self.dataLoader = dataLoader
        self.post = post
        super.init()
        fetchUsersAndComments()
    }

    private func fetchUsersAndComments() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()   // <<---
        dataLoader.loadUserDetails(key: post.userId) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.userName.value = response.body.name
                dispatchGroup.leave()
            case .failure(_):
                dispatchGroup.leave()
            }
        }

        dispatchGroup.enter()   // <<---

        dataLoader.loadComments(key: post.id) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.numberOfComment.value = response.body.count
                dispatchGroup.leave()
            case .failure(_):
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            // do something here when leaving the quque
        }
    }
}
