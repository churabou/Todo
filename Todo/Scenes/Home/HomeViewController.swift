//
//  HomeViewController.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class HomeViewController: ButtonBarPagerTabStripViewController {

    
    var textView: InputView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(white: 1, alpha: 0.6)
            newCell?.label.textColor = .white
            
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
        self.textView = InputView.instantiateFromNib()
        self.textView.frame.size = CGSize(width: view.frame.width, height: 50)
        self.textView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        
        var childView: [UIViewController] = []
        self.categories.forEach { categoy in
            
            let child = TodoListViewController.instantiateFromStoryboard()
            child.category = categoy
            childView.append(child)
        }
        
        return childView
        
    }
    
    //MARK: fileprivate
    
    fileprivate var categories: [String] {
        
        return ["todoA", "todoB", "todoC"]
    }
    //MARK: private
    
    @IBAction dynamic private func button(_ sender: UIButton){
    
        self.textView.frame.origin = CGPoint(x: 0, y: view.frame.height)
        self.view.addSubview(textView)
        self.textView.textField.becomeFirstResponder()

    }
    

    //キーボードが開くときの呼び出しメソッド
    func keyboardWillBeShown(notification:NSNotification) {
        
        //キーボードのフレームを取得する。
        if let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            self.textView.frame.origin.y = keyboardFrame.origin.y - 50
            print(keyboardFrame)
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        }
    }
    
}

extension HomeViewController: InputButtonTouchUpDelegate {

    func touchUpInputButton(_ textField: UITextField, inputView: InputView) {
        
        if inputView.state == .write {
        
            let todo = Todo(self.categories[currentIndex] ,outline: textField.text!)
            RealmModel.instance.write(todo)
            let todoListView = self.viewControllers[currentIndex] as! TodoListViewController
            todoListView.reloadData()
            
        }
        
        textField.resignFirstResponder()
        inputView.removeFromSuperview()
    }
}

extension HomeViewController: StoryboardInstantiable {

    static var storyboardName: String {
    
        return String(describing: self)
    }
}
