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
    
    var favoriteTasks:[[String: String]] {
        UserDefaults.standard.array(forKey: "tasks") as? [[String: String]] ?? []
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
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.favoriteTitleLabel.text = favoriteTasks[indexPath.row]["title"]
        cell.favoriteSubtitleLabel.text = favoriteTasks[indexPath.row]["date"]
        return cell
    }
}
