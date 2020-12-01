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
    var contents: String
    
    static var saveTrueTask: [Task] = []
    
    init(title:String,date:String,isFavorite:Bool, contents: String) {
        self.title = title
        self.date = date
        self.isFavorite = isFavorite
        self.contents = contents
    }
}
