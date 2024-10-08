//
//  MessageModel.swift
//  wpp-client
//
//  Created by  Hanah Santana on 05/09/24.
//

import Foundation

struct Message: Codable {
    let from: String
    let to: String
    let content: String

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

