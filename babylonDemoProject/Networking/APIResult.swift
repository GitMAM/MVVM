//
//  APIResult.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import Foundation

enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}
