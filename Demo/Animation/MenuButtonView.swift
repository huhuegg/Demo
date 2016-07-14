//
//  MenuButtonAnimation.swift
//  Demo
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class MenuButtonView: UIButton {
    var firstLayer:CAShapeLayer?
    var secondLayer:CAShapeLayer?
    var thirdLayer:CAShapeLayer?
    var circleLayer:CAShapeLayer?
    
    var touchRecognizer:UIPanGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        addLayer()
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func removeLayer() {
        firstLayer?.removeFromSuperlayer()
        secondLayer?.removeFromSuperlayer()
        thirdLayer?.removeFromSuperlayer()
        circleLayer?.removeFromSuperlayer()
    }
    
    private func addLayer() {
        removeLayer()
        //三
        let color = UIColor.white()
        
        let firstFrom = CGPoint(x:0, y:0)
        let firstTo = CGPoint(x: self.frame.width, y: 0)
        let firstAnchorPoint = CGPoint(x: 1, y: 0.0)
        firstLayer = addLine(from: firstFrom, to: firstTo, anchorPoint:firstAnchorPoint,fillColor: nil, strokeColor: color.cgColor, lineWidth: 3.0)
        
        let secondFrom = CGPoint(x: 0, y: 1 / 2 * self.frame.height)
        let secondTo = CGPoint(x: self.frame.width, y: 1 / 2 * self.frame.height)
        let secondAnchorPoint = CGPoint(x: 1.0, y: 0.5)
        secondLayer = addLine(from: secondFrom, to: secondTo, anchorPoint:secondAnchorPoint, fillColor: nil, strokeColor: color.cgColor, lineWidth: 3.0)
        
        let thirdFrom = CGPoint(x: 0, y: self.frame.height)
        let thirdTo = CGPoint(x: self.frame.width, y: self.frame.height)
        let thirdAnchorPoint = CGPoint(x: 1.0, y: 1.0)
        thirdLayer = addLine(from: thirdFrom, to: thirdTo, anchorPoint:thirdAnchorPoint, fillColor: nil, strokeColor: color.cgColor, lineWidth: 3.0)
        
        
        self.layer.addSublayer(firstLayer!)
        self.layer.addSublayer(secondLayer!)
        self.layer.addSublayer(thirdLayer!)
        
        let radius = secondLayer!.frame.width
        let circlePath = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        circleLayer = CAShapeLayer()
        circleLayer!.fillColor = UIColor.clear().cgColor
        circleLayer!.strokeColor = color.cgColor
        circleLayer!.lineWidth = 3.0
        circleLayer!.path = circlePath.cgPath
        circleLayer!.opacity = 0.0
        
        self.layer.addSublayer(circleLayer!)
        
        
        
        
//        let circlePath = UIBezierPath(````)
//        let circleLayer = CALayer()
//        circleLayer.frame = self.frame
//        circleLayer.position = CGPoint(x:50, y:50)
//        circleLayer.contents = UIImage(named: "mask1")?.cgImage
//        
//    
//        
//        //填充色
//        let pathLayer = CALayer()
//        pathLayer.fillColor = UIColor.clear().cgColor
//        //边框色
//        pathLayer.strokeColor = color.cgColor
//        pathLayer.lineWidth = 1.0
//        pathLayer.path = circlePath.cgPath
//        
//        self.layer.addSublayer(pathLayer)
//        // 创建关键帧动画
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        animation.duration = 2.0
//        animation.path = pathLayer.path
//        animation.fillMode = kCAFillModeForwards
//        
//        //匹配path方向
//        animation.rotationMode = kCAAnimationRotateAuto
//        
//        circleLayer.add(animation, forKey: nil)
        
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 50, y: 50))
//        bezierPath.addCurve(to: CGPoint(x: 50, y: 300), controlPoint1: CGPoint(x: 10,y: 100), controlPoint2: CGPoint(x: 90,y: 200))
//        
//        let pathLayer = CAShapeLayer()
//        pathLayer.path = bezierPath.cgPath
//        
//        //填充色
//        pathLayer.fillColor = UIColor.clear().cgColor
//        //边框色
//        pathLayer.strokeColor = color.cgColor
//        pathLayer.lineWidth = 1.0
//        
//        onView.layer.addSublayer(pathLayer)
        
