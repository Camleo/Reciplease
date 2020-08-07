//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by rochdi ben abdeljelil on 07.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataManager = nil
    }
    
}
