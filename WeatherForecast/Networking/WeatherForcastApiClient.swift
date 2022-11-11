//
//  WeatherForcastApiClient.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import Foundation
import Combine

public enum WeatherForeCastError: Error {
    case network(description: String)
    case parsing(description: String)
}


protocol WeatherForcastApiClient {
    
    static var shared: WeatherForcastApiClient { get }
    func send<T: Codable & Decodable>(request: APIRequest,
                          session: URLSession, decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

extension WeatherForcastApiClient {
    func send<T: Codable & Decodable>(request: APIRequest,
                                      session: URLSession = .shared,
                                      decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        fatalError("\(#function) not implemented")
    }
}


final class APIClient: WeatherForcastApiClient {


    static var shared: WeatherForcastApiClient {
        return APIClient.instance
    }
    
    func send<T: Codable>(request: APIRequest,
                          session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error>{
        return session.dataTaskPublisher(for: request.urlRequest()).tryMap { data, response in
            guard response.status == .success else {
                throw NetworkError(response: response, message: "")
            }
            
            do {
                return try decoder.decode(T.self, from: data)
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

    private static let instance: APIClient = .init()
}


fileprivate func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
  let decoder = JSONDecoder()
  
  decoder.dateDecodingStrategy = .secondsSince1970
  
  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      WeatherForeCastError.parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

fileprivate func propagateError(from response: URLResponse) -> AnyPublisher<Any, Error> {
    return Fail(error: NetworkError(response: response, message: "")).eraseToAnyPublisher()
}
