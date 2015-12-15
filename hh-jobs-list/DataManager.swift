//
//  DataManager.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import RealmSwift

typealias DataManagerClosure = ([AnyObject]?) -> Void
final class DataManager: Singletonable, Crudable {
    
    enum Action { case Create, Update, Delete }
    
    // MARK: Private properties
    private let _db: Realm = try! Realm()
    
    // Singleton
    static var shared: DataManager = DataManager()
    
    // MARK: Public Methods
    // FIXME: Remove this stub. Some how)
    func read(id: String) -> Object? {
        return nil
    }
    
    func read(type: Object.Type) ->  Results<Object>{
        return _db.objects(type)
    }
    
    func create(model: Object) {
        action(model, action: DataManager.Action.Create)
    }
    
    func update(model: Object) {
        action(model, action: DataManager.Action.Update)
    }
    
    func delete(model: Object) {
        action(model, action: DataManager.Action.Delete)
    }
    
    func drop(type: Object.Type) {
        query { _ in
            let objects = self.read(type)
            self._db.delete(objects)
        }
    }
    
    // MARK: Private Methods
    private func action(model: Object, action: DataManager.Action) {
        var closure: DataManagerClosure
        switch action {
        case .Create, .Update:
            closure = { _ in
                self._db.add(model)
            }
        case .Delete:
            closure = { _ in
                self._db.delete(model)
            }
        }
        query(closure)
    }
    
    func query(closure: DataManagerClosure) {
        do {
            try self._db.write {
                closure(nil)
            }
        } catch let e as NSError {
            Log.e(e)
        }
    }
}