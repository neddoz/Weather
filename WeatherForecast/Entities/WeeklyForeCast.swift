//
//  WeeklyForeCast.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation

struct WeeklyForeCast: Codable {
    let list: [List]
}

struct List: Codable {
    let weather: [Weather]
    let date: Date
    let main: Main

    enum CodingKeys: String, CodingKey {
        case weather, main
        case date = "dt"
    }
}

struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
