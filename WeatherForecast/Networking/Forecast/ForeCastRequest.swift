//
//  ForeCastRequest.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//
import Foundation

class DailyForeCastRequest: APIRequest {
    var method = RequestType.GET
    var path = "weather"
    var parameters: [String: String]
    
    init(parameters: [String : String]) {
        self.parameters = parameters
    }
}

class WeeklyForeCastRequest: APIRequest {
    var method = RequestType.GET
    var path = "forecast"
    var parameters: [String: String]

    init(parameters: [String : String]) {
        self.parameters = parameters
    }
}

