//
//  File.swift
//
//
//  Created by Luiz Sena on 02/09/24.
//

import Foundation


enum DTO: Codable {
    case message
    case verifyMessages
}

struct DataWrapper: Codable {
    let contentType: DTO
    let content: Data

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}


