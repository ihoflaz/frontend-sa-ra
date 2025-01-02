//
//  GroupDetailView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct GroupDetailView: View {
    let group: Group
    
    var body: some View {
        List {
            Section("Grup Bilgileri") {
                // Grup adı
                HStack {
                    Text("Grup Adı")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(group.name)
                }
                
                // Rehber bilgisi
                HStack {
                    Text("Rehber")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(group.guideId)
                }
                
                // Tarih bilgileri
                HStack {
                    Text("Başlangıç")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(group.startDate.formatted(date: .numeric, time: .omitted))
                }
                
                HStack {
                    Text("Bitiş")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(group.endDate.formatted(date: .numeric, time: .omitted))
                }
                
                // Durum
                HStack {
                    Text("Durum")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(group.isActive ? "Aktif" : "Pasif")
                }
            }
            
            // Katılımcılar bölümü
            Section("Katılımcılar") {
                ForEach(Array(group.participants.keys), id: \.self) { userId in
                    if let userName = group.participants[userId] {
                        Text(userName)
                    }
                }
            }
            
            // Mesajlaşma bölümü
            Section("Mesajlar") {
                Text("Mesajlaşma yakında eklenecek")
                    .foregroundStyle(.gray)
            }
        }
        .navigationTitle(group.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Önizleme için örnek veri
struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GroupDetailView(
                group: Group(
                    id: "1",
                    name: "Roma Turu",
                    description: "7 günlük Roma turu",
                    guideId: "guide1",
                    startDate: Date(),
                    endDate: Date().addingTimeInterval(7*24*60*60),
                    isActive: true,
                    participants: ["user1": "Demo Kullanıcı"]
                )
            )
        }
    }
}
