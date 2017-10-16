//
//  ViewController.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let home = HomeViewController.instantiateFromStoryboard()
        self.view.window?.rootViewController = home
        self.view.window?.layer.add(CATransition(), forKey: kCATransition)
    }


}

