//
//  MD5.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

extension NSData {
    func MD5() -> String {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let md5Buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        
        CC_MD5(bytes, CC_LONG(length), md5Buffer)
        var output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        for i in 0..<digestLength {
            output.appendFormat("%02x", md5Buffer[i])
        }
        
        return String(NSString(format: output))
    }
}

extension NSString {
    func MD5() -> String {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let md5Buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        CC_MD5(UTF8String, CC_LONG(strlen(UTF8String)), md5Buffer)
        
        var output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        for i in 0..<digestLength {
            output.appendFormat("%02x", md5Buffer[i])
        }
        
        return String(NSString(format: output))
    }
}