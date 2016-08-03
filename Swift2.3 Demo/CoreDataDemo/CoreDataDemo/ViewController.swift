//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/2.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        findUser("8")
        
    }
}

extension ViewController {
    func fetchUsers() {
        AppCoreData.instance.fetchUsers { (users) in
            if let users = users {
                for user in users  {
                    print("sid:\(user.sid) name:\(user.name)")
                }
            }
            
        }
    }
    
    func findUser(sid:String) {
        AppCoreData.instance.findUser("sid", value: sid) { (user) in
            if let user = user {
                print("sid:\(user.sid) name:\(user.name)")
            }
        }
    }
}
