//
//  LanguageAppApp.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 12.11.2024.
//

import SwiftUI

@main
struct LanguageAppApp: App {
    //PersistenceController для работы с Core Data
    private var persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

