//
//  User.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
