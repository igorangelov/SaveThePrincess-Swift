//
//  Soldier+CoreDataProperties.swift
//  
//
//  Created by Igor Angelov on 21/08/2017.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Soldier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Soldier> {
        return NSFetchRequest<Soldier>(entityName: "Soldier");
    }

    @NSManaged public var age: Int32
    @NSManaged public var color: NSData?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}
