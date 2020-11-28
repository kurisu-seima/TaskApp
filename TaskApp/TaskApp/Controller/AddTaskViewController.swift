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

    let datepicker = UIDatePicker()
    
    var task: String?
    var date: String?
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
        
        taskTextField.text = task
        dateTextField.text = date
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
        if let task = task, let date = date, let index = indexPath, !task.isEmpty, !date.isEmpty {
            guard  let title = taskTextField.text, let date = dateTextField.text, !title.isEmpty, !date.isEmpty else {
                return
            }
            
            var tasks = getData()
            let task = tasks[index]
            task.title = title
            task.date = date
            tasks[index] = task
            saveData(tasks: tasks)
        } else {
            guard  let title = taskTextField.text, let date = dateTextField.text, !title.isEmpty, !date.isEmpty else {
                return
            }
            
            let task = Task.init(title: title, date: date, isFavorite: false)
            var tasks = getData()
            tasks.append(task)
            saveData(tasks: tasks)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
