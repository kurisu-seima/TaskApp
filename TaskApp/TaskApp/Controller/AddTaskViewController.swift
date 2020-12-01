//
//  AddTaskViewController.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/10/23.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!

    @IBOutlet weak var taskTextView: UITextView!
    
    let datepicker = UIDatePicker()
    
    var task: Task?
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ピッカービューの設定
        datepicker.datePickerMode = .date
        datepicker.locale = .current
        datepicker.timeZone = NSTimeZone.local

        //ツールバーの作成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(done))
        toolbar.setItems([spaceItem, doneItem], animated: true)
        
        //テキストフィールドの設定
        dateTextField.inputView = datepicker
        dateTextField.inputAccessoryView = toolbar
        
        taskTextField.text = task?.title
        dateTextField.text = task?.date
        taskTextView.text = task?.contents
        
        taskTextView.delegate = self
    }
    
    //ツールバーの完了ボタンを押した時の処理
    @objc func done() {
        dateTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = "\(formatter.string(from: datepicker.date))"
    }
    
    //タスクを追加して前の画面へ戻る
    @IBAction func addButtonDidTapped(_ sender: Any) {
        if let task = task, let index = indexPath, !task.title.isEmpty, !task.date.isEmpty {
            guard  let title = taskTextField.text, let date = dateTextField.text, let contents = taskTextView.text, !title.isEmpty, !date.isEmpty else {
                return
            }
            
            var tasks = TaskRepository.tasks
            let task = tasks[index]
            task.title = title
            task.date = date
            task.contents = contents
            tasks[index] = task
            TaskRepository.saveData(tasks: tasks)
        } else {
            guard  let title = taskTextField.text, let date = dateTextField.text, let contents = taskTextView.text, !title.isEmpty, !date.isEmpty else {
                return
            }
            
            let task = Task.init(title: title, date: date, isFavorite: false, contents: contents)
            var tasks = TaskRepository.tasks
            tasks.append(task)
            TaskRepository.saveData(tasks: tasks)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddTaskViewController: UITextViewDelegate, UISearchTextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.taskTextView.isFirstResponder {
            self.taskTextView.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
