//
//  MockAPIClient.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import Foundation
import Combine

enum mockScenario {
    case currentWeatherSuccess
    case currenWeatherFailure(_ error: Error)
    case weeklyForeCastSuccess
    case weeklyForeCastFailure(_ error: Error)
}

struct MockAPIClient {
    
    var mockSuccess: Bool = false
    var mockScenario: mockScenario = .currentWeatherSuccess
    
    func getSampleCurrentWeatherListing()-> CurrentWeatherForecast {
        let jsonData = sampleCurrentWeatherListing.data(using: .utf8)!
        let value: CurrentWeatherForecast = try! JSONDecoder().decode(CurrentWeatherForecast.self, from: jsonData)
        return value
    }

    func getSampleWeeklyForeCast()-> WeeklyForeCast {
        let jsonData = sampleWeeklyForeCast.data(using: .utf8)!
        let value: WeeklyForeCast = try! JSONDecoder().decode(WeeklyForeCast.self, from: jsonData)
        return value
    }
}

//  WeatherForcastApiClient

extension MockAPIClient: WeatherForcastApiClient{

    func send<T: Codable & Decodable>(request: APIRequest) async throws -> T {
        switch mockScenario {
        case .currentWeatherSuccess:
            return getSampleCurrentWeatherListing() as! T
        case let .currenWeatherFailure(error):
            return error as! T
        case .weeklyForeCastSuccess:
            return getSampleWeeklyForeCast() as! T
        case let .weeklyForeCastFailure(error):
            return error as! T
        }
    }
    
}

let sampleCurrentWeatherListing = """
{
  "coord": {
    "lon": 10.99,
    "lat": 44.34
  },
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
  "visibility": 10000,
  "wind": {
    "speed": 0.62,
    "deg": 349,
    "gust": 1.18
  },
  "rain": {
    "1h": 3.16
  },
  "clouds": {
    "all": 100
  },
  "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
}
"""

