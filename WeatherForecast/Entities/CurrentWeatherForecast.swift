//
//  CurrentWeatherResponse.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import Foundation

struct CurrentWeatherForecast: Codable {
    let coord: Coord
    let main: Main
    let name: String

    struct Main: Codable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
}
