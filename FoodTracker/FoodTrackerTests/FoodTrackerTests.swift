//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Sridhar Ramaswamy on 1/26/17.
//  Copyright © 2017 Sridhar Ramaswamy. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
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
    
    //MARK: Meal Class Tests
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds() {
        let zeroRatingMeal = Meal.init(name: "zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let fiveStarMeal = Meal.init(name: "five", photo: nil, rating: 5)
        XCTAssertNotNil(fiveStarMeal)
    }
    
    func testMealInitializationFails() {
        let failMeal = Meal.init(name: "fail", photo: nil, rating: -1)
        XCTAssertNil(failMeal)
        
        let nullMeal = Meal.init(name: "", photo: nil, rating: 3)
        XCTAssertNil(nullMeal)
        
        let tooGood2BTrueMeal = Meal.init(name: "", photo: nil, rating: 8)
        XCTAssertNil(tooGood2BTrueMeal)
    }
}
