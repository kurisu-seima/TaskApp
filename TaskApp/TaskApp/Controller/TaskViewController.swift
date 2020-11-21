//
//  TaskViewController.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/10/23.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [Task] {
        var tasksDataArray: [Data] = []
        guard  let tasksData = UserDefaults.standard.data(forKey: "tasks") else {
            return [Task]()
        }
        tasksDataArray.append(tasksData)
        guard let tasksArray = try? JSONDecoder().decode([Task].self, from: tasksData) else {
            fatalError("エラー")
        }
        return tasksArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
    }
    
    @IBAction func plusButtonDidTapped(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "AddTask") as! AddTaskViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//テーブルビュー
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.setUp(task: tasks[indexPath.row], index: indexPath.row)
        return cell
    }
}
