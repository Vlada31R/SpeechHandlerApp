//
//  TrackModel.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Alamofire

struct TrackModel {

    let name: String
    let description: String?
    
    let containerFileName: String

    var isTransformed: Bool
    var text: String?

    func model() -> [String: Any] {
        return ["name" : name,
         "description" : description,
    "containerFileName": containerFileName,
       "isTransformed" : isTransformed,
                "text" : text]
    }
}

// MARK: - RequestConfiguratable
extension TrackModel: RequestConfiguratable {

    typealias Response = PostTrackResponse

    var baseURL: String {
        return "https://api.speechmatics.com/v1.0/"
    }

    var path: String {
        return "/v1.0" + "/" + NetworkingConstants.user + "/" + NetworkingConstants.userId + "/" + NetworkingConstants.jobs + "/"
    }

    var parameters: [String: String] {

        var paramDict: [String: String] = [:]
        return paramDict
    }

    var method: HTTPMethod {
        return .post
    }

    var queryItems: [String: String] {

        var paramDict: [String: String] = [:]
        paramDict[NetworkingConstants.authToken] = NetworkingConstants.authTokenValue
        return paramDict
    }
}
