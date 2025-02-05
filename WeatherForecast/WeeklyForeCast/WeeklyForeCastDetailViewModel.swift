//
//  WeeklyForeCastDetailViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation

//@MainActor
struct WeeklyForeCastDetailViewModel {
    
    var temperature: String {
        return temeperatureString(for: weatherListing.main.temperature)
    }
    
    var maxTemperature: String {
        return temeperatureString(for: weatherListing.main.maxTemperature)
    }
    
    var minTemperature: String {
        return temeperatureString(for: weatherListing.main.minTemperature)
        
    }
    
    nonisolated
    var day: String {
        return weatherListing.date.dayOfWeek()
    }
    
    var month: String {
        return monthFormatter.string(from: weatherListing.date)
    }
    
    let weatherListing: WeeklyForeCastItem
    
    init(_ item: WeeklyForeCastItem) {
        self.weatherListing = item
    }
    
}


extension WeeklyForeCastDetailViewModel: Hashable {
    nonisolated static func == (lhs: WeeklyForeCastDetailViewModel, rhs: WeeklyForeCastDetailViewModel) -> Bool {
        
        return lhs.day == rhs.day
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}

//extension WeeklyForeCastDetailViewModel: Identifiable {
//    var id: ObjectIdentifier {
//        return UUID()
//    }
//}

