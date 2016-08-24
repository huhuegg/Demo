//
//  GradientLayerController.swift
//  Demo
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit
import SimpleFramework

class GradientLayerController: SimpleController {
    let gradientLayerCellIdentifier = "GradientLayerCell"
    
    var tabViewData:Array<String> = Array()
    
    override func initView() {
        self.navigationController?.navigationBar.isHidden = true
        
        let gradientFrame = CGRect(x: 0, y: view.frame.size.height - 200, width: view.frame.size.width, height: 200)
        
        let gradientView = UIView()
        gradientView.frame = gradientFrame
        self.view.addSubview(gradientView)
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black().withAlphaComponent(0.1).cgColor,UIColor.black().cgColor]
        gradientLayer.frame = gradientView.bounds
        gradientLayer.locations = [0,0.5,1]
        
        gradientView.layer.mask = gradientLayer
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: gradientLayerCellIdentifier, bundle: Bundle.main())

        tableView.register(cellNib, forCellReuseIdentifier: gradientLayerCellIdentifier)
        tableView.frame = gradientView.bounds
        tableView.backgroundColor = UIColor.clear()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        
        gradientView.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewData()
        initView()
    }
    
    func initTableViewData() {
        tabViewData.append("测试文本1")
        tabViewData.append("测试文本2")
        tabViewData.append("测试文本3")
        tabViewData.append("测试文本4")
        tabViewData.append("测试文本5")
        tabViewData.append("测试文本6")
        tabViewData.append("测试文本7")
        tabViewData.append("测试文本8")
        tabViewData.append("测试文本9")
        tabViewData.append("测试文本10")
    }
}

extension GradientLayerController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: gradientLayerCellIdentifier) as? GradientLayerCell {
            
            cell.setupUI()
            cell.setLabel(text: tabViewData[indexPath.row])
            print("l: \(cell.label.text)")
            return cell
        }
        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension GradientLayerController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath.row) title:\(tabViewData[indexPath.row])")
    }
}
