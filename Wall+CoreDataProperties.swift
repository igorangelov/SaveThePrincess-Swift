//
//  Wall+CoreDataProperties.swift
//  
//
//  Created by Igor Angelov on 21/08/2017.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Wall {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wall> {
        return NSFetchRequest<Wall>(entityName: "Wall");
    }

    @NSManaged public var durability: Int32

}
