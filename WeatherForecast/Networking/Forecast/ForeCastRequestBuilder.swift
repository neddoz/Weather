//
//  ForeCastRequestBuilder.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import Foundation
import CoreLocation

struct ForeCastRequestBuilder {
    
    mutating func makeCurrentDayForecastRequest(for city: CLLocationCoordinate2D) -> APIRequest {
        self.components["lat"] = "\(city.latitude)"
        self.components["lon"] = "\(city.longitude)"
        return DailyForeCastRequest(parameters: components)
    }
    
    mutating func makeWeeklyForecastRequest(for city: CLLocationCoordinate2D) -> APIRequest {
        self.components["lat"] = "\(city.latitude)"
        self.components["lon"] = "\(city.longitude)"
        return WeeklyForeCastRequest(parameters: components)
    }
    
    // url componets
    private var components: [String: String] = ["mode": "json",
                                                "units": "metric",
                                                "APPID": WeatherForecastAPIKeys.openWeatherKey]
}
