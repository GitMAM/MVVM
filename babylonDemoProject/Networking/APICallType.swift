//
//  APICallType.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

public enum APICallType {
    case author
    case posts
    case comments

     func path(with key: Any) -> String {
        switch self {
        case .author: return "/users/\(key)"
        case .posts: return "/posts"
        case .comments: return "/comments?postId=\(key)"
        }
    }

     var httpMethod: String {
        return "GET"
    }
}

