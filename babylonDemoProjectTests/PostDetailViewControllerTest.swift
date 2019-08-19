//
//  PostDetailViewControllerTest.swift
//  babylonDemoProjectTests
//
//  Created by Mohamed on 15/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import XCTest
@testable import babylonDemoProject


class PostDetailViewControllerTest: XCTestCase {

    func testViewControllerTitle() {
        let (sut, viewModel) = makeSut()
        XCTAssertEqual( sut.title , viewModel.title)
    }

    func testViewControllerViewModelInjection() {
        let (sut, viewModel) = makeSut()
        XCTAssertEqual(sut.viewModel, viewModel)
    }

    func testViewControllerUiElementsAndViewModels() {
        let (sut, viewModel) = makeSut()
        XCTAssertEqual(sut.titleLabel.text, viewModel.postTitle)
        XCTAssertEqual(sut.descriptionLabel.text, viewModel.postBody)

        XCTAssertEqual(sut.viewModel.userName.value, viewModel.userName.value)
        XCTAssertEqual(sut.viewModel.numberOfComment.value, viewModel.numberOfComment.value)
    }


    private func makeSut() -> (PostDetailViewController, PostDetailViewModel) {
        let viewModel = PostDetailViewModel(dataLoader: MockedPostDetailsLoader(), post: Post(userId: 1, id: 2, title: "Title", body: "body"))
        let sut = PostDetailViewController(viewModel: viewModel)
        _ = sut.view
        return (sut, viewModel)
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
    }
}
