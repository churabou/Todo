//
//  Reusable.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit

protocol Reusable: class {
    
    static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        
        return String(describing: self)
    }
}
