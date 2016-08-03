//
//  AppCoreData.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import CoreData
//import SugarRecordCoreData

class AppCoreData: NSObject {
    private static let appCoreDataInstance = AppCoreData()

    static let instance:AppCoreData = {
        return appCoreDataInstance
    }()
    
//    private var dbName:String = "Demo"
//    
//    var db:CoreDataDefaultStorage!
//    
//    override init() {
//        super.init()
//        db = coreDataStorage()
//    }
//
//    
//    
//    // Initializing CoreDataDefaultStorage
//    func coreDataStorage() -> CoreDataDefaultStorage {
//        let store = CoreData.Store.Named(dbName)
//        let bundle = NSBundle(forClass: self.classForCoder())
//        let model = CoreData.ObjectModel.Merged([bundle])
//        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
//        return defaultStorage
//    }
//    
//    // Initializes the CoreDataiCloudStorage
//    func icloudStorage() -> CoreDataiCloudStorage {
//        let bundle = NSBundle(forClass: self.classForCoder())
//        let model = CoreData.ObjectModel.Merged([bundle])
//        let icloudConfig = iCloudConfig(ubiquitousContentName: dbName, ubiquitousContentURL: "Path/", ubiquitousContainerIdentifier: "com.company.MyApp.anothercontainer")
//        return CoreDataiCloudStorage(model: model, iCloud: icloudConfig)
//    }
}

extension AppCoreData {
    func insert(object:DemoModel) {

    }
}


