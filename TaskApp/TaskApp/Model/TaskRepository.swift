//
//  TaskRepository.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/11/29.
//  Copyright © 2020 せいま. All rights reserved.
//

import Foundation

class TaskRepository {
    
    static var tasks: [Task] {
        guard let datas = UserDefaults.standard.data(forKey: "tasks") else {
            return []
        }
        let taskDatas = (try? JSONDecoder().decode([Task].self, from: datas)) ?? []
        return taskDatas
    }
    
    static func saveData(tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: "tasks")
    }
    
    static var favoriteTasks: [Task] {
        tasks.filter{ $0.isFavorite}
    }
    
    static func favorite(task: Task, sourceIndex: Int) {
        task.isFavorite = !task.isFavorite
        var tasks = self.tasks
        tasks[sourceIndex] = task
        self.saveData(tasks: tasks)
    }
    
    static func delete(index: Int) {
        var tasks = self.tasks
        tasks.remove(at: index)
        saveData(tasks: tasks)
    }
    
    static func sort(sourceIndex: Int, destinationIndex: Int) {
        var tasks = self.tasks
        let task = tasks[sourceIndex]
        tasks.remove(at: sourceIndex)
        tasks.insert(task, at: destinationIndex)
        saveData(tasks: tasks)
    }
}
