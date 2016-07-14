//
//  TestAnimationController.swift
//  Demo
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework

class TestAnimationController: SimpleController {
    
    var menuButtonView:MenuButtonView?
    
    override func initView() {
        self.view.backgroundColor = UIColor.orange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuButtonView = MenuButtonView(frame: CGRect(x: 50, y: 100, width: 36, height: 36))
        self.view.addSubview(menuButtonView!)
    }
}
