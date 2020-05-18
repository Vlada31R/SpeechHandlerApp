//
//  Job.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/18/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Alamofire

struct Job {

    let id: Int
}

// MARK: - RequestConfiguratable
extension Job: RequestConfiguratable {

    typealias Response = String

    var path: String {
        return "/v1.0" + "/" + NetworkingConstants.user + "/" + NetworkingConstants.userId + "/" + NetworkingConstants.jobs + "/\(id)/transcript"
    }

    var parameters: [String: String] {

        var paramDict: [String: String] = [:]
        return paramDict
    }

    var method: HTTPMethod {
        return .get
    }

    var queryItems: [String: String] {

        var paramDict: [String: String] = [:]
        paramDict["format"] = "txt"
        return paramDict
    }
}
