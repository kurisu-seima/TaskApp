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
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        taskTableView.isEditing = editing
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var tasks = getData()
        tasks.remove(at: indexPath.row)
        saveData(tasks: tasks)
        taskTableView.deleteRows(at: [indexPath], with: .automatic)
        taskTableView.reloadData()
    }
}
