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
    
    var task: Task?
    
    var indexPath: Int = 0
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let task = task else {
            return
        }
        
        task.isFavorite = !(task.isFavorite)
        Task.saveTasks[indexPath] = task
        if task.isFavorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setUp(savetask: Task, index: Int) {
        taskTitleLabel.text = savetask.title
        taskSubTitleLabel.text = savetask.date
        self.task = savetask
        self.indexPath = index
    }
}
