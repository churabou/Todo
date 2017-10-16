//
//  TodoListTableViewCell.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/15.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell, Reusable, NibLoadable {

    
    var todo: Todo? {
    
        didSet {
        
            self.textLabel?.text = todo?.outline
        }
    }
    
    var content = "" {
    
        didSet {
        
            self.textLabel?.text = content
        }
    }

}
