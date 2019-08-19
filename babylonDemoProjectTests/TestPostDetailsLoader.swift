//
//  TestPostDetailsLoader.swift
//  babylonDemoProjectTests
//
//  Created by Mohamed Ibrahim on 18/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import XCTest
@testable import babylonDemoProject

class TestPostDetailsLoader: XCTestCase {
    
    func testPostDetailViewModelWithMockedPosts() {
        let post = Post(userId: 1, id: 1, title: "title", body: "body")
        let dataModel = PostDetailViewModel(dataLoader: MockedPostDetailsLoader(), post: post)
        XCTAssertEqual(dataModel.title, "Post")
        XCTAssertEqual(dataModel.postBody, "body")
        XCTAssertEqual(dataModel.postTitle, "title")
        XCTAssertEqual(dataModel.post, post)
        XCTAssertEqual(dataModel.userName.value, "name")
    }
    
    
    func testBinding() {
        let post = Post(userId: 1, id: 1, title: "title", body: "body")
        let dataModel = PostDetailViewModel(dataLoader: MockedPostDetailsLoader(), post: post)
        dataModel.userName.bind {
            XCTAssertEqual($0, "name")
        }
    }

    final class MockedPostDetailsLoader: PostDetailProtocol {
        func loadComments(key: Any, completion: @escaping CommentsResponseCompletion) {
            let comment = [Comment(postId: 0, id: 0, name: "name", email: "email", body: "body")]
            let apiResponse = APIResponse<[Comment]>(statusCode: 200, body: comment)
            completion(.success(apiResponse))
        }
        
        func loadUserDetails(key: Any, completion: @escaping UserResponseCompletion) {
            let user = User(id: 1, name: "name", username: "username", email: "email", address: Address(street: "street", suite: "suite", city: "city", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "long")), phone: "phone", website: "website", company: Company(name: "companyName", catchPhrase: "cathphrase", bs: "bs"))
            let apiResponse = APIResponse<User>(statusCode: 200, body: user)
            completion(.success(apiResponse))
        }
    }}
