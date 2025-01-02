//
//  GroupDetailView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct GroupDetailView: View {
    let group: Group
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    
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
                ForEach(messages) { message in
                    MessageBubbleView(message: message)
                }
                
                HStack {
                    TextField("Mesajınız...", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(.blue)
                    }
                    .disabled(newMessage.isEmpty)
                }
                .padding(.vertical, 8)
            }
        }
        .onAppear {
            // Mevcut mesajları yükle
            messages = MockData.getMessages(for: group.id)
        }
        .onReceive(NotificationCenter.default.publisher(for: .newMessageReceived)) { notification in
            if let groupId = notification.userInfo?["groupId"] as? String,
               groupId == group.id,
               let message = notification.userInfo?["message"] as? Message {
                messages.append(message)
            }
        }
        .navigationTitle(group.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        let message = Message(
            content: newMessage,
            senderName: "Kullanıcı"
        )
        
        // Mesajı paylaşılan mock verilere ekle
        MockData.addMessage(to: group.id, message: message)
        
        // TextField'ı temizle
        newMessage = ""
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
