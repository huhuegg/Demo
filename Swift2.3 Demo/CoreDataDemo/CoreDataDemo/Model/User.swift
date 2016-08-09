//
//  DemoModel.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class User: NSObject {
    var sid:String!
    var name:String!
    var info:String!

    var imageUrl:String = "http://www.appcoda.com/wp-content/uploads/2016/01/beginner-ios9-book-400.jpg"
    
    init(sid:String,name:String,info:String) {
        super.init()
        self.sid = sid
        self.name = name
        self.info = info
    }
}


