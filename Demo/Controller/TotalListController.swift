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
    
    var tableViewData:Array<Menu> = Array()
    
    override func initView() {
        self.navigationController?.navigationBar.isHidden = true
        tableView.backgroundColor = UIColor.black()
        tableView.sectionHeaderHeight = 50
        tableView.sectionFooterHeight = 20
        addSideBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewData()
        initView()
    }

    func initTableViewData() {
        tableViewData = setupMenu()
    }
}

//MARK:- Menu
extension TotalListController {
    enum MenuType {
        case menu //菜单
        case item //菜单项
    }
    
    struct Menu {
        //groupName用于显示在Section的head中
        var groupName:String!
        //菜单项
        var items:Array<MenuItem>!
        //默认是否展开
        var isOpened:Bool
        
        init(groupName:String = "", items:Array<MenuItem> = Array(), isOpened:Bool = false) {
            self.groupName = groupName
            self.items = items
            self.isOpened = isOpened
        }
    }
    
    struct MenuItem {
        //类型
        var type:MenuType!
        
        //菜单项描述
        var name:String!
        
        //点击事件
        var action:Selector?
    }
    
    //setup
    func setupMenu()->Array<Menu> {
        var menuData:Array<Menu> = Array()

        let uiMenuItem = MenuItem(type: MenuType.menu, name: "UI", action: nil)
        let testAnimationMenuItem = MenuItem(type: MenuType.item, name: "动画:TestAnimation", action: #selector(self.showTestAnimation))
        let testLayerMenuItem = MenuItem(type: MenuType.item, name: "Layer:渐变tableview", action: #selector(self.showGradientLayer))
        let uiMenu = Menu(groupName:"", items: [uiMenuItem, testAnimationMenuItem, testLayerMenuItem], isOpened: true)
        
        let imageMenuItem = MenuItem(type: MenuType.menu, name: "Image", action:nil)
        let imageExifMenuItem = MenuItem(type: MenuType.item, name: "ImageIO:获取图片位置信息", action: #selector(self.showImageExif))
        let imageMenu = Menu(groupName:"", items: [imageMenuItem, imageExifMenuItem], isOpened: false)
        
        let networkkMenuItem = MenuItem(type: MenuType.menu, name: "Network", action:nil)
        let networkMenu = Menu(groupName:"", items: [networkkMenuItem], isOpened: false)
        
        let coreDataMenuItem = MenuItem(type: MenuType.menu, name: "CoreData", action: nil)
        let coreDataMenu = Menu(groupName:"", items: [coreDataMenuItem], isOpened: false)
        
        menuData = [uiMenu,imageMenu,networkMenu,coreDataMenu]
        return menuData
    }
    
    //菜单点击事件
    func menuClicked(tableView:UITableView, section:Int) {
        let lastOpenStatus = tableViewData[section].isOpened
        tableViewData[section].isOpened = !lastOpenStatus
        
        //显示或隐藏菜单
        let indexSet = IndexSet(integer:section)
        tableView.reloadSections(indexSet, with: UITableViewRowAnimation.automatic)
    }
    
    //菜单项点击事件
    func showTestAnimation() {
        (self.handler as! TotalListHandler).showTestAnimation(from: self)
    }
    
    func showGradientLayer() {
        (self.handler as! TotalListHandler).showGradientLayer(from: self)
    }
    
    func showImageExif() {
        (self.handler as! TotalListHandler).showImageExif(from: self)
    }
}

extension TotalListController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].groupName
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        cell.textLabel?.text = tableViewData[indexPath.section].items[indexPath.row].name
        cell.backgroundColor = UIColor.clear()
        if indexPath.row == 0 {
            
            cell.textLabel?.textColor = UIColor.white()
            if tableViewData[indexPath.section].isOpened {
                cell.textLabel?.text = "▼  " + tableViewData[indexPath.section].items[indexPath.row].name
            } else {
                cell.textLabel?.text = "►  " + tableViewData[indexPath.section].items[indexPath.row].name
            }
        } else {

            cell.textLabel?.textColor = UIColor.lightText()
            cell.textLabel?.text = "      " + tableViewData[indexPath.section].items[indexPath.row].name
        }

        return cell
    }
    
    
}

extension TotalListController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50.0
        } else {
            return tableViewData[indexPath.section].isOpened ? 50.0 : 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("didSelectRow:\(indexPath.row) section:\(indexPath.section))")
        
        if indexPath.row == 0 { //menu
            menuClicked(tableView: tableView, section: indexPath.section)
        } else {
            if let action = tableViewData[indexPath.section].items[indexPath.row].action {
                self.performSelector(onMainThread: action, with: nil, waitUntilDone: false)
            } else {
                print("未指定action")
            }
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

