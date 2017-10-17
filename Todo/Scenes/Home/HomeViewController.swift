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
        
        let pink = UIColor(red: 1, green: 160/255, blue: 167/255, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = .white
        self.settings.style.selectedBarBackgroundColor = pink
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(white: 0.6, alpha: 0.6)
            newCell?.label.textColor = UIColor(white: 0.6, alpha: 1)
            
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
        self.textView.frame.size = CGSize(width: view.frame.width, height: 40)
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
            child.category = categoy.category_name
            childView.append(child)
        }
        
        return childView
        
    }
    
    //MARK: fileprivate
    
    //    fileprivate var categories: [String] = ["todoA", "todoB", "todoC"]
    
    fileprivate var categories: Results<Category> {
        
        let realm = try! Realm()
        return realm.objects(Category.self)
    }
    //MARK: private
    
    @IBAction dynamic private func button(_ sender: UIButton){
        
        self.textView.frame.origin = CGPoint(x: 0, y: view.frame.height)
        self.view.addSubview(textView)
        self.textView.textField.becomeFirstResponder()
        
    }
    
    @IBAction dynamic private func createNewTab(){
        
        self.showAVwithTextField()
    }
    
    //コメントを入力するalertViewを表示する
    
    func showAVwithTextField(){
        
        let alert = UIAlertController(title: "新規タブ作成", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "作成", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            if let categoryName = alert.textFields?[0].text {
                print(categoryName)
                let category = Category(categoryName)
                RealmModel.instance.write(category)
                self.reloadPagerTabStripView()
            }
            
        })
        
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField(configurationHandler: { (textField:UITextField) in
            
            textField.placeholder = "タブ名を入力"
        })
        present(alert, animated: true, completion: nil)
        
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
            
            let todo = Todo(self.categories[currentIndex].category_name ,outline: textField.text!)
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
