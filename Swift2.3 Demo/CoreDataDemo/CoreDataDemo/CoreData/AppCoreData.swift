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

enum CoreDataDB {
    case local
    case icloud
}

enum CoreDataEntity {
    case user
}

class AppCoreData: NSObject {
    private static let appCoreDataInstance = AppCoreData()

    static let instance:AppCoreData = {
        return appCoreDataInstance
    }()
    
    private var dbName:String = "coreDataDB"
    private var icloudName:String = "iCloudCoreDataDB"
    
    private var iCloudContainer:String = "iCloud.\(NSBundle.mainBundle().bundleIdentifier!)"
    
    var localDB:CoreDataDefaultStorage?
    var icloudDB:CoreDataiCloudStorage?
    
    override init() {
        super.init()
        localDB = coreDataStorage()
//        if isIcloudDocumentsEnabled() {
//            icloudDB = icloudStorage()
//        }
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
        let icloudConfig = ICloudConfig(ubiquitousContentName: icloudName, ubiquitousContentURL: "path/", ubiquitousContainerIdentifier: iCloudContainer)

        do {
            return try CoreDataiCloudStorage(model: model, iCloud: icloudConfig)
        } catch {
            print("CoreDataiCloudStorage init failed")
            return nil
        }
    }

    func isIcloudDocumentsEnabled()->Bool {
        if let _ = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(iCloudContainer) {
            return true
        } else {
            return false
        }
    }
    
    func db(type:CoreDataDB)->Storage? {
        switch type {
        case .local:
            return localDB
        case .icloud:
            return icloudDB
        }
    }
    
    private class func entityClass(coreDataEntity:CoreDataEntity) -> AnyClass {
        switch  coreDataEntity {
        case .user:
            return UserEntity.classForCoder()
        default:
            return NSManagedObject.classForCoder()
        }
    }
    
}


