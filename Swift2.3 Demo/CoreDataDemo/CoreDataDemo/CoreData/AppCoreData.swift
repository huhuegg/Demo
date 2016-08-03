//
//  AppCoreData.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import CoreData
import SugarRecord

class AppCoreData: NSObject {
    private static let appCoreDataInstance = AppCoreData()

    static let instance:AppCoreData = {
        return appCoreDataInstance
    }()
    
    private var dbName:String = "coreDataDB"
    
    var db:CoreDataDefaultStorage!
    var icloudDb:CoreDataiCloudStorage?
    
    override init() {
        super.init()
        db = coreDataStorage()
    }

    // Initializing CoreDataDefaultStorage
    func coreDataStorage() -> CoreDataDefaultStorage {
        let store = CoreData.Store.Named(dbName)
        let bundle = NSBundle(forClass: self.classForCoder)
        let model = CoreData.ObjectModel.Merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        return defaultStorage
    }
    
    // Initializes the CoreDataiCloudStorage
    func icloudStorage() -> CoreDataiCloudStorage? {
        let bundle = NSBundle(forClass: self.classForCoder)
        let model = CoreData.ObjectModel.Merged([bundle])
        let icloudConfig = ICloudConfig(ubiquitousContentName: dbName, ubiquitousContentURL: "Path/", ubiquitousContainerIdentifier: "com.company.MyApp.anothercontainer")
        
        do {
            return try CoreDataiCloudStorage(model: model, iCloud: icloudConfig)
        } catch {
            return nil
        }
    }
}

//MARK:- User
extension AppCoreData {
    func insertUser(user:User) {
        print("## CoreData ## insertDemoModel")
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
    
    func fetchUsers(completedHandler:(users:Array<User>?)->()) {
        print("## CoreData ## fetchAllUsers")
        try! db.operation({ (context, save) -> () in
            let entities = try! context.request(UserEntity.self).fetch()
            var users:Array<User> = Array()
            for entity in entities {
                let user = entity.convertToModel()
                users.append(user)
            }
            completedHandler(users: users)
        })

    }
    
    func findUser(filter:String,value:String,completedHandler:(user:User?)->()) {
        print("## CoreData ## findUser: \(filter)=\(value)")
        try! db.operation({ (context, save) -> () in
            var user:User?
            if let entity = try! context.request(UserEntity.self).filteredWith(filter, equalTo: value).fetch().first {
                user = entity.convertToModel()
            }
            completedHandler(user: user)
        })
    }
}

//MARK:- Other
extension AppCoreData {
    
}

