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
    /**
     已打开
     **/
    func isShowed()

    /**
     已关闭
     **/
    func isHidden()
    
    /**
     回传数据
     - parameter data:  回传数据
     **/
    func sideBarRoute(data:Dictionary<String,AnyObject>)
}

class SideBarView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var testButton1: UIButton!
    @IBOutlet weak var testButton2: UIButton!
    
    //SideBarViewProtocol
    var delegate:SideBarViewProtocol?
    //ParentController的view
    var parent:UIView?
    //动画时使用的ParentController.view的截图
    var parentImageView:UIImageView?
    
    //开启侧边栏手势
    var openSideBarRecognizer:UIScreenEdgePanGestureRecognizer?
    //开启侧边栏位置
    var openEdges:UIRectEdge = .left
    //关闭侧边栏手势
    var closeSideBarRecognizer:UIPanGestureRecognizer?
    
    //侧边栏宽度占屏幕宽度的百分比
    var widthPercent:CGFloat = 0.7
    
    //滑动打开侧边栏结束或取消时判断当前应该使用结束动画还是取消动画
    var openSwitchPercent:CGFloat = 0.5
    //滑动关闭侧边栏结束或取消时判断当前应该使用结束动画还是取消动画
    var closeSwitchPercent:CGFloat = 0.5
    //当前是否被打开
    var isShow:Bool = false
    
    let dWidth = UIScreen.main().bounds.width
    let dHeight = UIScreen.main().bounds.height
    
    //获取侧边栏宽度
    func getSideBarWidth() -> CGFloat {
        return UIScreen.main().bounds.width * widthPercent
    }
    
    /**
    添加侧边栏
     - parameter parentCtl:  需要添加侧边栏的Controller
     - parameter edges:  侧边栏打开方向
     - parameter widthPercent:  侧边栏占屏幕宽度百分比
    **/
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
       
        v.parent!.addSubview(v)
        v.setupFrame(widthPercent:widthPercent, edges:edges)
        v.setupGestureRecognizers()
        return v
    }
    
    /**
     移除侧边栏
     **/
    func removeSideBar() {
        self.removeGestureRecognizers()
        self.removeFromSuperview()
    }
    
    /**
     初始化View
     **/
    func initView(data:Dictionary<String,AnyObject>?) {
        
        testButton1.addTarget(self, action: .testButton1Clicked, for: UIControlEvents.touchUpInside)
        testButton2.addTarget(self, action: .testButton2Clicked, for: UIControlEvents.touchUpInside)
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

//MARK:- Private function
extension SideBarView {
    private class func instanceFromNib()->SideBarView {
        if let v = UIView.loadFromNibNamed(nibNamed: "SideBarView") as? SideBarView {
            return v
        }
        return SideBarView()
    }
    
    private func setupFrame(widthPercent:CGFloat, edges:UIRectEdge) {
        print("setupFrame")
        
        let sidebarWidth = getSideBarWidth()
        if edges == .left {
            self.frame = CGRect(x: -sidebarWidth, y: 0, width: sidebarWidth, height: dHeight)
        } else {
            self.frame = CGRect(x: dWidth, y: 0, width: sidebarWidth, height: dHeight)
        }
        
    }
    
    private func addShadow() {
        self.layer.shadowOpacity = 0.6 // 阴影透明度
        self.layer.shadowColor = UIColor.gray().cgColor // 阴影的颜色
        self.layer.shadowRadius = 3;// 阴影扩散的范围控制
        self.layer.shadowOffset = CGSize(width: 1, height: 1) // 阴影的范围
    }
    
    private func clearShadow() {
        self.layer.shadowColor = UIColor.clear().cgColor
    }

    private func addParentImageView() {
        print("addParentImageView:\(parentImageView)")
        if parentImageView == nil {
            if let image = UIView.imageFromView(v: parent) {
                parentImageView = UIImageView.init(image: image)
                parentImageView!.frame = parent!.bounds
                parent!.insertSubview(parentImageView!, belowSubview: self)
            }
        }
    }
    
    private func removeParentImageView() {
        parentImageView?.removeFromSuperview()
        parentImageView = nil
    }
    
    private func openChanged(edges:UIRectEdge,progress:CGFloat) {
        print("openChanged")

        if edges == .left {
            self.frame.origin.x = (progress - 1) * self.view.frame.width
            self.parentImageView!.frame.origin.x = getSideBarWidth() + self.frame.origin.x
        } else {
            
            self.frame.origin.x = dWidth - progress * self.view.frame.width
            self.parentImageView!.frame.origin.x = self.frame.origin.x - dWidth
        }
    }
    
    private func openCancelled(edges:UIRectEdge, duration:TimeInterval) {
        print("openCancelled")
        var newX:CGFloat = 0.0
        var parentImageViewX:CGFloat = 0.0
        if edges == .left {
            newX = -self.frame.width
            parentImageViewX = 0
        } else {
            newX = dWidth + self.frame.width
            parentImageViewX = 0
        }

        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.x = newX
            self.parentImageView!.frame.origin.x = parentImageViewX
            }, completion: { (_) in
                self.isShow = false
                self.clearShadow()
                self.removeParentImageView()
        })
    }
    
    private func openCompleted(edges:UIRectEdge, duration:TimeInterval) {
        print("openCompleted")
        var newX:CGFloat = 0.0
        var parentImageViewX:CGFloat = 0.0
        if edges == .left {
            newX = 0
            parentImageViewX = self.getSideBarWidth()
        } else {
            newX = dWidth - self.frame.width
            parentImageViewX = -self.frame.width
        }

        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.frame.origin.x = newX
            self.parentImageView!.frame.origin.x = parentImageViewX
            }, completion: { (_) in
                self.isShow = true
                self.delegate?.isShowed()
                self.addShadow()
        })
    }
    
    private func closeChanged(edges:UIRectEdge,progress:CGFloat) {
        print("closeChanged")
        var newX:CGFloat = 0.0
        var parentImageViewX:CGFloat = 0.0
        
        
        if edges == .left {
            newX = -progress * self.frame.width
            parentImageViewX = newX + getSideBarWidth()
            //print("XXXXXX edges: .right x:\(newX) progress:\(progress)")
            
            
        } else {
            newX = dWidth + (progress - 1) * self.frame.width
            if newX - getSideBarWidth() <= 0 {
                //确保不会露出下面的view
                parentImageViewX = newX - getSideBarWidth()
            }
            //print("XXXXXX edges: .left  x:\(newX) progress:\(progress)")
        }
        self.frame.origin.x = newX
        self.parentImageView!.frame.origin.x = parentImageViewX

    }
    
    private func closeCancelled(edges:UIRectEdge, duration:TimeInterval) {
        print("closeCancelled")
        var newX:CGFloat = 0.0
        var parentImageViewX:CGFloat = 0.0
        
        if edges == .left {
            newX = 0
            parentImageViewX = getSideBarWidth() + newX
        } else {
            newX = dWidth - self.frame.width
            parentImageViewX = newX - getSideBarWidth()
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.x = newX
            self.parentImageView!.frame.origin.x = parentImageViewX
            }, completion: { (_) in
                self.isShow = true
                self.addShadow()
                
        })
    }
    
    private func closeCompleted(edges:UIRectEdge, duration:TimeInterval) {
        print("closeCompleted")
        var newX:CGFloat = 0
        var parentImageViewX:CGFloat = 0.0
        
        if edges == .left {
            newX = -self.frame.width
            parentImageViewX = 0
        } else {
            newX = dWidth
            parentImageViewX = 0
        }

        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.x = newX
            self.parentImageView!.frame.origin.x = parentImageViewX
            }, completion: { (_) in
                self.isShow = false
                self.delegate?.isHidden()
                self.clearShadow()
                self.removeParentImageView()
        })
    }
}

