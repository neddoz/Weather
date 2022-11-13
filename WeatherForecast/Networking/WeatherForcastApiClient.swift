//
//  WeatherForcastApiClient.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import Foundation
import Combine

protocol WeatherForcastApiClient {
    
    static var shared: WeatherForcastApiClient { get }
    func send<T: Codable & Decodable>(request: APIRequest) -> AnyPublisher<T, Error>
}

final class APIClient: WeatherForcastApiClient {


    static var shared: WeatherForcastApiClient {
        return APIClient.instance
    }
    
    func send<T: Codable>(request: APIRequest) -> AnyPublisher<T, Error>{
        return session.dataTaskPublisher(for: request.urlRequest()).tryMap { data, response in
            guard response.status == .success else {
                throw NetworkError(response: response, message: "")
            }
            
            do {
                return try self.decoder.decode(T.self, from: data)
            } catch let error {
                throw NetworkError.DecodingFailure(errorMessage: error.localizedDescription)
            }
            
        }.mapError { error in
            if let error = error as? NetworkError {
                return error
            } else {
                return NetworkError.other(errorMessage: error.localizedDescription)
            }
        }.eraseToAnyPublisher()
    }
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    private static let instance: APIClient = .init(session: URLSession.shared, decoder: JSONDecoder())
    private var session: URLSession = .shared
    private var decoder: JSONDecoder
}
