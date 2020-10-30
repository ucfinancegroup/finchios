//
//  finchiosApp.swift
//  finchios
//
//  Created by Brett Fazio on 10/30/20.
//

import SwiftUI

@main
struct finchiosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
