//
//  ApiRequest+Extension.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import Foundation

public enum RequestType: String {
    case GET
}

public protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func urlRequest(with baseURL: URL = URL(string: "https://api.openweathermap.org/data/2.5/")!) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
