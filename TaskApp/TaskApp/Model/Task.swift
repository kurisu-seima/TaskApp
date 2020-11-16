//
//  Task.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/11/15.
//  Copyright © 2020 せいま. All rights reserved.
//

import Foundation

class Task {
    static var saveTasks: [Task] = [Task(title: "タスク1", date: "2020年11月16日", isFavorite: false), Task(title: "タスク2", date: "2020年10月9日", isFavorite: true), Task(title: "タスク3", date: "2020年5月13日", isFavorite: false), Task(title: "タスク4", date: "2020年2月4日", isFavorite: true)]
    
    var title: String
    var date: String
    var isFavorite: Bool
    
    init(title: String, date: String, isFavorite: Bool) {
        self.title = title
        self.date = date
        self.isFavorite = isFavorite
    }
}
