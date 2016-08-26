//
//  TotalListHandler.swift
//  Demo
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework

class TotalListHandler: SimpleHandler {

}

//MARK:- Router
extension TotalListHandler {
    func showTestAnimation(from:SimpleController) {
        AppRouter.instance.show(routerId: AppRouterID.testAnimation, type: ControllerShowType.push, fromController: from, animated: true, transitioning: nil, data: nil)
    }

    func showGradientLayer(from:SimpleController) {
        AppRouter.instance.show(routerId: AppRouterID.gradientLayer, type: ControllerShowType.push, fromController: from, animated: true, transitioning: nil, data: nil)
    }

    func showImageExif(from:SimpleController) {
        AppRouter.instance.show(routerId: AppRouterID.imageExif, type: ControllerShowType.push, fromController: from, animated: true, transitioning: nil, data: nil)
    }
}
