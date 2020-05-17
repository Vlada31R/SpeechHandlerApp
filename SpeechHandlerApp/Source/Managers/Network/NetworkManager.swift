//
//  NetworkManager.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/17/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Alamofire

protocol NetworkManager {

    func getData<T: RequestConfiguratable>(input: T, completionHandler: @escaping (_ data: T.Response?) -> Void) where T.Response: Decodable

    func postData<T: RequestConfiguratable>(input: T,
                                            data: Data,
                                            fileName: String,
                                            completionHandler: @escaping (T.Response?) -> Void) where T.Response: Decodable
}

class NetworkManagerImp { }

// MARK: - NetworkManager
extension NetworkManagerImp: NetworkManager {

    func postData<T: RequestConfiguratable>(input: T,
                                            data: Data,
                                            fileName: String,
                                            completionHandler: @escaping (T.Response?) -> Void) where T.Response: Decodable {

        do {
            let request = try input.asURLRequest()

            guard let url = request.url
            else {
                completionHandler(nil)
                return
            }

            AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(data, withName: "data_file", fileName: fileName, mimeType: "audio/m4a")
                for (key, value) in input.parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            },to: url)
            .validate()
            .response { (response) in
                var info: T.Response?
                if let getData = response.data {
                    info = try? JSONDecoder().decode(T.Response.self, from: getData)
                }

                if info == nil, let getData = response.data {
                    let error = try? JSONDecoder().decode(Error.self, from: getData)
                }

                completionHandler(info)
            }
        } catch {
            completionHandler(nil)
        }
    }

    func getData<T: RequestConfiguratable>(input: T, completionHandler: @escaping (T.Response?) -> Void) where T.Response: Decodable {

        do {
            let request = try input.asURLRequest()
            executeRequest(with: request) { (userData) in
                completionHandler(userData)
            }
        } catch {
            completionHandler(nil)
        }
    }
    // MARK: - Alamofire request
    func executeRequest<T>(with request: URLRequest, completionHandler: @escaping (_ data: T?) -> Void) where T: Decodable {
        AF.request(request)
            .validate()
            .response { (response) in
                var info: T?
                if let data = response.data {
                    info = try? JSONDecoder().decode(T.self, from: data)
                }
                completionHandler(info)
            }
    }
}
