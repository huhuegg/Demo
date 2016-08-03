//
//  UserEntity.swift
//  
//
//  Created by admin on 16/8/3.
//
//

import Foundation
import CoreData


class UserEntity: NSManagedObject {

    func convertFromModel(model:User) {
        self.sid = model.sid
        self.name = model.name
        self.info = model.info
    }
    
    func convertToModel()->User {
        let user = User(sid: self.sid!, name: self.name!, info: self.info!)
        return user
    }

}
