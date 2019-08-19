//
//  AppSplitViewController.swift
//  Freetime
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit

final class AppSplitViewController: UISplitViewController {

    private let tabDelegateController = TabBarControllerDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        masterTabBarController?.delegate = tabDelegateController
        preferredDisplayMode = .allVisible
    }

    var detailNavigationController: UINavigationController? {
        return viewControllers.last as? UINavigationController
    }

    var masterTabBarController: UITabBarController? {
        return viewControllers.first as? UITabBarController
    }

    func resetEmpty() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        reset(
            viewControllers: [UINavigationController(rootViewController: controller)]
        )
    }

    func reset(viewControllers: [UIViewController]) {
        masterTabBarController?.viewControllers = viewControllers
    }
}
