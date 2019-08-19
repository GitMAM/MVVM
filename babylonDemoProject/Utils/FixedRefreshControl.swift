//
//  FixedRefreshControl.swift
//  Neva Labs
//
//  Created by Mohamed on 22/08/2018.
//  Copyright © 2018 Neva-Labs. All rights reserved.
//

import UIKit

final class FixedRefreshControl: UIRefreshControl {

    override var frame: CGRect {
        get { return super.frame }
        set {
            var newFrame = newValue
            if let superScrollView = superview as? UIScrollView {
                newFrame.origin.x = superScrollView.frame.minX - superScrollView.contentInset.left
            }
            super.frame = newFrame
        }
    }

}
