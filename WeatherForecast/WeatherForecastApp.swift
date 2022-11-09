//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
