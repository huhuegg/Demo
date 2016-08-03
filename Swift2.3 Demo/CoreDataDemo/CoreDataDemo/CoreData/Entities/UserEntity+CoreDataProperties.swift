//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by admin on 16/8/3.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserEntity {

    @NSManaged var info: String?
    @NSManaged var name: String?
    @NSManaged var sid: String?

}
