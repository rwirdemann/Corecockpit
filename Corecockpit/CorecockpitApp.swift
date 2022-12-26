//
//  CorecockpitApp.swift
//  Corecockpit
//
//  Created by Ralf Wirdemann on 17.12.22.
//

import SwiftUI

@main
struct CorecockpitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
