//
//  DemoEntity.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class DemoEntity: NSObject {
    let sid:String
    let name:String
    let info:String
    
    init(object:DemoObject) {
        self.sid = object.sid!
        self.name = object.name!
        self.info = object.info!
    }
}
