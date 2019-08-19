//
//  FeedViewControllerTest.swift
//  babylonDemoProjectTests
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import XCTest
@testable import babylonDemoProject

class FeedViewControllerTest: XCTestCase {
    
    func testViewControllerTitleFromViewModel() {
        let (sut, viewModel) = makeSut()
        XCTAssertEqual(sut.title, viewModel.title)
    }

    func testViewModelBinding() {
        let (_, viewModel) = makeSut()
        XCTAssertEqual(viewModel.posts.value?.count, 1)
        XCTAssertEqual(viewModel.posts.value?.first?.title, "Title")
    }

    func testTableViewDataSource() {
        let (sut, viewModel) = makeSut()
        guard let posts = viewModel.posts.value else {return}
        let dataSource: TableViewDataSource = .make(for: posts)
        XCTAssertEqual(dataSource.tableView(sut.tableView, numberOfRowsInSection: 0  ), 1)
        XCTAssertEqual(dataSource.tableView(sut.tableView, cellForRowAt: IndexPath(item: 0, section: 0)).textLabel?.text, viewModel.posts.value?.first?.title)
    }

    func testTableViewCellSelected() {
        let (sut, viewModel) = makeSut()
        sut.tableView.select(row: 0)
        guard let indexPath = sut.tableView.indexPathForSelectedRow?.row else {return}
        let post = viewModel.posts.value?[indexPath]
        XCTAssertEqual(post?.title, "Title")
    }

    private func makeSut() -> (FeedViewController, FeedViewModel) {
        let viewModel = FeedViewModel(dataLoader: MockedFeedLoader())
        let sut = FeedViewController(viewModel: viewModel)
        _ = sut.view
        return (sut, viewModel)
    }
    
    final class MockedFeedLoader: FeedLoaderProtocol {
        func loadFeed(completion: @escaping FeedResponseCompletion) {
            let posts = [Post(userId: 1, id: 2, title: "Title", body: "body")]
            let apiResponse = APIResponse<[Post]>(statusCode: 200, body: posts)
            completion(.success(apiResponse))
        }
    }
}

private extension UITableView {
    func select(row: Int) {
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
}
