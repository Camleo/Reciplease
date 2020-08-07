//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by rochdi ben abdeljelil on 07.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Reciplease
import Foundation
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    // MARK: - Initializer
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistenStoreDescription = NSPersistentStoreDescription()
        persistenStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistenStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
        
    }
}
