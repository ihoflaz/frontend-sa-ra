//
//  Group.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import Foundation

struct Group: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
    var guideId: String
    var startDate: Date
    var endDate: Date
    var isActive: Bool
    var participants: [String: String] // [UserId: UserName]
    
    init(id: String,
         name: String,
         description: String,
         guideId: String,
         startDate: Date,
         endDate: Date,
         isActive: Bool,
         participants: [String: String] = [:]) {
        self.id = id
        self.name = name
        self.description = description
        self.guideId = guideId
        self.startDate = startDate
        self.endDate = endDate
        self.isActive = isActive
        self.participants = participants
    }
}

// Grup detay görünümü için model
struct GroupDetail: Codable {
    let group: Group
    let members: [GroupMember]
    let invitations: [GroupInvitation]
}

// Grup üyesi modeli
struct GroupMember: Codable, Identifiable {
    var id: String { user.id ?? "1" }
    let user: User
    let status: String
    let joinedAt: Date
}

// Grup daveti modeli
struct GroupInvitation: Codable, Identifiable {
    var id: String { user.id ?? "1" }
    let user: User
    let status: String
    let invitedAt: Date
    let expiresAt: Date
}