//        let moveObj = CALayer()
//        moveObj.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
//        moveObj.position = CGPoint(x: 50, y: 50)
//        moveObj.contents = UIImage(named: "mask1")?.cgImage
//        self.layer.addSublayer(moveObj)
//        
//        // 创建关键帧动画
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        animation.duration = 2.0
//        animation.path = pathLayer.path
//        animation.fillMode = kCAFillModeForwards
//        
//        //匹配path方向
//        animation.rotationMode = kCAAnimationRotateAuto
//        
//        // 执行动画
//        moveObj.add(animation, forKey: nil)
    }

    private func addLine(from:CGPoint,to:CGPoint,anchorPoint:CGPoint,fillColor:CGColor?,strokeColor:CGColor?,lineWidth:CGFloat) -> CAShapeLayer {
        print("from:\(from) to:\(to)")
        let bezierPath = UIBezierPath()
        bezierPath.move(to: from)
        bezierPath.addLine(to: to)
        
        let pathLayer = CAShapeLayer()
        //修改了中心点后图形的位置也会发生变化。所以设置中心点必须在设置图形位置(frame)之前
        pathLayer.anchorPoint = anchorPoint
        pathLayer.frame = self.frame
        
        pathLayer.path = bezierPath.cgPath
        //填充色
        pathLayer.fillColor = UIColor.clear().cgColor
        //边框色
        pathLayer.strokeColor = UIColor.white().cgColor
        pathLayer.lineWidth = lineWidth
        
        return pathLayer
    }
    
    private func startAnimation() {
        print("startAnimation")
        let duration:Double = 1.0
        
        //MARK:- 第一条线的动画
        
        //part 1:以最右侧为中心点逆时针旋转45度
        let firstLayerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        //旋转角度
        firstLayerAnimation.fromValue = 0
        firstLayerAnimation.toValue = -M_PI / 4
        
        

        //part 3:在旋转的同时改变长度
        let firstLayerWidthAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        firstLayerWidthAnimation.fromValue = 1
        firstLayerWidthAnimation.toValue = 1.44
        
        let firstGroupAnimation = CAAnimationGroup()
        firstGroupAnimation.animations = [firstLayerAnimation,firstLayerWidthAnimation]
        firstGroupAnimation.duration = duration
        
        //动画完成后不返回初始状态
        firstGroupAnimation.isRemovedOnCompletion = false
        firstGroupAnimation.fillMode = kCAFillModeForwards
        
        firstLayer?.add(firstGroupAnimation, forKey: nil)
        
        
        
        //MARK:- 第二条线的动画
        //part 1:以右侧为中心点缩短x
        let secondLayerWidthAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        secondLayerWidthAnimation.fromValue = 1
        secondLayerWidthAnimation.toValue = 0
        
        //part 2: 向右平移
        let secondLayerMoveAnimation = CABasicAnimation(keyPath: "position")
        secondLayerMoveAnimation.fromValue = NSValue(cgPoint: secondLayer!.position)
        var toPoint = secondLayer!.position
        toPoint.x = toPoint.x + 22
        secondLayerMoveAnimation.toValue = NSValue(cgPoint: toPoint)
        
        //part 3: 透明
        let secondLayerOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        secondLayerOpacityAnimation.fromValue = 1
        secondLayerOpacityAnimation.toValue = 0.3
        
        //动画组
        let secondGroupAnimation = CAAnimationGroup()
        secondGroupAnimation.animations = [secondLayerWidthAnimation,secondLayerMoveAnimation,secondLayerOpacityAnimation]
        secondGroupAnimation.duration = duration
        
        secondGroupAnimation.isRemovedOnCompletion = false
        secondGroupAnimation.fillMode = kCAFillModeForwards
        
        secondLayer?.add(secondGroupAnimation, forKey: nil)
        
        
        
        //MARK:- 添加圆形
        //part 1:从0度位置画一个圈
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.fromValue = 0.0
        circleAnimation.toValue = 1.0
        
        //part 2: 透明
        let circleOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        circleOpacityAnimation.fromValue = 0.3
        circleOpacityAnimation.toValue = 1.0
        
        //动画组
        let circleGroupAnimation = CAAnimationGroup()
        circleGroupAnimation.animations = [circleAnimation,circleOpacityAnimation]
//        //延迟0.4秒开始
        circleGroupAnimation.beginTime = CACurrentMediaTime() + 0.4
        circleGroupAnimation.duration = duration
        
        //动画完成后不返回初始状态
        circleGroupAnimation.isRemovedOnCompletion = false
        circleGroupAnimation.fillMode = kCAFillModeForwards
        
        circleLayer!.add(circleGroupAnimation, forKey: nil)
        

        
        //MARK:- 第三条线的动画
        //part 1:以最右侧为中心点顺时针旋转45度
        let thirdLayerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        //旋转角度
        thirdLayerAnimation.fromValue = 0
        thirdLayerAnimation.toValue = M_PI / 4
        
        //part 2:在旋转的同时改变长度
        let thirdLayerWidthAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        thirdLayerWidthAnimation.fromValue = 1
        thirdLayerWidthAnimation.toValue = 1.44
        
        let thirdGroupAnimation = CAAnimationGroup()
        thirdGroupAnimation.animations = [thirdLayerAnimation,thirdLayerWidthAnimation]
        thirdGroupAnimation.duration = duration
        
        thirdGroupAnimation.isRemovedOnCompletion = false
        thirdGroupAnimation.fillMode = kCAFillModeForwards
        
        thirdLayer?.add(thirdGroupAnimation, forKey: nil)

        
    }
    
}

/**
 keyPath的值             说明
 position               位置变化，引起平移动画
 transform.scale        比例变化，放大缩小
 transform.scale.x      宽度缩放
 transform.scale.y      高度缩放
 transform.rotation     旋转
 transform.rotation.x	沿x轴旋转
 transform.rotation.y	沿y轴旋转
 transform.rotation.z	沿z轴旋转
 opacity                透明度
 backgroundColor        背景颜色
 cornerRadius           圆角
 
 
 
 animation的属性         说明
 fromValue              动画改变的属性初始值
 toValue                动画改变的属性结束值
 byValue                过程中属性相对初始值改变的值
 duration               动画持续时长
 repeatCount            动画重复次数，不停重复设置为 HUGE_VALF
 repeatDuration         动画应该被重复多久，动画会一直重复，直到设定的时间流逝完；它不应该和 repeatCount 一起使用。
 autoreverses           动画结束时是否执行逆动画，当你设定这个属性为 YES 时，在它到达目的地之后，动画的返回到开始的值，代替了直接跳转到 开始的值。
 beginTime              指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
 timingFunction         设置动画的速度变化，这个略复杂

 **/
