//
//  LoginHandler.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class LoginHandler: NSObject {
    class func login() {
        //检查iCloud是否可用
        if ICloud.instance.isIcloudAvailable() {
            //获取当前用户的RecordId
            ICloudPostUser.fetchUserRecordID({ (userRecordID, error) in
                guard let ownerRecordID = userRecordID else {
                    print("fetch user recordId failed")
                    return
                }
                
                //根据RecordId查询用户信息
                ICloudPostUser.fetchUser(ownerRecordID, completionCallback: { (user) in
                    
                    if let user = user { //已存在
                        print("user:\(user)")
                        user.name = "updateUser2"
                        
                        //更新用户信息
                        ICloudPostUser.updateRecord(ownerRecordID, user: user, completionCallback: { (status) in
                            print("update user status: \(status == true ? "YES":"NO")")
                        })
                    } else { //不存在
                        let u = User(sid: ownerRecordID.recordName, name: "newUser", avatar: "http://www.appcoda.com/wp-content/uploads/2016/01/beginner-ios9-book-400.jpg")
                        //添加新用户
                        ICloudPostUser.newUser(u, completionCallback: { (status) in
                            print("create user status:\(status == true ? "YES":"NO")")
                        })
                    }
                })

            })
        }
    }
}
