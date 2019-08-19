//
//  Post.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

struct Post: Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
