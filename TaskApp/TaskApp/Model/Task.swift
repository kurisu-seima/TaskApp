//
//  Task.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/11/15.
//  Copyright © 2020 せいま. All rights reserved.
//

import Foundation

class Task: Codable{
    var title:String
    var date:String
    var isFavorite:Bool
    
    static var saveTrueTask: [Task] = []
    
    init(title:String,date:String,isFavorite:Bool) {
        self.title = title
        self.date = date
        self.isFavorite = isFavorite
    }
}

func saveData(tasks: [Task]){
    let data = try? JSONEncoder().encode(tasks)
    UserDefaults.standard.set(data, forKey: "tasks")
}

func getData() -> [Task] {
    guard let datas = UserDefaults.standard.data(forKey: "tasks")else {
        return []
    }
    let taskDatas = (try? JSONDecoder().decode([Task].self, from: datas)) ?? []
    return taskDatas
}

func getTrueTask(tasks: [Task]) -> [Task] {
    var trueTasks: [Task] = []
    for task in tasks {
        if task.isFavorite {
            trueTasks.append(task)
        } else {
            continue
        }
    }
    return trueTasks
}
