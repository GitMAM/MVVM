//
//  TableViewDataSource.swift
//  babylonDemoProject
//
//  Created by Mohamed on 14/08/2019.
//  Copyright © 2019 OriginLines. All rights reserved.
//

import UIKit

final class TableViewDataSource<Model>: NSObject, UITableViewDataSource {

    typealias CellConfigurator = (Model, UITableViewCell) -> Void

    private var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        cellConfigurator(model, cell)
        return cell
    }
}


extension TableViewDataSource where Model == Post {
    static func make(for messages: [Post],
                     reuseIdentifier: String = UITableView.description()) -> TableViewDataSource {
        return TableViewDataSource(
            models: messages,
            reuseIdentifier: reuseIdentifier
        ) { (message, cell) in
            cell.textLabel?.text = message.title
        }
    }
}
