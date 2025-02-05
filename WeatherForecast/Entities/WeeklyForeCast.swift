//
//  WeeklyForeCast.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation

struct WeeklyForeCast: Codable {
    let list: [WeeklyForeCastItem]
}

struct WeeklyForeCastItem: Codable {
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
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
