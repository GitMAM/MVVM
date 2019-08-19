//
//  FeedViewController.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit

final class FeedViewController: UITableViewController {

    private let viewModel: FeedViewModel
    private var dataSource : TableViewDataSource<Post>?
    private let feedRefersher: FeedRefresh

    init(viewModel: FeedViewModel = FeedViewModel(), feedRefersher: FeedRefresh = FeedRefresh()) {
        self.viewModel = viewModel
        self.feedRefersher = feedRefersher
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableView.description())
        bindDataAndReloadTableView()
        updateTableViewStyle()
        title = viewModel.title
    }

    private func bindDataAndReloadTableView(fromRefersher: Bool = false) {
        viewModel.posts.bind { [weak self] in
            guard let posts = $0 else {return}
            DispatchQueue.main.async {
                let dataSource: TableViewDataSource = .make(for: posts)
                self?.dataSource = dataSource
                self?.tableView.dataSource = dataSource
                self?.tableView.reloadData()
                if fromRefersher {
                    self?.feedRefersher.endRefreshing()
                }
            }
        }
    }

    private func updateTableViewStyle() {
        tableView.tableFooterView = UIView()
        tableView.refreshControl = feedRefersher.refreshControl
        feedRefersher.refreshControl.addTarget(self, action: #selector(onRefersh), for: .valueChanged)
    }

    @objc private func onRefersh() {
       bindDataAndReloadTableView(fromRefersher: true)
    }
}

extension FeedViewController {
    override func tableView(_ tableView: UITableView,
                  didSelectRowAt indexPath: IndexPath) {
        // could use coordinator here
        guard let post = viewModel.posts.value?[indexPath.row] else {return}
        navigationController?.pushViewController(PostDetailViewController(viewModel: PostDetailViewModel(post: post)), animated: true)
    }
}

extension FeedViewController: TabNavRootViewControllerType {
    func didSingleTapTab() {}
    
    func didDoubleTapTab() {
        if !tableView.visibleCells.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
