//
//  TaskTableViewCell.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/10/25.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

protocol DisplayAlert {
    func displayAlert(taskTitle: String, index: Int)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var taskSubTitleLabel: UILabel!
    
    var task: Task?
    
    var indexPath: Int = 0
    
    var delegate: DisplayAlert?
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let task = task else {
            return
        }

        TaskRepository.favorite(task: task, sourceIndex: indexPath)
        if task.isFavorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.delegate?.displayAlert(taskTitle: self.taskTitleLabel.text!, index: indexPath)
    }
    
    func setUp(task: Task, index: Int) {
        taskTitleLabel.text = task.title
        taskSubTitleLabel.text = task.date
        self.task = task
        self.indexPath = index
        
        if task.isFavorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
