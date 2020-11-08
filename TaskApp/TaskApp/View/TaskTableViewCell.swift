//
//  TaskTableViewCell.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/10/25.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var taskSubTitleLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
//        var favoriteTask: [String: String] = [:]
//        favoriteTask["title"] = taskTitleLabel.text!
//        favoriteTask["date"] = taskSubTitleLabel.text!
//        var favoriteTasks = UserDefaults.standard.array(forKey: "favoriteTasks") as? [[String: String]] ?? []
//        favoriteTasks.append(favoriteTask)
        
        task["isFavorite"] = !((task["isFavorite"] as? Bool) ?? false)
            var tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
            tasks[indexPath] = task
            UserDefaults.standard.set(tasks, forKey: "tasks")
            if ((task["isFavorite"] as? Bool) ?? false) {
              //ボタンの画像を変える
            } else {
        //      ボタンの画像を変える
            }
    }
}

//task["isFavorite"] = !((task["isFavorite"] as? Bool) ?? false)
//    var tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
//    tasks[indexPath] = task
//    UserDefaults.standard.set(tasks, forKey: "tasks")
//    if ((task["isFavorite"] as? Bool) ?? false) {
//      //ボタンの画像を変える
//    } else {
////      ボタンの画像を変える
//    }
