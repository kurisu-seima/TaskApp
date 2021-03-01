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
        TaskRepository.shared.tasks
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
        nextVC.addTaskType = .new
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        TaskRepository.shared.delete(index: indexPath.row)
        taskTableView.deleteRows(at: [indexPath], with: .automatic)
        taskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        TaskRepository.shared.sort(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskTableView.deselectRow(at: indexPath, animated: true)
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "AddTask") as! AddTaskViewController
        let tasks = TaskRepository.shared.tasks
        nextVC.task = tasks[indexPath.row]
        nextVC.indexPath = indexPath.row
        nextVC.addTaskType = .edit

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension TaskViewController: DisplayAlert {
    func displayAlert(taskTitle: String, index: Int) {
        let alert = UIAlertController(title: "ToDo名を編集", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) {(action) in
            guard let textFields = alert.textFields else {
                return
            }
            for textField in textFields {
                switch textField.tag {
                case 1:
                    guard let newText = textField.text, !newText.isEmpty else {
                        return
                    }
                    
                let tasks = TaskRepository.shared.tasks
                    tasks[index].title = newText
                    self.taskTableView.reloadData()
                default:
                    break
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: {(editText: UITextField) -> Void in
            editText.tag = 1
            editText.text = taskTitle
        })
        self.present(alert, animated: true, completion: nil)
    }
}
