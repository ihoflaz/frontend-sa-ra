// 
//  APIService.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import Foundation

enum APIError: Error {
    case invalidInput
    case serverError(String)
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    // Demo veriler
    private let mockVerificationCodes = [
        "5551234567": "1111",
        "5559876543": "2222"
    ]
    
    // Telefon doğrulama simülasyonu
    func verifyPhone(_ phoneNumber: String, code: String) async throws -> (User, String, String) {
        // Demo gecikme
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let expectedCode = mockVerificationCodes[phoneNumber] else {
            throw APIError.serverError("Geçersiz telefon numarası")
        }
        
        guard code == expectedCode else {
            throw APIError.serverError("Geçersiz doğrulama kodu")
        }
        
        // Demo kullanıcı oluştur
        let role: UserRole = phoneNumber == "5559876543" ? .admin : .user
        let user = User(
            id: UUID().uuidString,
            phoneNumber: phoneNumber,
            firstName: role == .admin ? "Demo Admin" : "Demo Kullanıcı",
            lastName: "Test",
            email: "demo@example.com",
            role: role,
            isVerified: true,
            status: .active,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        return (user, "demo_access_token", "demo_refresh_token")
    }
}
