//
//  PostTrackResponse.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/17/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

struct PostTrackResponse: Decodable {

    var balance: Int
    var check_wait: Int
    var cost: Int
    var id: Int
}

enum PostTrackResponseCodingKeys: String, CodingKey {

    case balance
    case check_wait
    case cost
    case id
}

extension PostTrackResponse {

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: PostTrackResponseCodingKeys.self)

        let balance = try container.decode(Int.self, forKey: .balance)
        self.balance = balance

        let check_wait = try container.decode(Int.self, forKey: .check_wait)
        self.check_wait = check_wait

        let cost = try container.decode(Int.self, forKey: .cost)
        self.cost = cost

        let id = try container.decode(Int.self, forKey: .id)
        self.id = id
    }
}
