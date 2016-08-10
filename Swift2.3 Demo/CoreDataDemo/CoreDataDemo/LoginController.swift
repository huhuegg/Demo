//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by admin on 16/8/2.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoginHandler.login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        findUser("8")
//        removeUser("9")
//        
//        changeUserName("name6", to: "~~ name6 ~~")
//        fetchUsers()
    }
}

extension LoginController {
    func fetchUsers() {
        
        UserEntity.fetchUsersOrderByNameDESC { (users) in
            if let users = users {
                for user in users  {
                    print("sid:\(user.sid) name:\(user.name)")
                }
                print("FetchUsers count:\(users.count)")
            }
            
        }
    }
    
    func findUser(sid:String) {
        UserEntity.find("sid", value: sid) { (user) in
            if let user = user {
                print("sid:\(user.sid) name:\(user.name)")
            }
        }
    }
    
    func removeUser(sid:String) {
        UserEntity.remove(sid)
    }
    
    func changeUserName(from:String, to:String) {
        let predicate = NSPredicate(format: "name == %@",from)
        UserEntity.change(predicate, name: to)
    }
}
