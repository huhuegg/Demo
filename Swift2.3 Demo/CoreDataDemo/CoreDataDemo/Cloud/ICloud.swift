//
//  ICloud.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/8.
//  Copyright © 2016年 egg. All rights reserved.
//

import CloudKit

/**
 需要IOS8以上
 */


class ICloud {
    private static let icloudInstance = ICloud()
    
    static let instance:ICloud = {
        return icloudInstance
    }()
    
    
    let container:CKContainer
    let publicDB:CKDatabase
    let privateDB:CKDatabase
    
    init() {
        // defaultContainer()代表的是在iCloud功能栏里制定的那个容器
        container = CKContainer.defaultContainer()
        // publicCloudDatabase则是应用上的所有用户共享的数据
        publicDB = container.publicCloudDatabase
        // privateCloudDatabase是你个人的私密数据
        privateDB = container.privateCloudDatabase
    }
}


class ICloudUser: NSObject {
    class func fetchInfoIs(info:String,isPrivate:Bool,completionCallback:(users:Array<User>?)->()) {
        let recordType = "ICloudUserEntity"
        let predicate = NSPredicate(format: "info == %@", info)
        
        // CKQuery 对象的创建需要一个record类型和一个判定条件作为参数，它们将用于查询
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        let db = isPrivate == true ? ICloud.instance.privateDB : ICloud.instance.publicDB
        db.performQuery(query, inZoneWithID: nil) { (icloudEntities, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completionCallback(users: nil)
                }
            } else {
                guard let icloudEntities = icloudEntities else {
                    completionCallback(users: nil)
                    return
                }
                var users:Array<User> = Array()
                for icloudEntity in icloudEntities {
                    let sid = icloudEntity.valueForKey("sid") as! String
                    let name = icloudEntity.valueForKey("name") as! String
                    let info = icloudEntity.valueForKey("info") as! String
                    
                    let user = User(sid: sid, name: name, info: info)
                    users.append(user)
                }
                completionCallback(users: users)
                return
            }
        }
    }
    
    class func addUser(user:User,isPrivate:Bool,completionCallback:(status:Bool)->()) {
        let recordType = "ICloudUserEntity"
        let recordName = String(format: "%f", NSDate.timeIntervalSinceReferenceDate()).componentsSeparatedByString(".")[0]
        let recordID = CKRecordID(recordName: recordName)
        
        let entity = CKRecord(recordType: recordType, recordID: recordID)
        
        entity.setObject(user.sid, forKey: "sid")
        entity.setObject(user.name, forKey: "name")
        entity.setObject(user.info, forKey: "info")
        
        let db = isPrivate == true ? ICloud.instance.privateDB : ICloud.instance.publicDB
        db.saveRecord(entity) { (record, error) in
            if error != nil {
                print("addUser failed:\(error!)")
                completionCallback(status: false)
                return
            } else {
                completionCallback(status: true)
                return
            }
        }
    }
}
