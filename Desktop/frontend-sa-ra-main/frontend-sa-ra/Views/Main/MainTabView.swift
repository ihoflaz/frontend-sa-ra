//
//  MainTabView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Ana Sayfa
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Ana Sayfa")
                }
            
            // Gruplar
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Gruplar")
                }
            
            // Mesajlar
            MessagesView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Mesajlar")
                }
            
            // Profil
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profil")
                }
        }
    }
}

// Önizleme
#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
