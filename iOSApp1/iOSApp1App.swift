//
//  iOSApp1App.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-26.
//

import SwiftUI

@main
struct iOSApp1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
