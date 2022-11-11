//
//  CurrentWeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import Foundation
import SwiftUI
import MapKit

struct CurrentWeatherDetailViewModel {
  private let item: CurrentWeatherForecast
  
  var temperature: String {
    return String(format: "%.1f", item.main.temperature)
  }
  
  var maxTemperature: String {
    return String(format: "%.1f", item.main.maxTemperature)
  }
  
  var minTemperature: String {
    return String(format: "%.1f", item.main.minTemperature)
  }
  
  var humidity: String {
    return String(format: "%.1f", item.main.humidity)
  }
  
  enum WeatherDetailInfo: Hashable {
    case humidity
    case minTemperature
    case maxTemperature
    case temperature
  }
  
  var weatherDetails: Array<String> {
    [humidity, minTemperature, maxTemperature, temperature]
  }
  
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D.init(latitude: item.coord.lat, longitude: item.coord.lon)
  }
  
  init(item: CurrentWeatherForecast) {
    self.item = item
  }
}
