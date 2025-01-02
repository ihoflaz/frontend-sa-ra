// 
//  User.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import Foundation

// Kullanıcı rolleri için enum
enum UserRole: String, Codable {
    case user = "user"
    case guide = "guide"
    case admin = "admin"
}

// Kullanıcı durumu için enum
enum UserStatus: String, Codable {
    case active = "active"
    case blocked = "blocked"
    case deleted = "deleted"
}

// Kullanıcı modeli
struct User: Identifiable, Codable {
    var id: String?
    let phoneNumber: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var role: UserRole = .user
    var isVerified: Bool = false
    var status: UserStatus = .active
    let createdAt: Date
    var updatedAt: Date
    
    // Decoder için init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        role = try container.decodeIfPresent(UserRole.self, forKey: .role) ?? .user
        isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        status = try container.decodeIfPresent(UserStatus.self, forKey: .status) ?? .active
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    // Normal init
    init(id: String? = nil,
         phoneNumber: String,
         firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         role: UserRole = .user,
         isVerified: Bool = false,
         status: UserStatus = .active,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.role = role
        self.isVerified = isVerified
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
