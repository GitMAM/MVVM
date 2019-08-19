//
//  CommentModel.swift
//  babylonDemoProject
//
//  Created by Mohamed on 13/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let postId, id: Int
    let name, email, body: String
}
