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
}

// MARK: - RequestConfiguratable
extension TrackModel: RequestConfiguratable {

    typealias Response = PostTrackResponse

    var path: String {
        return "/v1.0" + "/" + NetworkingConstants.user + "/" + NetworkingConstants.userId + "/" + NetworkingConstants.jobs + "/"
    }

    var parameters: [String: String] {

        var paramDict: [String: String] = [:]
        paramDict["model"] = "en-US"
        return paramDict
    }

    var method: HTTPMethod {
        return .post
    }
}