let sampleWeeklyForeCast = """
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1637841600,
            "main": {
                "temp": 284.59,
                "feels_like": 283.2,
                "temp_min": 284.38,
                "temp_max": 284.59,
                "pressure": 1025,
                "sea_level": 1025,
                "grnd_level": 1023,
                "humidity": 54,
                "temp_kf": 0.21
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 20
            },
            "wind": {
                "speed": 3.37,
                "deg": 35,
                "gust": 4.21
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-25 12:00:00"
        },
        {
            "dt": 1637852400,
            "main": {
                "temp": 284.31,
                "feels_like": 282.92,
                "temp_min": 283.74,
                "temp_max": 284.31,
                "pressure": 1026,
                "sea_level": 1026,
                "grnd_level": 1024,
                "humidity": 55,
                "temp_kf": 0.57
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                }
            ],
            "clouds": {
                "all": 27
            },
            "wind": {
                "speed": 3.14,
                "deg": 42,
                "gust": 3.45
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-25 15:00:00"
        },
        {
            "dt": 1637863200,
            "main": {
                "temp": 285.57,
                "feels_like": 284.17,
                "temp_min": 285.57,
                "temp_max": 286.06,
                "pressure": 1027,
                "sea_level": 1027,
                "grnd_level": 1025,
                "humidity": 50,
                "temp_kf": -0.49
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 32
            },
            "wind": {
                "speed": 3.01,
                "deg": 53,
                "gust": 3.85
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-25 18:00:00"
        },
        {
            "dt": 1637874000,
            "main": {
                "temp": 288.64,
                "feels_like": 287.39,
                "temp_min": 288.64,
                "temp_max": 288.64,
                "pressure": 1026,
                "sea_level": 1026,
                "grnd_level": 1023,
                "humidity": 44,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 81
            },
            "wind": {
                "speed": 2.56,
                "deg": 23,
                "gust": 3.32
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-25 21:00:00"
        },
        {
            "dt": 1637884800,
            "main": {
                "temp": 288.68,
                "feels_like": 287.49,
                "temp_min": 288.68,
                "temp_max": 288.68,
                "pressure": 1026,
                "sea_level": 1026,
                "grnd_level": 1023,
                "humidity": 46,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 88
            },
            "wind": {
                "speed": 2.84,
                "deg": 354,
                "gust": 3.49
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-26 00:00:00"
        },
        {
            "dt": 1637895600,
            "main": {
                "temp": 287.12,
                "feels_like": 285.96,
                "temp_min": 287.12,
                "temp_max": 287.12,
                "pressure": 1026,
                "sea_level": 1026,
                "grnd_level": 1024,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 76
            },
            "wind": {
                "speed": 2.04,
                "deg": 14,
                "gust": 2.37
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-26 03:00:00"
        },
        {
            "dt": 1637906400,
            "main": {
                "temp": 286.27,
                "feels_like": 285.1,
                "temp_min": 286.27,
                "temp_max": 286.27,
                "pressure": 1026,
                "sea_level": 1026,
                "grnd_level": 1023,
                "humidity": 56,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 83
            },
            "wind": {
                "speed": 2.53,
                "deg": 38,
                "gust": 2.71
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-26 06:00:00"
        },
        {
            "dt": 1637917200,
            "main": {
                "temp": 285.68,
                "feels_like": 284.48,
                "temp_min": 285.68,
                "temp_max": 285.68,
                "pressure": 1025,
                "sea_level": 1025,
                "grnd_level": 1022,
                "humidity": 57,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 3.03,
                "deg": 16,
                "gust": 3.45
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-26 09:00:00"
        },
        {
            "dt": 1637928000,
            "main": {
                "temp": 285.45,
                "feels_like": 284.15,
                "temp_min": 285.45,
                "temp_max": 285.45,
                "pressure": 1024,
                "sea_level": 1024,
                "grnd_level": 1021,
                "humidity": 54,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 2.41,
                "deg": 26,
                "gust": 3.15
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-26 12:00:00"
        },
        {
            "dt": 1637938800,
            "main": {
                "temp": 284.95,
                "feels_like": 283.57,
                "temp_min": 284.95,
                "temp_max": 284.95,
                "pressure": 1024,
                "sea_level": 1024,
                "grnd_level": 1021,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 99
            },
            "wind": {
                "speed": 2.85,
                "deg": 16,
                "gust": 3.02
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-26 15:00:00"
        },
        {
            "dt": 1637949600,
            "main": {
                "temp": 287.09,
                "feels_like": 285.61,
                "temp_min": 287.09,
                "temp_max": 287.09,
                "pressure": 1024,
                "sea_level": 1024,
                "grnd_level": 1021,
                "humidity": 41,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 68
            },
            "wind": {
                "speed": 1.72,
                "deg": 55,
                "gust": 2.17
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-26 18:00:00"
        },
        {
            "dt": 1637960400,
            "main": {
                "temp": 289.33,
                "feels_like": 287.94,
                "temp_min": 289.33,
                "temp_max": 289.33,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1019,
                "humidity": 36,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 25
            },
            "wind": {
                "speed": 2.02,
                "deg": 5,
                "gust": 2.68
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-26 21:00:00"
        },
        {
            "dt": 1637971200,
            "main": {
                "temp": 288.85,
                "feels_like": 287.6,
                "temp_min": 288.85,
                "temp_max": 288.85,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 43,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 39
            },
            "wind": {
                "speed": 2.48,
                "deg": 320,
                "gust": 2.84
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-27 00:00:00"
        },
        {
            "dt": 1637982000,
            "main": {
                "temp": 287.71,
                "feels_like": 286.61,
                "temp_min": 287.71,
                "temp_max": 287.71,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 90
            },
            "wind": {
                "speed": 1.65,
                "deg": 304,
                "gust": 1.81
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-27 03:00:00"
        },
        {
            "dt": 1637992800,
            "main": {
                "temp": 287.16,
                "feels_like": 286,
                "temp_min": 287.16,
                "temp_max": 287.16,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 87
            },
            "wind": {
                "speed": 0.99,
                "deg": 22,
                "gust": 1.13
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-27 06:00:00"
        },
        {
            "dt": 1638003600,
            "main": {
                "temp": 286.81,
                "feels_like": 285.59,
                "temp_min": 286.81,
                "temp_max": 286.81,
                "pressure": 1019,
                "sea_level": 1019,
                "grnd_level": 1017,
                "humidity": 52,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 94
            },
            "wind": {
                "speed": 1.18,
                "deg": 19,
                "gust": 1.28
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-27 09:00:00"
        },
        {
            "dt": 1638014400,
            "main": {
                "temp": 286.19,
                "feels_like": 285.01,
                "temp_min": 286.19,
                "temp_max": 286.19,
                "pressure": 1019,
                "sea_level": 1019,
                "grnd_level": 1017,
                "humidity": 56,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 57
            },
            "wind": {
                "speed": 1.7,
                "deg": 24,
                "gust": 1.74
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-27 12:00:00"
        },
        {
            "dt": 1638025200,
            "main": {
                "temp": 285.65,
                "feels_like": 284.44,
                "temp_min": 285.65,
                "temp_max": 285.65,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 57,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                }
            ],
            "clouds": {
                "all": 46
            },
            "wind": {
                "speed": 2.02,
                "deg": 39,
                "gust": 2.2
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-27 15:00:00"
        },
        {
            "dt": 1638036000,
            "main": {
                "temp": 287.91,
                "feels_like": 286.67,
                "temp_min": 287.91,
                "temp_max": 287.91,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 47,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 27
            },
            "wind": {
                "speed": 2.44,
                "deg": 28,
                "gust": 2.88
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-27 18:00:00"
        },
        {
            "dt": 1638046800,
            "main": {
                "temp": 290.1,
                "feels_like": 288.97,
                "temp_min": 290.1,
                "temp_max": 290.1,
                "pressure": 1019,
                "sea_level": 1019,
                "grnd_level": 1016,
                "humidity": 43,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 12
            },
            "wind": {
                "speed": 2.51,
                "deg": 17,
                "gust": 3.38
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-27 21:00:00"
        },
        {
            "dt": 1638057600,
            "main": {
                "temp": 289.88,
                "feels_like": 288.91,
                "temp_min": 289.88,
                "temp_max": 289.88,
                "pressure": 1018,
                "sea_level": 1018,
                "grnd_level": 1016,
                "humidity": 50,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 26
            },
            "wind": {
                "speed": 2.55,
                "deg": 342,
                "gust": 3.09
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-28 00:00:00"
        },
        {
            "dt": 1638068400,
            "main": {
                "temp": 288.37,
                "feels_like": 287.49,
                "temp_min": 288.37,
                "temp_max": 288.37,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 59,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 24
            },
            "wind": {
                "speed": 1.65,
                "deg": 339,
                "gust": 1.91
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-28 03:00:00"
        },
        {
            "dt": 1638079200,
            "main": {
                "temp": 287.93,
                "feels_like": 287.03,
                "temp_min": 287.93,
                "temp_max": 287.93,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1018,
                "humidity": 60,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 16
            },
            "wind": {
                "speed": 1.4,
                "deg": 49,
                "gust": 1.5
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-28 06:00:00"
        },
        {
            "dt": 1638090000,
            "main": {
                "temp": 287.46,
                "feels_like": 286.62,
                "temp_min": 287.46,
                "temp_max": 287.46,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1018,
                "humidity": 64,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 6
            },
            "wind": {
                "speed": 1.8,
                "deg": 46,
                "gust": 1.88
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-28 09:00:00"
        },
        {
            "dt": 1638100800,
            "main": {
                "temp": 287.1,
                "feels_like": 286.27,
                "temp_min": 287.1,
                "temp_max": 287.1,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 66,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 5
            },
            "wind": {
                "speed": 2.15,
                "deg": 36,
                "gust": 2.24
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-28 12:00:00"
        },
        {
            "dt": 1638111600,
            "main": {
                "temp": 286.68,
                "feels_like": 285.84,
                "temp_min": 286.68,
                "temp_max": 286.68,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1019,
                "humidity": 67,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.51,
                "deg": 44,
                "gust": 2.7
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-28 15:00:00"
        },
        {
            "dt": 1638122400,
            "main": {
                "temp": 288.78,
                "feels_like": 287.89,
                "temp_min": 288.78,
                "temp_max": 288.78,
                "pressure": 1022,
                "sea_level": 1022,
                "grnd_level": 1020,
                "humidity": 57,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.85,
                "deg": 38,
                "gust": 3.57
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-28 18:00:00"
        },
        {
            "dt": 1638133200,
            "main": {
                "temp": 291.12,
                "feels_like": 290.28,
                "temp_min": 291.12,
                "temp_max": 291.12,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1018,
                "humidity": 50,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.77,
                "deg": 23,
                "gust": 4
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-28 21:00:00"
        },
        {
            "dt": 1638144000,
            "main": {
                "temp": 291.07,
                "feels_like": 290.25,
                "temp_min": 291.07,
                "temp_max": 291.07,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 51,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.42,
                "deg": 351,
                "gust": 3.18
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-29 00:00:00"
        },
        {
            "dt": 1638154800,
            "main": {
                "temp": 289.39,
                "feels_like": 288.53,
                "temp_min": 289.39,
                "temp_max": 289.39,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 56,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.69,
                "deg": 24,
                "gust": 1.8
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-29 03:00:00"
        },
        {
            "dt": 1638165600,
            "main": {
                "temp": 288.61,
                "feels_like": 287.73,
                "temp_min": 288.61,
                "temp_max": 288.61,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 58,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.67,
                "deg": 50,
                "gust": 1.76
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-29 06:00:00"
        },
        {
            "dt": 1638176400,
            "main": {
                "temp": 287.84,
                "feels_like": 286.96,
                "temp_min": 287.84,
                "temp_max": 287.84,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 61,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.91,
                "deg": 42,
                "gust": 1.95
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-29 09:00:00"
        },
        {
            "dt": 1638187200,
            "main": {
                "temp": 287.19,
                "feels_like": 286.29,
                "temp_min": 287.19,
                "temp_max": 287.19,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 63,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.94,
                "deg": 34,
                "gust": 1.96
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-29 12:00:00"
        },
        {
            "dt": 1638198000,
            "main": {
                "temp": 286.65,
                "feels_like": 285.73,
                "temp_min": 286.65,
                "temp_max": 286.65,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1019,
                "humidity": 64,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.17,
                "deg": 38,
                "gust": 2.33
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-29 15:00:00"
        },
        {
            "dt": 1638208800,
            "main": {
                "temp": 288.95,
                "feels_like": 288,
                "temp_min": 288.95,
                "temp_max": 288.95,
                "pressure": 1022,
                "sea_level": 1022,
                "grnd_level": 1020,
                "humidity": 54,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.02,
                "deg": 27,
                "gust": 2.29
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-29 18:00:00"
        },
        {
            "dt": 1638219600,
            "main": {
                "temp": 290.53,
                "feels_like": 289.71,
                "temp_min": 290.53,
                "temp_max": 290.53,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.02,
                "deg": 336,
                "gust": 2.66
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-29 21:00:00"
        },
        {
            "dt": 1638230400,
            "main": {
                "temp": 289.52,
                "feels_like": 288.99,
                "temp_min": 289.52,
                "temp_max": 289.52,
                "pressure": 1020,
                "sea_level": 1020,
                "grnd_level": 1017,
                "humidity": 68,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 2.6,
                "deg": 282,
                "gust": 3.01
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2021-11-30 00:00:00"
        },
        {
            "dt": 1638241200,
            "main": {
                "temp": 287.77,
                "feels_like": 287.4,
                "temp_min": 287.77,
                "temp_max": 287.77,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 81,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 11
            },
            "wind": {
                "speed": 2.07,
                "deg": 276,
                "gust": 2.41
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-30 03:00:00"
        },
        {
            "dt": 1638252000,
            "main": {
                "temp": 287.12,
                "feels_like": 286.79,
                "temp_min": 287.12,
                "temp_max": 287.12,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 85,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 17
            },
            "wind": {
                "speed": 1.25,
                "deg": 267,
                "gust": 1.58
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-30 06:00:00"
        },
        {
            "dt": 1638262800,
            "main": {
                "temp": 286.85,
                "feels_like": 286.52,
                "temp_min": 286.85,
                "temp_max": 286.85,
                "pressure": 1021,
                "sea_level": 1021,
                "grnd_level": 1018,
                "humidity": 86,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                }
            ],
            "clouds": {
                "all": 44
            },
            "wind": {
                "speed": 0.39,
                "deg": 40,
                "gust": 0.78
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2021-11-30 09:00:00"
        }
    ],
    "city": {
        "id": 5391959,
        "name": "San Francisco",
        "coord": {
            "lat": 37.7858,
            "lon": -122.4064
        },
        "country": "US",
        "population": 805235,
        "timezone": -28800,
        "sunrise": 1637852457,
        "sunset": 1637887976
    }
}
"""
