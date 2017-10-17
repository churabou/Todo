//
//  Categories.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/15.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {

    dynamic var category_Id: Int = 0
    dynamic var category_name: String = ""
    
    convenience init(_ category: String) {
    
        self.init()
        self.category_name = category
    }
    
    
    
    

}
