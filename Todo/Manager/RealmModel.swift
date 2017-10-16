//
//  RealmModel.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/15.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import Foundation
import RealmSwift

class RealmModel {
    
    static let instance = RealmModel()
    
    private var realm = try! Realm()
    
    func write(_ object: Object) {
        
        do{
            try self.realm.write {
                
                realm.add(object)
            }
            
        } catch {
            
        }
    }
    
    func write(_ object: Object, update: Bool) {
        
        do{
            try self.realm.write {
                
                realm.add(object, update: true)
            }
            
        } catch {
            
        }
    }
    
    func get() {
    
        
    }
    
    fileprivate var favoriteJobs: Results<Object> {
        
        let realm = try! Realm()
        return realm.objects(Object.self)
    }
    
    
}
