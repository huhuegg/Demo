//
//  SideBarView.swift
//  Demo
//
//  Created by admin on 16/7/7.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import QuartzCore

protocol SideBarViewProtocol {
    func sideBarProgress(isOpen:Bool,edges:UIRectEdge,progress:CGFloat)
    //已打开
    func isShowed()
    //已关闭
    func isHidden()
    //回传数据
    func sideBarRoute(data:Dictionary<String,AnyObject>)
}

class SideBarView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var testButton1: UIButton!
    @IBOutlet weak var testButton2: UIButton!
    
    
    var delegate:SideBarViewProtocol?
    var parent:UIView?
    
    var openSideBarRecognizer:UIScreenEdgePanGestureRecognizer?
    var openEdges:UIRectEdge = .left
    var closeSideBarRecognizer:UIPanGestureRecognizer?
    var closeEdges:UIRectEdge = .right
    
    var widthPercent:CGFloat = 1.0
    
    var isShow:Bool = false
    
    let dWidth = UIScreen.main().bounds.width
    let dHeight = UIScreen.main().bounds.height
    
    //方向，宽度
    class func addSideBar(parentCtl:UIViewController,edges:UIRectEdge,widthPercent:CGFloat)->SideBarView? {
        print("addSideBar")
        guard  edges == .left || edges == .right else {
            print("SideBar edges must left or right")
            return nil
        }
        
        let v = self.instanceFromNib()
        
        if let p = parentCtl as? SideBarViewProtocol {
            v.delegate = p
        }
        
        v.parent = parentCtl.view
        v.openEdges = edges
        v.widthPercent = widthPercent
        
        v.closeEdges = v.openEdges == UIRectEdge.left ? UIRectEdge.right : UIRectEdge.left
       
        v.parent!.addSubview(v)
        
        v.setupFrame()
        
        v.setupGestureRecognizers()

        return v
    }
    
    func initView(data:Dictionary<String,AnyObject>?) {
        self.backgroundColor = UIColor.yellow()
        
        testButton1.addTarget(self, action: .testButton1Clicked, for: UIControlEvents.touchUpInside)
        testButton2.addTarget(self, action: .testButton2Clicked, for: UIControlEvents.touchUpInside)
    }
    
    func removeSideBar() {
        self.removeGestureRecognizers()
        self.removeFromSuperview()
    }
    
    func setupFrame() {
//        print("setupFrame")
        let width = dWidth * widthPercent
        if openEdges == .left {
            self.frame = CGRect(x: -width, y: 0, width: width, height: dHeight)
        } else {
            self.frame = CGRect(x: dWidth + width, y: 0, width: width, height: dHeight)
        }
        
        self.layer.shadowOpacity = 0.6 // 阴影透明度
        self.layer.shadowColor = UIColor.gray().cgColor // 阴影的颜色
        
        self.layer.shadowRadius = 6;// 阴影扩散的范围控制
        
        self.layer.shadowOffset = CGSize(width: 3, height: 3) // 阴影的范围

    }
}

//MARK:- Selector
private extension Selector {
    static let testButton1Clicked = #selector(SideBarView.testButton1Clicked)
    static let testButton2Clicked = #selector(SideBarView.testButton2Clicked)
}
//MARK:- Action
extension SideBarView {
    func testButton1Clicked() {
        self.delegate?.sideBarRoute(data: ["key":"testButton1Clicked"])
    }
    
    func testButton2Clicked() {
        self.delegate?.sideBarRoute(data: ["key":"testButton2Clicked"])
    }
}

extension SideBarView {
    private class func instanceFromNib()->SideBarView {
        if let v = UIView.loadFromNibNamed(nibNamed: "SideBarView") as? SideBarView {
            return v
        }
        return SideBarView()
    }
    
    func openChanged(edges:UIRectEdge,progress:CGFloat) {
        if edges == .left {
            let x = (progress - 1) * self.frame.width
            print("XXXXXX edges: .left  x:\(x) progress:\(progress)")
            self.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            
            let x = dWidth - progress * self.frame.width
//            print("XXXXXX edges: .right x:\(x) progress:\(progress)")
            self.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
        }
    }
    
