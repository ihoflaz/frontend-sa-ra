// 
//  AppViewModel.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // Demo giriş bilgileri
    private let demoUsers: [String: User] = [
        "5551234567": User(
            id: "1",
            phoneNumber: "5551234567",
            firstName: "Demo",
            lastName: "Kullanıcı",
            email: "demo@example.com",
            role: .user,
            isVerified: true,
            status: .active,
            createdAt: Date(),
            updatedAt: Date()
        ),
        "5559876543": User(
            id: "2",
            phoneNumber: "5559876543",
            firstName: "Demo",
            lastName: "Admin",
            email: "admin@example.com",
            role: .admin,
            isVerified: true,
            status: .active,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]
    
    func login(phoneNumber: String) {
        isLoading = true
        errorMessage = nil
        
        // Demo giriş simülasyonu
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let user = self?.demoUsers[phoneNumber] {
                self?.currentUser = user
                self?.isAuthenticated = true
                self?.errorMessage = nil
            } else {
                self?.errorMessage = "Geçersiz telefon numarası"
            }
            self?.isLoading = false
        }
    }
    
    func logout() {
        isAuthenticated = false
        currentUser = nil
    }
}
