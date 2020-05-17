//
//  Error.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/17/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

struct Error: Decodable {

    var code: Int
    var error: String
}

enum ErrorCodingKeys: String, CodingKey {

    case code
    case error
}

extension Error {

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: ErrorCodingKeys.self)

        let code = try container.decode(Int.self, forKey: .code)
        self.code = code

        let error = try container.decode(String.self, forKey: .error)
        self.error = error
    }
}

