//
//  NibLoadable.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        
        return String(describing: self)
    }
    
    static func instantiateFromNib() -> Self {
        
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
