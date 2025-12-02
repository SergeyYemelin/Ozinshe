//
//  UserProfile.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 29.11.2025.
//

import Foundation

struct UserProfileResponse: Codable {
    let birthDate: String?
    let id: Int?
    let language: String?
    let name: String?
    let phoneNumber: String?
    let user: UserShort?
}

struct UserShort: Codable {
    let email: String?
    let id: Int?
}

struct UpdateUserProfileRequest: Codable {
    let id: Int?
    let name: String
    let phoneNumber: String
    let language: String
    let birthDate: String
}

struct ChangePasswordRequest: Codable {
    let password: String
}
