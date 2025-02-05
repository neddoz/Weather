//
//  CurrentWeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import Foundation
import SwiftUI

struct CurrentWeatherDetailViewModel {

    var temperature: String {
        return temeperatureString(for: item.main.temperature)
    }
    
    var maxTemperature: String {
        return temeperatureString(for: item.main.maxTemperature)
    }
    
    var minTemperature: String {
        return temeperatureString(for: item.main.minTemperature)

    }
    
    var humidity: String {
        return String(format: "%.1f", item.main.humidity)
    }
    
    var name: String {
        return item.name
    }
    
    var condition: String {
        return item.weather.first?.main ?? ""
    }
    
    var icon: String {
        enum WeatherCondition: String {
            case Rain
            case Clouds
            case Clear
        }
        let condition = WeatherCondition(rawValue: condition)
        
        switch condition {
        case .Clouds:
            return "forest_cloudy"
        case .Clear:
            return "forest_sunny"
        case .Rain:
            return "forest_rainy"
        case .none:
            return ""
        }
    }
    
    
    init(item: CurrentWeatherForecast) {
        self.item = item
    }
    private let item: CurrentWeatherForecast
}


extension Double {
    nonisolated(unsafe) static let temeperatureFormmater: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        return formatter
    }()
}


func temeperatureString(for value: Double)-> String {
    let value = round(value * 10) / 10.0
    let measurement = Measurement(value: value, unit: UnitTemperature.celsius)
    return Double.temeperatureFormmater.string(from: measurement)
}
