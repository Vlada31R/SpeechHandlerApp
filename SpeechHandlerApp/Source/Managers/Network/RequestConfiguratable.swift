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
    var baseURL: String  { get }
    var parameters: [String: String] { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }
}

extension RequestConfiguratable {

    func asURLRequest() throws -> URLRequest {

        let url = try baseURL.asURL()

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.path = path

        urlComponents.queryItems = !queryItems.isEmpty ? [] : nil
        queryItems.forEach { (key, value) in
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        var urlRequest = URLRequest(url: urlComponents.url!)

        urlRequest.httpMethod = method.rawValue

        if baseURL == "http://bark.phon.ioc.ee" {
            let data = "{\"text\": \"\(parameters["text"])\"}".data(using: .utf8)
            urlRequest.setValue("\(data!.count)", forHTTPHeaderField: "Content-Length")
        } else {
            urlRequest.headers = ["Content-Type" : "application/json"]
        }

        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
