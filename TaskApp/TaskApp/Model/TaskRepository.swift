//
//  TaskRepository.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/11/29.
//  Copyright © 2020 せいま. All rights reserved.
//

import Foundation

class TaskRepository {
    
    static let shared = TaskRepository()
    
    private init() {
        tasks = {
            if let tasks: [Any] = UserDefaults.standard.array(forKey: "tasks") {
                return tasks.compactMap { element in
                    if let data = element as? Data, let task = try? JSONDecoder().decode(Task.self, from: data) {
                        let task = task
                        return task
                    }
                    return nil
                }
            }
            return []
        }()
    }
    
    private (set) var tasks: [Task] {
        didSet {
            let dataEncoder = tasks.compactMap{ element in
                return try? JSONEncoder().encode(element)
            }
            UserDefaults.standard.set(dataEncoder, forKey: "tasks")
            UserDefaults.standard.synchronize()
        }
    }
    
    var favoriteTasks: [Task] {
        tasks.filter{ $0.isFavorite }
    }
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func favorite(task: Task, sourceIndex: Int) {
        task.isFavorite = !task.isFavorite
        var tasks = self.tasks
        tasks[sourceIndex] = task
    }
    
    func delete(index: Int) {
        var tasks = self.tasks
        tasks.remove(at: index)
    }
    
    func sort(sourceIndex: Int, destinationIndex: Int) {
        var tasks = self.tasks
        let task = tasks[sourceIndex]
        tasks.remove(at: sourceIndex)
        tasks.insert(task, at: destinationIndex)
    }
}
