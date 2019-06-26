//
//  Response.swift
//  LoginTest
//
//  Created by Mostafa Abd ElFatah on 6/25/19.
//  Copyright © 2019 Mostafa Abd ElFatah. All rights reserved.
//

import Foundation

// MARK: - Auth
struct Auth: Codable {
    let success: Bool
    let message: String
    let data: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let email, mobile, firstName, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, mobile
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
