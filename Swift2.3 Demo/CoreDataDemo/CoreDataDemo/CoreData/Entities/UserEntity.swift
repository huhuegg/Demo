//
//  UserEntity.swift
//  
//
//  Created by admin on 16/8/3.
//
//

import Foundation
import CoreData
import SugarRecord

class UserEntity: NSManagedObject {
    
    func convertFromModel(model:User) {
        self.sid = model.sid
        self.name = model.name
        self.info = model.info
    }
    
    func convertToModel()->User {
        let user = User(sid: self.sid!, name: self.name!, avatar: self.info!)
        return user
    }

}

extension UserEntity {
    /**
     从CoreData清除所有用户数据
     */
    class func clear() {
        print("## CoreData ## cleanUsers")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        
        do {
            try db.operation({ (context, save) -> () in
                let entities = try! context.request(UserEntity.self).fetch()
                try! context.remove(entities)
            })
        } catch {
            
        }
    }
    
    /**
     向CoreData添加新用户
     */
    class func insert(user:User) {
        print("## CoreData ## insertUser(sid:\(user.sid))")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        do {
            try db.operation({ (context, save) -> () in
                let entity:UserEntity = try! context.new()
                entity.convertFromModel(user)
                try! context.insert(entity)
                save()
            })
        } catch {
            
        }
    }
    
    /**
     从CoreData中删除指定id的用户
     */
    class func remove(sid:String) {
        print("## CoreData ## removeUser")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        do {
            try db.operation({ (context, save) -> () in
                if let entity = try! context.request(UserEntity.self).filteredWith("sid", equalTo: sid).fetch().last {
                    try! context.remove(entity)
                    save()
                }
            })
        } catch {
            
        }
    }
    
    /**
     根据查询条件修改用户名
     */
    class func change(predicate:NSPredicate, name:String) {
        print("## CoreData ## changeUserName")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        
        do {
            try db.operation({ (context, save) -> () in
                let entites = try context.request(UserEntity).filteredWith(predicate: predicate).fetch()
                for entity in entites {
                    entity.name = name
                }
                save()
            })
        } catch {
            
        }
    }
    
    /**
     在CoreData中按照查询条件查询用户
     */
    class func find(filter:String,value:String,completedHandler:(user:User?)->()) {
        print("## CoreData ## findUser: \(filter)=\(value)")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        try! db.operation({ (context, save) -> () in
            var user:User?
            if let entity = try! context.request(UserEntity.self).filteredWith(filter, equalTo: value).fetch().first {
                user = entity.convertToModel()
            }
            completedHandler(user: user)
        })
    }
    
    
    
    /**
     从CoreData中获取完整用户列表(按name降序)
     */
    class func fetchUsersOrderByNameDESC(completedHandler:(users:Array<User>?)->()) {
        print("## CoreData ## fetchUsers")
        guard let db = AppCoreData.instance.db(CoreDataDB.local) else {
            return
        }
        
        do {
            let entites = try db.request(UserEntity.self).sortedWith("name", ascending: false).fetch()
            var users:Array<User> = Array()
            for entity in entites {
                let user = entity.convertToModel()
                users.append(user)
            }
            completedHandler(users: users)

        } catch {
            completedHandler(users: nil)
        }
    }
    
}
