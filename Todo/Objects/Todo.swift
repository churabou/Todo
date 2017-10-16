//
//  Todo.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/15.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {

    dynamic var category = ""
    dynamic var outline: String = ""
    dynamic var priority: Int = 0
    dynamic var createdAt: NSDate = NSDate()
    
    
    convenience init(outline: String) {
    
        self.init()
        self.outline = outline
    }
    
    convenience init(_ category: String, outline: String) {
    
        self.init()
        self.category = category
        self.outline = outline
    }
}
