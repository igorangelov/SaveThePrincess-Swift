//
//  SaveThePrincessTests.swift
//  SaveThePrincessTests
//
//  Created by Igor Angelov on 14/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import XCTest

import CoreData
@testable import SaveThePrincess

class SaveThePrincessTests: XCTestCase {
    
    var viewController : MasterViewController?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as? MasterViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController?.view)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    func testCreateWall() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createWall()
        XCTAssertTrue((appDelegate.wall?.durability)! > 0 , "Wall creation failed")
    }
    
    func testAttack() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createWall()
        
        let context = appDelegate._fetchedResultsController?.managedObjectContext
        let newSoldier = Soldier(context: context!)
        newSoldier.name = "Test Soldier"
        newSoldier.color = UIColor.red.encode() as NSData
        newSoldier.gender = Gender.male
        newSoldier.age = (appDelegate.wall?.durability)!
        
        viewController?.soldierAttack(newSoldier)
        XCTAssertTrue((appDelegate.wall?.durability)! == 0 , "Wall attack failed")
    }
}
