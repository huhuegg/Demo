//
//  TotalListController.swift
//  Demo
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework


class TotalListController:SimpleController {
    @IBOutlet weak var tableView: UITableView!
    
    var sideBarView:SideBarView?
    
    var tabViewData:Array<String> = Array()
    
    override func initView() {
        self.navigationController?.navigationBar.isHidden = true
        addSideBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewData()
        initView()
    }

    func initTableViewData() {
        tabViewData.append("TestAnimation")
        tabViewData.append("GrandientLayer-渐变tableview")
    }
}


extension TotalListController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tabViewData[indexPath.row]
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TotalListController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath.row) title:\(self.tabViewData[indexPath.row])")
        switch indexPath.row {
        case 0:
            (self.handler as! TotalListHandler).showTestAnimation(from: self)
        case 1:
            (self.handler as! TotalListHandler).showGradientLayer(from: self)
        default:
            break
        }
    }
}

//MARK:- Private function
private extension TotalListController{

}


//SideBar
extension TotalListController:SideBarViewProtocol {
    func addSideBar() {
        sideBarView = SideBarView.addSideBar(parentCtl: self, edges: .left, widthPercent: 0.6)
        sideBarView?.initView(data: nil)
    }
    
    func removeSideBar() {
        sideBarView?.removeSideBar()
    }
    
    func sideBarOffset(offsetX: CGFloat) {
//        print(self.view.subviews)
//        print("self.view.x:\(self.view.frame.origin.x) offset:\(offsetX)")
//        let newX = 0.05 * offsetX
//        if newX < 100 {
//            self.view.frame.origin.x -= 0.05 * offsetX
//        }
    }
    
    func sideBarCancled(edges: UIRectEdge, cancleDuration: TimeInterval) {
//        
//        UIView.animate(withDuration: cancleDuration) {
//            self.view.frame.origin.x = 0
//        }
    }
    
    func sideBarCompleted(edges: UIRectEdge, completeDuration: TimeInterval) {
//        var newX:CGFloat = 0.0
//        if edges == .left {
//            newX = -(self.view.frame.width - sideBarView!.frame.width)
//        } else {
//            newX = self.view.frame.width - sideBarView!.frame.width
//        }
//        UIView.animate(withDuration: completeDuration) { 
//            self.view.frame.origin.x = newX
//        }
    }

    func isShowed() {
        print("SideBarViewProtocol isShowed")

    }
    func isHidden() {
        print("SideBarViewProtocol isHidden")
    }
    func sideBarRoute(data:Dictionary<String,AnyObject>) {
        print("SideBarViewProtocol sideBarRoute: \(data)")
    }
}

