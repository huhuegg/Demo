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
    
    /**
     获取当前用户的CKRecordID
     */
    func fetchUserRecordID(completionCallback:(userRecordID:CKRecordID?,error:NSError?)->()) {
        container.fetchUserRecordIDWithCompletionHandler { (userRecordID, err) in
            if let err = err {
                if err.code == CKErrorCode.NotAuthenticated.rawValue {
                    print("fetchUserRecordID failed: NotAuthenticated")
                } else {
                    print("fetchUserRecordID failed: \(err)")
                }
            }
            completionCallback(userRecordID: userRecordID, error: err)
        }
    }
    
    /**
     检查iCloud是否可用
    */
    func isIcloudAvailable() -> Bool{
        //ubiquityIdentityToken is a new thing introduced by Apple to allow apps to check if the user is logged into icloud
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken{
            print("icloud avaliable")
            return true
        } else {
            print("icloud unavaliable")
            return false
        }
    }
    
    class func printRecordInfo(record:CKRecord) {

//        let recordName = record.recordID.recordName
//        let recordZoneName = record.recordID.zoneID.zoneName
//        let recordOwnerName = record.recordID.zoneID.ownerName
        
        let creatorUserRecordName = record.creatorUserRecordID!.recordName
        let creationDate = record.creationDate!
        
        let lastModifiedUserRecordName = record.lastModifiedUserRecordID!.recordName
        let lastModificationDate = record.modificationDate!

        //print("recordName:\(recordName) recordZoneName:\(recordZoneName) recordOwnerName:\(recordOwnerName) creatorUserRecordName:\(creatorUserRecordName) creationDate:\(creationDate) lastModifiedUserRecordName:\(lastModifiedUserRecordName) lastModificationDate:\(lastModificationDate)")
        print("creatorUserRecordName:\(creatorUserRecordName) creationDate:\(creationDate) lastModifiedUserRecordName:\(lastModifiedUserRecordName) lastModificationDate:\(lastModificationDate)")
    }
    
    
}


class ICloudUser: NSObject {
    
    /**
     根据CKRecordID查询
    */
    class func fetchFromPublicDB(userRecordID:CKRecordID,completionCallback:(users:Array<User>?)->()) {
        let recordType = "ICloudUserEntity"
        
        let reference = CKReference(recordID: userRecordID, action: .None)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        
        // CKQuery 对象的创建需要一个record类型和一个判定条件作为参数，它们将用于查询
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        let db = ICloud.instance.publicDB
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
                    ICloud.printRecordInfo(icloudEntity)
                    
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
    
    /**
     根据info信息查询匹配的User
    */
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
                    ICloud.printRecordInfo(icloudEntity)
                    
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
    
    //添加User
    class func addUser(user:User,isPrivate:Bool,completionCallback:(status:Bool)->()) {
        let recordType = "ICloudUserEntity"
        let recordName = String(format: "%f", NSDate.timeIntervalSinceReferenceDate()).componentsSeparatedByString(".")[0]
        let recordID = CKRecordID(recordName: recordName)
        
        let entity = CKRecord(recordType: recordType, recordID: recordID)
        
        entity.setObject(user.sid, forKey: "sid")
        entity.setObject(user.name, forKey: "name")
        entity.setObject(user.info, forKey: "info")
        
        if let imageUrl = NSURL(string: user.imageUrl) {
            //实际使用中需要改为异步获取data
            if let data = NSData(contentsOfURL: imageUrl) {
                // 获取Caches目录路径
                var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                if let cacheDirectory = paths[0] as? String {
                    let filePath = "\(cacheDirectory)/\(data.MD5())"
                    data.writeToFile(filePath, atomically: true)
                    
                    //注意使用 NSURL(fileURLWithPath: filePath) 而不是NSURL(string: filePath) 否则会有以下错误
                    //*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Non-file URL'
                    let fileUrl = NSURL(fileURLWithPath: filePath)
                    
                    //CKAsset必须使用本地的file url
                    let imageAsset = CKAsset(fileURL: fileUrl)
                    entity.setObject(imageAsset, forKey: "imageUrl")

                }

            }

        }
        
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
    
    /**
     更新User信息
    */
    class func updateUser(user:User,isPrivate:Bool,completionCallback:(status:Bool)->()) {
        let recordType = "ICloudUserEntity"
        let predicate = NSPredicate(format: "sid == %@", user.sid)
        
        // CKQuery 对象的创建需要一个record类型和一个判定条件作为参数，它们将用于查询
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        let db = isPrivate == true ? ICloud.instance.privateDB : ICloud.instance.publicDB
        db.performQuery(query, inZoneWithID: nil) { (icloudEntities, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completionCallback(status: false)
                }
            } else {
                guard let icloudEntities = icloudEntities else {
                    completionCallback(status: false)
                    return
                }

                for icloudEntity in icloudEntities {
                    icloudEntity.setValue(user.name, forKey: "name")
                    icloudEntity.setValue(user.info, forKey: "info")
                    db.saveRecord(icloudEntity, completionHandler: { (savedRecord, error) in
                        if error == nil {
                            completionCallback(status: true)
                        } else {
                            completionCallback(status: false)
                        }
                        return
                    })
                }
                completionCallback(status: false)
                return
            }
        }
    }
}
