//
//  VerifyMessageModel.swift
//  wpp-client
//
//  Created by  Hanah Santana on 05/09/24.
//

import Foundation

struct VerifyMessage: Codable {
    let from: String
    let content: [Message]
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
