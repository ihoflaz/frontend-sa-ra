// 
//  User.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    // Firebase ID - DocumentID wrapper'ı yerine normal String
    var id: String?
    
    // Temel bilgiler
    let phoneNumber: String
    var firstName: String?
    var lastName: String?
    var email: String?
    
    // Sistem bilgileri
    var role: UserRole = .user
    var isVerified: Bool = false
    var status: UserStatus = .active
    
    // Zaman damgaları
    let createdAt: Date
    var updatedAt: Date
    
    // Özel kodlama anahtarları
    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber
        case firstName
        case lastName
        case email
        case role
        case isVerified
        case status
        case createdAt
        case updatedAt
    }
    
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
    
    // Firebase'den veri oluşturma
    static func fromFirebaseUser(_ firebaseUser: FirebaseAuth.User) -> User {
        return User(
            id: firebaseUser.uid, // Explicit ID assignment
            phoneNumber: firebaseUser.phoneNumber ?? "",
            createdAt: firebaseUser.metadata.creationDate ?? Date(),
            updatedAt: firebaseUser.metadata.lastSignInDate ?? Date()
        )
    }
    
    // Firestore'dan document oluşturma
    static func fromFirestore(_ document: DocumentSnapshot) -> User? {
        guard let data = document.data() else { return nil }
        
        return User(
            id: document.documentID,
            phoneNumber: data["phoneNumber"] as? String ?? "",
            firstName: data["firstName"] as? String,
            lastName: data["lastName"] as? String,
            email: data["email"] as? String,
            role: UserRole(rawValue: data["role"] as? String ?? "user") ?? .user,
            isVerified: data["isVerified"] as? Bool ?? false,
            status: UserStatus(rawValue: data["status"] as? String ?? "active") ?? .active,
            createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date(),
            updatedAt: (data["updatedAt"] as? Timestamp)?.dateValue() ?? Date()
        )
    }
    
    // Firestore'a kaydetmek için
    func toFirestore() -> [String: Any] {
        return [
            "phoneNumber": phoneNumber,
            "firstName": firstName as Any,
            "lastName": lastName as Any,
            "email": email as Any,
            "role": role.rawValue,
            "isVerified": isVerified,
            "status": status.rawValue,
            "createdAt": createdAt,
            "updatedAt": updatedAt
        ]
    }
}
