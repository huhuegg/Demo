//
//  TestSwiftFramework.swift
//  SwiftFramework
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

public class TestSwiftFramework: NSObject {
    public class func hello() {
        if let ocHello = TestOCFramework.hello() {
            print("TestSwiftFramework.hello load oc framework: \(ocHello)")
        } else {
            print("TestSwiftFramework load OCFramework failed")
        }
    }
}
