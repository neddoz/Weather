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
    
    init(item: CurrentWeatherForecast) {
        self.item = item
    }
    private let item: CurrentWeatherForecast
}


extension Double {
    static let temeperatureFormmater: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        return formatter
    }()
}


func temeperatureString(for value: Double)-> String {
    let value = round(value * 10) / 10.0
    let measurement = Measurement(value: value, unit: UnitTemperature.celsius)
    return Double.temeperatureFormmater.string(from: measurement)
}
