//
//  StoryboardInstantiable.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit


protocol StoryboardInstantiable {
    
    static var storyboardName: String { get }
}


extension StoryboardInstantiable where Self: UIViewController {
    
    static func instantiateFromStoryboard() -> Self {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? Self
        
        if controller == nil {
            
            assert(false, "生成したいViewControllerと同じ名前のStorybaordが見つからないか、Initial ViewControllerに設定されていない可能性があります。")
        }
        
        return controller!
    }
}