//MARK:- UIGestureRecognizerDelegate
extension SideBarView:UIGestureRecognizerDelegate {
    
    func setupGestureRecognizers() {
//        print("setupGestureRecognizer")
        
        openSideBarRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SideBarView.openSideBarRecognizer(recognizer:)))
        openSideBarRecognizer!.edges = openEdges
        openSideBarRecognizer!.delegate = self
        parent!.addGestureRecognizer(openSideBarRecognizer!)

        closeSideBarRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SideBarView.closeSideBarRecognizer(recognizer:)))
        closeSideBarRecognizer!.delegate = self
        self.addGestureRecognizer(closeSideBarRecognizer!)
        
    }
    
    func removeGestureRecognizers() {
        self.parent?.removeGestureRecognizer(openSideBarRecognizer!)
        self.removeGestureRecognizer(closeSideBarRecognizer!)
    }
    
    //打开侧边栏的手势处理
    func openSideBarRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        guard isShow == false else {
            return
        }

        // 获取手势在屏幕横屏范围的滑动百分比，并控制在0.0 - 1.0之间
        var x:CGFloat = 0
        
        if openEdges == .left {
            x = recognizer.translation(in: self).x
        } else {
            x = 1 - recognizer.translation(in: self).x
        }
        var progress = x / self.bounds.width / widthPercent
        progress = min(1.0, max(0.0, progress))
        
        //print("openSideBarRecognizer edges:\(openEdges == .left ? ".left" : ".right") offsetX:\(x)  progress:\(progress)")
        
        switch recognizer.state {
        case .began:
//            print("showSideBar: began")
            //截取当前的view做动画
            addParentImageView()
            //为侧边栏添加阴影
            addShadow()
            self.openChanged(edges: openEdges, progress: progress)
        case .changed:  // 滑动过程中，根据在屏幕上滑动的百分比更新状态
//            print("showSideBar: changed")
            self.openChanged(edges: openEdges, progress: progress)
        case .ended, .cancelled:    // 滑动结束或取消
//            print("showSideBar: ended or cancelled")

            if progress > openSwitchPercent {
                let duration = TimeInterval((1 - progress)*0.7)
                self.openCompleted(edges: openEdges, duration: duration)

            } else {
                let duration = TimeInterval(progress*0.5)
                self.openCancelled(edges: openEdges, duration:duration)

            }
        default:
            break
        }
    }
    
    //关闭侧边栏的手势处理
    func closeSideBarRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        guard self.isShow == true else {
            return
        }
        
        let point = recognizer.translation(in: self)
        
        var x:CGFloat = 0
        
        if openEdges == .left {
            x = 1 - recognizer.translation(in: self).x
        } else {
            x = recognizer.translation(in: self).x
        }
        

        var progress = x / self.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        
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
            self.closeChanged(edges: openEdges, progress: progress)
        case .changed:  // 滑动过程中，根据在屏幕上滑动的百分比更新状态
//            print("closeSideBar: changed")
            self.closeChanged(edges: openEdges, progress: progress)
        case .ended, .cancelled:    // 滑动结束或取消
//            print("closeSideBar: ended or cancelled")
            if progress > closeSwitchPercent {
                let duration = TimeInterval((1 - progress)*0.5)
                self.closeCompleted(edges: openEdges, duration: duration)
            } else {
                let duration = TimeInterval(progress*0.5)
                self.closeCancelled(edges: openEdges, duration: duration)
            }
        default:
            break
        }
    }
}
