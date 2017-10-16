//
//  TodoListViewController.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/14.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class TodoListViewController: UIViewController {

    
    fileprivate var todoLists: Results<Todo> {
        
        let realm = try! Realm()
        return realm.objects(Todo.self).filter("category == %@", self.category)
    }
    
    var indicatorTitle: String!
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet private dynamic weak var tableView: UITableView! {
     
        didSet{
        
            self.tableView.delegate = self
            self.tableView .dataSource = self
            self.tableView.register(TodoListTableViewCell.self)
        }
    }
    
    public func reloadData(){
     
        self.tableView.reloadData()
    }
    
    
}




extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.todoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TodoListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.content = "cell \(indexPath)"
        cell.todo = self.todoLists[indexPath.row]
        cell.backgroundColor = indexPath.row % 2 == 0 ? .green : .orange
        return cell
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row % 2 == 0 ? 30 : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension TodoListViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    
        return IndicatorInfo(title: self.category)
    }
}

extension TodoListViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        
        return String(describing: self)
    }
}
