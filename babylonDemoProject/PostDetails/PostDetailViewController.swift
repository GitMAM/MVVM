//
//  PostDetailViewController.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit
import SnapKit

final class PostDetailViewController: UIViewController {

    let scrollView: UIScrollView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    let stackView: UIStackView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 20
        return $0
    }(UIStackView())

    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())

    let userLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0

    }(UILabel())

    let commentsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())


    var viewModel: PostDetailViewModel

    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addConstraints()
        updateUiElementsTitles()
    }

    private func addConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(userLabel)
        stackView.addArrangedSubview(commentsLabel)

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(-8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(8)
        }
    }

    private func updateUiElementsTitles() {

        self.title = viewModel.title
        titleLabel.text = viewModel.postTitle
        descriptionLabel.text = viewModel.postBody

        viewModel.userName.bind { [weak self] (username) in
            DispatchQueue.main.async {
                self?.userLabel.text = username
            }
        }

        viewModel.numberOfComment.bind { [weak self] (numberOfComment) in
            DispatchQueue.main.async {
                self?.commentsLabel.text = "number of comments is \(String(describing: numberOfComment ?? 0))"
            }
        }
    }
}
