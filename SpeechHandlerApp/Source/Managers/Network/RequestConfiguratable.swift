//
//  RequestConfiguratable.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/17/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Alamofire

protocol RequestConfiguratable: URLRequestConvertible {

    associatedtype Response

    var path: String { get }
    var parameters: [String: String] { get }
    var method: HTTPMethod { get }
}

extension RequestConfiguratable {

    func asURLRequest() throws -> URLRequest {

        let url = try NetworkingConstants.baseURL.asURL()

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: NetworkingConstants.authToken, value: NetworkingConstants.authTokenValue)
        ]
        var urlRequest = URLRequest(url: urlComponents.url!)

        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = ["Content-Type" : "application/json"]

        return try URLEncoding.default.encode(urlRequest, with: [:])
    }
}
