//
//  Box.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
