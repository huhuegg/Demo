//
//  DemoObject.swift
//  Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import CoreData

class DemoObject: NSManagedObject {
    @NSManaged var sid:String?
    @NSManaged var name:String?
    @NSManaged var info:String?
    
}
