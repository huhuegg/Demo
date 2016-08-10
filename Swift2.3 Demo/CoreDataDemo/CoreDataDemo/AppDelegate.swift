//
//  AppDelegate.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/2.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    func coreDataTest() {
        //MARK:- 本地CoreData测试
        
        //清空user
        UserEntity.clear()
        
        //添加测试数据
        for i in 1..<10 {
            let user = User(sid: "\(i)", name: "name\(i)", avatar: "http://www.appcoda.com/wp-content/uploads/2016/01/beginner-ios9-book-400.jpg")
            UserEntity.insert(user)
        }
        
    }
    
    
    func cloudKitTest() {
        //CloudKit测试
        ICloud.instance.isIcloudAvailable()
        
        //publicDB
        ICloud.instance.fetchUserRecordID { (userRecordID, error) in
            if let userRecordID = userRecordID {
                ICloudUser.fetchFromPublicDB(userRecordID, completionCallback: { (users) in
                    if let users = users {
                        print("fetchFromPublicDB userRecordName:\(userRecordID.recordName) count: \(users.count)")
                        for user in users {
                            print("sid:\(user.sid) name:\(user.name) info:\(user.info)")
                        }
                    }
                    
                })
            }
        }
        
        let newPublicUser = User(sid: "i3", name: "insertToPublic", avatar: "http://www.appcoda.com/wp-content/uploads/2016/01/beginner-ios9-book-400.jpg")
        ICloudUser.addUser(newPublicUser, isPrivate: false) { (status) in
            ICloudUser.fetchInfoIs("iCloud", isPrivate: false, completionCallback: { (users) in
                if let users = users {
                    print("public user count: \(users.count)")
                    for user in users {
                        print("sid:\(user.sid) name:\(user.name) info:\(user.info)")
                    }
                }
            })
        }
        
        //privateDB
        let newPrivateUser = User(sid: "i51", name: "insertToPrivate111", avatar: "http://www.appcoda.com/wp-content/uploads/2016/01/beginner-ios9-book-400.jpg")
        ICloudUser.addUser(newPrivateUser, isPrivate: true) { (status) in
            
            ICloudUser.fetchInfoIs("iCloud", isPrivate: true, completionCallback: { (users) in
                if let users = users {
                    print("private user count: \(users.count)")
                    for user in users {
                        print("sid:\(user.sid) name:\(user.name) info:\(user.info)")
                    }
                }
            })
        }

    }
}