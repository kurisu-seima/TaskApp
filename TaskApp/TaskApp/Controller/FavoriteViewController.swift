//
//  FavoriteViewController.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/10/23.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteTasks: [Task] {
        var trueTask: [Task] = []
        for task in Task.saveTasks {
            if task.isFavorite {
                trueTask.append(task)
            }
        }
        return trueTask
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
}

//テーブルビュー
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.favoriteSetUp(favoriteTask: favoriteTasks[indexPath.row])
        return cell
    }
}
