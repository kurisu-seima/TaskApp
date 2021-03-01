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
    
    var task: Task!
    var indexPath: Int!
    var addTaskType: AddTaskType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerSetUp()
        
        taskTextField.text = task?.title
        dateTextField.text = task?.date
        taskTextView.text = task?.contents
        
        taskTextView.delegate = self
    }
    
    //タスクを追加して前の画面へ戻る
    @IBAction func addButtonDidTapped(_ sender: Any) {
        guard let title = taskTextField.text, let date = dateTextField.text, !title.isEmpty else {
            return
        }
        
        switch addTaskType {
        case .new:
            let task = Task(title: title, date: date, isFavorite: false, contents: taskTextView.text)
            TaskRepository.shared.add(task: task)
            self.navigationController?.popViewController(animated: true)
        case .edit:
            let tasks = TaskRepository.shared.tasks
            let task = tasks[indexPath]
            task.title = title
            task.date = date
            task.contents = taskTextView.text
            self.navigationController?.popViewController(animated: true)
        case .none:
            break
        }
    }
    
    func datePickerSetUp() {
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
    }
    
    //ツールバーの完了ボタンを押した時の処理
    @objc func done() {
        dateTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = "\(formatter.string(from: datepicker.date))"
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
