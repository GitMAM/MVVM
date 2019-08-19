//
//  PopProtocol.swift
//  babylonDemoProject
//
//  Created by Mohamed on 12/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit

extension UIViewController {
    func popUp(title:String, msg:String, actionTitle: String = "Ok", handler: ((UIAlertAction)->Void)? = nil){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
