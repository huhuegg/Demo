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
    var starLayer:CAShapeLayer!
    
    override func initView() {
        self.view.backgroundColor = UIColor.orange()
        self.navigationController?.navigationBar.isHidden = false
        self.title = self.className()
        
        menuButtonView = MenuButtonView(frame: CGRect(x: 50, y: 100, width: 36, height: 36))
        self.view.addSubview(menuButtonView!)
        
        drawStar()
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

private extension TestAnimationController {
    func drawStar() {
        //PaintCode工具可以自动生成bezier代码
        
        //path
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x:101, y:124.5))
        starPath.addLine(to: CGPoint(x:106.47, y:132.48))
        starPath.addLine(to: CGPoint(x:115.74, y:135.21))
        starPath.addLine(to: CGPoint(x:109.84, y:142.87))
        starPath.addLine(to: CGPoint(x:110.11, y:152.54))
        starPath.addLine(to: CGPoint(x:101, y:149.3))
        starPath.addLine(to: CGPoint(x:91.89, y:152.54))
        starPath.addLine(to: CGPoint(x:92.16, y:142.87))
        starPath.addLine(to: CGPoint(x:86.26, y:135.21))
        starPath.addLine(to: CGPoint(x:95.53, y:132.48))
        starPath.close()
        
        //animation
        let starDrawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        starDrawAnimation.fromValue = 0
        starDrawAnimation.toValue = 1
        
        let starOpacityAnimation  = CABasicAnimation(keyPath: "opacity")
        starOpacityAnimation.fromValue = 0
        starOpacityAnimation.toValue = 1
        
        let starGroupAnimation = CAAnimationGroup()
        starGroupAnimation.animations = [starDrawAnimation,starOpacityAnimation]
        starGroupAnimation.duration = 1
        
        
        //layer
        starLayer = CAShapeLayer()
        starLayer.fillColor = UIColor.green().cgColor
        starLayer.strokeColor = UIColor.white().cgColor
        starLayer.lineWidth = 2.0
        starLayer.path = starPath.cgPath

        starLayer.add(starGroupAnimation, forKey: nil)
        
        self.view.layer.addSublayer(starLayer)
    }
}
