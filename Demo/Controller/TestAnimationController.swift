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
    
    var penRecognizer:UIPanGestureRecognizer?
    
    override func initView() {
        self.view.backgroundColor = UIColor.orange()
        self.navigationController?.navigationBar.isHidden = false
        self.title = self.className()
        
        menuButtonView = MenuButtonView(frame: CGRect(x: 50, y: 100, width: 36, height: 36))
        self.view.addSubview(menuButtonView!)
        
        setupGestureRecognizers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeGestureRecognizers()
    }
}

//MARK:- UIGestureRecognizerDelegate
extension TestAnimationController:UIGestureRecognizerDelegate {
    
    func setupGestureRecognizers() {
        
        penRecognizer = UIPanGestureRecognizer(target: self, action: #selector(TestAnimationController.penRecognizer(recognizer:)))
        penRecognizer!.delegate = self
        self.view.addGestureRecognizer(penRecognizer!)
        
    }
    
    func removeGestureRecognizers() {
        self.view.removeGestureRecognizer(penRecognizer!)
    }
    
    
    func penRecognizer(recognizer: UIPanGestureRecognizer) {

    }
}
