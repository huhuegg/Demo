//
//  DemoModel.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class DemoModel: NSObject {
    var sid:String!
    var name:String!
    var info:String!

    var imageUrl:String = ""
    
    init(sid:String,name:String,info:String) {
        super.init()
        self.sid = sid
        self.name = name
        self.info = info
    }
}

extension DemoModel {
    func converToDemoObject()->DemoObject {
        return DemoObject
    }
}
