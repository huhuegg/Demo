//
//  ImageExifController.swift
//  Demo
//
//  Created by admin on 16/8/25.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework

import ImageIO

class ImageExifController: SimpleController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let url = "http://b.doodduck.com/testExif.jpeg"
        debugExif(url: url)
    }
    
    override func initView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //从iOS7开始，系统为UINavigationController提供了一个interactivePopGestureRecognizer用于右滑返回(pop),但是，如果自定了back button或者隐藏了navigationBar，该手势就失效了,需要自行添加
        self.addRecognizerOnNavigationController()

        self.title = self.className()
        
    }

}

extension ImageExifController {
    func debugExif(url:String) {
        let url = NSURL(string: url)
        let imageSource = CGImageSourceCreateWithURL(url!, nil)
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil)! as NSDictionary;
        
        print("imageExif:\(imageProperties["{Exif}"])")
        print("imageGPS:\(imageProperties["{GPS}"])")
        
//        let exifDict = imageProperties.value(forKey: "{Exif}")  as! NSDictionary;
//        print("ExifDict:\(exifDict)")
        
//        
//        let dateTimeOriginal = exifDict.value(forKey: "DateTimeOriginal") as! NSString;
//        print ("DateTimeOriginal: \(dateTimeOriginal)");
//        
//        let lensMake = exifDict.value(forKey: "LensMake");
//        print ("LensMake: \(lensMake)");
    }
}

