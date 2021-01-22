//
//  Persistence.swift
//  finchios
//
//  Created by Brett Fazio on 10/30/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    static var isUITesting: Bool {
        get {
            return ProcessInfo.processInfo.arguments.contains("UI-Testing")
        }
    }
    
    init(inMemory: Bool = false) {
        if PersistenceController.isUITesting {
            CredentialsObject.deleteCurrentCredentials { (_) in }
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
        container = NSPersistentContainer(name: "finchios")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
