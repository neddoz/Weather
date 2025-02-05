//
//  WeatherForcastApiClient.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import Foundation
import Combine

protocol WeatherForcastApiClient: Sendable {
    func send<T: Codable>(request: APIRequest) async throws -> T
}

import Foundation

struct APIClient: WeatherForcastApiClient {
    
    struct Dependencies {
        var session: URLSession
        var decoder: JSONDecoder
    }

    // Send an API request and decode the response
    func send<T: Codable>(request: APIRequest) async throws -> T {
        let (data, response) = try await session.data(for: request.urlRequest())

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.status == .success  else {
            throw NetworkError(response: response, message: "Invalid response")
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.DecodingFailure(errorMessage: error.localizedDescription)
        }
    }

    private var session: URLSession
    private var decoder: JSONDecoder
}

extension APIClient {
    init(dependencies: Dependencies = .init(session: .shared, decoder: .init())) {
        self.session = dependencies.session
        self.decoder = dependencies.decoder
    }
}
