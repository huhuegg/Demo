//
//  AppRouter.swift
//  SimpleFrameworkDemo
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework

enum AppRootViewControllerType {
    case navigationController
    case tabbarController
    case viewController
}

enum AppRouterID {
    case totalList
    case testAnimation
    case gradientLayer
}

class AppRouter: NSObject {
    private static let appRouterInstance = AppRouter()
    
    static let instance:AppRouter = {
        return appRouterInstance
    }()
    
    var window:UIWindow? = {
        if let appDelegate = UIApplication.shared().delegate as? AppDelegate {
            return appDelegate.window
        }
        return nil
    }()

    //容器
    var naviCtl:UINavigationController = UINavigationController()

    
    //TODO:- 定义所有Handler
    var totalListHandler:TotalListHandler!
    var testAnimationHandler:TestAnimationHandler!
    var gradientLayerHandler:GradientLayerHandler!

    private func initHandlers() {
        totalListHandler = SimpleRouter.create(name: "TotalList") as! TotalListHandler
        testAnimationHandler = SimpleRouter.create(name: "TestAnimation") as! TestAnimationHandler
        gradientLayerHandler = SimpleRouter.create(name: "GradientLayer") as! GradientLayerHandler
    }
    
    private func getHandler(routerId:AppRouterID)->SimpleHandler? {
        switch routerId {
        case .totalList:
            return totalListHandler
        case .testAnimation:
            return testAnimationHandler
        case .gradientLayer:
            return gradientLayerHandler
        }
    }

}

private extension AppRouter {
    //获取指定routeId的Handler，并初始化Controller
    func setupToHandler(routerId:AppRouterID, data: Dictionary<String, AnyObject>?)->(SimpleHandler?,SimpleController?) {
        
        let toHandler = getHandler(routerId: routerId)
        //Controller初始化
        let toController = toHandler?.setupController(data: data)
        return (toHandler,toController)
        
    }
}


//MARK:- 外部调用方法
extension AppRouter {
    //Start AppRouter
    func start(firstRouterId:AppRouterID,type:AppRootViewControllerType,data:Dictionary<String,AnyObject>?)->Bool {
        //初始化所有Handler
        initHandlers()
        
        //TODO:- 指定firstHandler
        guard let firstHandler = getHandler(routerId: firstRouterId) else {
            print("firstHandler not found")
            return false
        }
        
        
        switch type {
        case .navigationController:
            guard let firstController = firstHandler.setupController(data: data) else {
                print("firstController setup failed")
                return false
            }
            print("firstController is \(firstController.className())")
            startWithNavigationController(controllers: [firstController])
            
            return true
        case .viewController:
            guard let firstController = firstHandler.setupController(data: data) else {
                print("firstController setup failed")
                return false
            }
            print("firstController is \(firstController.className())")
            startWithViewController(controller: firstController)
        default:
            break
        }
        
        return true
    }
    
    func show(routerId:AppRouterID,type:ControllerShowType, fromController:SimpleController, animated:Bool, transitioning:UIViewControllerAnimatedTransitioning?,data:Dictionary<String,AnyObject>?) {
        
        if type == .push && fromController.navigationController == nil {
            print("==PUSH== can't push from \(fromController.className()), navigationCtl is nil")
            return
        }
        
        let (handler,controller) = setupToHandler(routerId: routerId, data: data)
        
        guard let toHandler = handler else {
            print("toHandler is nil")
            return
        }
        
        guard let toController = controller else {
            print("toController is nil")
            return
        }

        
        switch type {
        case .push:
            print("==PUSH== \(fromController.className()) -> \(toController.className())")
            
            try? SimpleRouter.show(type: type, fromController: fromController, toHandler: toHandler, animated: animated,transitioning:transitioning, data: data)
        case .present:
            print("==PRESENT== \(fromController.className()) -> \(toController.className())")
            
            try? SimpleRouter.show(type: type, fromController: fromController, toHandler: toHandler, animated: animated,transitioning:transitioning, data: data)
        case .presentNavi:
            print("==PRESENT Nav== TODO");
        default:
            break;
        }
    }
    
    func close(fromController:SimpleController,animated:Bool) {
        try? SimpleRouter.close(fromController: fromController,animated: true)
    }
}

//MARK:- 内部方法
private extension AppRouter {

    func startWithViewController(controller:UIViewController) {
        print("startWithViewController")
        window!.rootViewController = controller
    }
    
    func startWithNavigationController(controllers:Array<UIViewController>) {
        print("startWithNavigationController")
        naviCtl.viewControllers = controllers
        window!.rootViewController = naviCtl
    }

}
