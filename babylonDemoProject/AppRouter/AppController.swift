//
//  AppController.swift
//  FreeTime
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit

final class AppController: NSObject {

    private var splitViewController: AppSplitViewController!

    func appDidFinishLaunching(with window: UIWindow?) {
        guard let controller = window?.rootViewController as? AppSplitViewController else {
            fatalError("App must be setup with a split view controller")
        }
        splitViewController = controller
    }


    func appDidBecomeActive() {
        resetViewControllers()
    }

    private func resetViewControllers() {
        let controller = FeedViewController()
        splitViewController.reset(
            viewControllers: [
                UINavigationController(rootViewController: controller)
            ]
        )
    }
}


