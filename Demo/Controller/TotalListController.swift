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
    let kDemoControllerNum:Int = 10
    @IBOutlet weak var tableView: UITableView!
    
    var sideBarView:SideBarView?
    
    override func initView() {
        self.navigationController?.navigationBar.isHidden = true

        addSideBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

}


extension TotalListController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kDemoControllerNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row:\(indexPath.row)"
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TotalListController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

//MARK:- Private function
private extension TotalListController{

}

//SideBar
extension TotalListController:SideBarViewProtocol {
    func addSideBar() {
        sideBarView = SideBarView.addSideBar(parentCtl: self, edges: .right, widthPercent: 0.5)
        sideBarView?.initView(data: nil)
    }
    
    func removeSideBar() {
        sideBarView?.removeSideBar()
    }
    
    func sideBarProgress(isOpen: Bool, edges: UIRectEdge, progress: CGFloat) {
        print("SideBarViewProtocol sideBarProgress, isOpen:\(isOpen == true ? "Yes":"No") edges:\(edges == .left ? ".left":".right") progress:\(progress)")
        if isOpen { //打开侧边栏
            if edges == .left { //侧边栏在左侧

            } else {
                
            }
        } else { //关闭侧边栏
            
        }
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

