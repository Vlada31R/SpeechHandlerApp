//
//  ConvertedText.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/20/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Alamofire

struct ConvertedText {

    let text: String
}

// MARK: - RequestConfiguratable
extension ConvertedText: RequestConfiguratable {

    typealias Response = String

    var baseURL: String {
        return "http://bark.phon.ioc.ee"
    }

    var path: String {
        return "/punctuator"
    }

    var parameters: [String: String] {

        var paramDict: [String: String] = [:]
        paramDict["text"] = text
        return paramDict
    }

    var method: HTTPMethod {
        return .post
    }

    var queryItems: [String: String] {

        var paramDict: [String: String] = [:]
        return paramDict
    }
}