    func openCancelled(edges:UIRectEdge)->CGRect? {
        var rect:CGRect?
        if edges == .left {
            rect = CGRect(x: -self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            rect = CGRect(x: dWidth + self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
        }
//        print("cancelled:\(rect)")
        return rect
    }
    
    func openCompleted(edges:UIRectEdge)->CGRect? {
        var rect:CGRect?
        if edges == .left {
            rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            rect = CGRect(x: dWidth - self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
            
        }
//        print("completed:\(rect)")
        return rect
    }
    
    func closeChanged(edges:UIRectEdge,progress:CGFloat) {
        if edges == .left {
            let x = dWidth + (progress - 1) * self.frame.width
//            print("XXXXXX edges: .left  x:\(x) progress:\(progress)")
            self.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            
            let x = -progress * self.frame.width
//            print("XXXXXX edges: .right x:\(x) progress:\(progress)")
            self.frame = CGRect(x: x, y: 0, width: self.frame.width, height: self.frame.height)
        }
    }
    
    func closeCancelled(edges:UIRectEdge)->CGRect? {
        var rect:CGRect?
        if edges == .left {
            rect = CGRect(x: dWidth - self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
//        print("cancelled:\(rect)")
        return rect
    }
    
    func closeCompleted(edges:UIRectEdge)->CGRect? {
        var rect:CGRect?
        if edges == .left {
            rect = CGRect(x: dWidth, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            rect = CGRect(x: -self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
            
        }
//        print("completed:\(rect)")
        return rect
    }
}
    
extension SideBarView:UIGestureRecognizerDelegate {
    
    func setupGestureRecognizers() {
//        print("setupGestureRecognizer")
        
        openSideBarRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SideBarView.openSideBarRecognizer(recognizer:)))
        openSideBarRecognizer!.edges = openEdges
        openSideBarRecognizer!.delegate = self
        parent!.addGestureRecognizer(openSideBarRecognizer!)
        
//        closeSideBarRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SideBarView.closeSideBarRecognizer(recognizer:)))
//        closeSideBarRecognizer!.edges = openEdges == UIRectEdge.left ? UIRectEdge.right : UIRectEdge.left
//        closeSideBarRecognizer!.delegate = self
//        parent.addGestureRecognizer(closeSideBarRecognizer!)
//        
        
        closeSideBarRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SideBarView.closeSideBarRecognizer(recognizer:)))
        closeSideBarRecognizer!.delegate = self
        self.addGestureRecognizer(closeSideBarRecognizer!)
        
    }
    
    func removeGestureRecognizers() {
        self.parent?.removeGestureRecognizer(openSideBarRecognizer!)
        self.removeGestureRecognizer(closeSideBarRecognizer!)
    }
    
    func openSideBarRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        guard isShow == false else {
//            print("SideBar already show")
            return
        }

        // 获取手势在屏幕横屏范围的滑动百分比，并控制在0.0 - 1.0之间
        var x:CGFloat = 0
        
        if openEdges == .left {
            x = recognizer.translation(in: self).x
        } else {
            x = 1 - recognizer.translation(in: self).x
        }
        var progress = x / self.bounds.width
        progress = min(1.0, max(0.0, progress))
        self.delegate?.sideBarProgress(isOpen: true, edges: openEdges, progress: progress)
        
        print("openSideBarRecognizer edges:\(openEdges == .left ? ".left" : ".right") offsetX:\(x)  progress:\(progress)")
        
        switch recognizer.state {
        case .began:
//            print("showSideBar: began")
            self.openChanged(edges: openEdges, progress: progress)
        case .changed:  // 滑动过程中，根据在屏幕上滑动的百分比更新状态
//            print("showSideBar: changed")
            self.openChanged(edges: openEdges, progress: progress)
        case .ended, .cancelled:    // 滑动结束或取消
//            print("showSideBar: ended or cancelled")
            //滑动超过30%宽度
            if progress > 0.3 {
                if let rect = self.openCompleted(edges: openEdges) {
                    UIView.animate(withDuration: TimeInterval((1 - progress)*0.7), delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        self.frame = rect
                        }, completion: { (_) in
                            self.isShow = true
                            self.delegate?.isShowed()
                    })
//                    UIView.animate(withDuration: TimeInterval((1 - progress)*0.5), animations: { 
//                        self.frame = rect
//                        }, completion: { (_) in
//                            self.isShow = true
//                            self.delegate?.isShowed()
//                    })
                }
            } else {
                if let rect = self.openCancelled(edges: openEdges) {
                    UIView.animate(withDuration: TimeInterval(progress*0.5), animations: { 
                        self.frame = rect
                        }, completion: { (_) in
                            self.isShow = false
                            self.delegate?.isHidden()
                    })
                }
            }
        default:
            break
        }
    }
    
    func closeSideBarRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        guard self.isShow == true else {
//            print("SideBar already closed")
            return
        }
        
        let point = recognizer.translation(in: self)
//        print("closeSideBarRecognizer  Point:\(point)")
        
        var x:CGFloat = 0
        
        if closeEdges == .left {
            x = recognizer.translation(in: self).x
        } else {
            x = 1 - recognizer.translation(in: self).x
        }
        var progress = x / self.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        self.delegate?.sideBarProgress(isOpen: false, edges: closeEdges, progress: progress)
        
        
        if point.x > 0 { //from left
            progress = point.x / self.bounds.width
        } else { //from right
            progress = -point.x / self.bounds.width
        }
        // 获取手势在屏幕横屏范围的滑动百分比，并控制在0.0 - 1.0之间
        progress = min(1.0, max(0.0, progress))
        
        switch recognizer.state {
        case .began:
//            print("closeSideBar: began")
            self.closeChanged(edges: closeEdges, progress: progress)
        case .changed:  // 滑动过程中，根据在屏幕上滑动的百分比更新状态
//            print("closeSideBar: changed")
            self.closeChanged(edges: closeEdges, progress: progress)
        case .ended, .cancelled:    // 滑动结束或取消
//            print("closeSideBar: ended or cancelled")
            //滑动超过50%宽度
            if progress > 0.5 {
                if let rect = self.closeCompleted(edges: closeEdges) {
                    UIView.animate(withDuration: TimeInterval((1 - progress)*0.5), animations: { 
                        self.frame = rect
                        }, completion: { (_) in
                            self.isShow = false
                            self.delegate?.isHidden()
                    })
                }
            } else {
                if let rect = self.closeCancelled(edges: closeEdges) {
                    UIView.animate(withDuration: TimeInterval(progress*0.5), animations: { 
                        self.frame = rect
                        }, completion: { (_) in
                            self.isShow = true
                            self.delegate?.isShowed()
                    })
                }
            }
        default:
            break
        }
    }
}
