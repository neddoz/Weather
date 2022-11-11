//
//  URLResponse+Extension.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 09/11/2022.
//

import Foundation

import Foundation

extension URLResponse{

    public enum HTTPStatus{
        public enum description{
            case success
            case created
            case badRequest
            case unauthorized
            case forbidden
            case notFound
            case conflict
            case serverError
            case other
        }
        
        case code(Int)
        
        var status: description{
            switch self{
            case .code(200...299):
                return .success
            case .code(400):
                return .badRequest
            case .code(401):
                return .unauthorized
            case .code(403):
                return .forbidden
            case .code(404):
                return .notFound
            case .code(409):
                return .conflict
            case .code(500...599):
                return .serverError
            default:
                return .other
            }
        }
    }
    
    var status: HTTPStatus.description {
        let response = self as? HTTPURLResponse ?? HTTPURLResponse()
        
        let statusCode = HTTPStatus.code(response.statusCode).status
        return statusCode
    }
    
}

public enum NetworkError: Error {
    case DecodingFailure(errorMessage: String)
    case BadRequest(errorMessage: String)
    case Unauthorized
    case NotFound(errorMessage: String)
    case other(errorMessage: String)
    
    init(response: URLResponse, message: String) {
        switch response.status {
        case .badRequest:
            self = .BadRequest(errorMessage: message)
        case .notFound:
            self = .BadRequest(errorMessage: message)
        case .unauthorized:
            self = .Unauthorized
        default:
            self = .other(errorMessage: message)
        }
    }
    
    func errorMessage()-> String {
        switch self {
        case .BadRequest(let message):
            return message
        case .NotFound(let message):
            return message
        case .DecodingFailure(let message):
            return message
        case .Unauthorized:
            return "Unauthorized"
        case .other(errorMessage: let message):
            return message
        }
    }
}
