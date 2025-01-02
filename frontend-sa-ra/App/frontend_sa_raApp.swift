//
//  SafeRangeApp.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

@main
struct frontend_sa_raApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.isAuthenticated {
                if appViewModel.currentUser?.role == .admin {
                    AdminTabView()
                        .environmentObject(appViewModel)
                } else {
                    MainTabView()
                        .environmentObject(appViewModel)
                }
            } else {
                LoginView()
                    .environmentObject(appViewModel)
            }
        }
    }
}
