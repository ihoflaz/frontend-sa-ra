//
//  MessagesView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 31.12.2024.
//

import SwiftUI

struct MessagesView: View {
    @State private var selectedUser: String? = nil
    @State private var showingUserGroups = false
    
    // Demo kullanıcı verileri
    let users = [
        UserInfo(id: "1", name: "Ahmet Yılmaz", groups: ["Roma Turu", "İstanbul Turu"]),
        UserInfo(id: "2", name: "Mehmet Demir", groups: ["Paris Turu", "Kapadokya Turu"]),
        UserInfo(id: "3", name: "Ayşe Kaya", groups: ["Roma Turu", "Paris Turu", "Antalya Turu"])
    ]
    
    var body: some View {
        NavigationView {
            List(users) { user in
                Button(action: {
                    selectedUser = user.id
                    showingUserGroups = true
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text("Son görülme: Bugün")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                }
                .foregroundStyle(.primary)
            }
            .navigationTitle("Mesajlar")
            .sheet(isPresented: $showingUserGroups) {
                if let userId = selectedUser,
                   let selectedUser = users.first(where: { currentUser in currentUser.id == userId }) {
                    UserGroupsView(user: selectedUser)
                }
            }
        }
    }
}

// Kullanıcı bilgi modeli
struct UserInfo: Identifiable {
    let id: String
    let name: String
    let groups: [String]
}

// Kullanıcının gruplarını gösteren view
struct UserGroupsView: View {
    let user: UserInfo
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Dahil Olduğu Gruplar") {
                    ForEach(user.groups, id: \.self) { group in
                        HStack {
                            Image(systemName: "person.3.fill")
                                .foregroundStyle(.blue)
                            Text(group)
                            Spacer()
                            Text("Aktif")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                    }
                }
                
                if user.groups.isEmpty {
                    Text("Henüz bir gruba dahil değil")
                        .foregroundStyle(.gray)
                        .italic()
                }
            }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Önizleme
struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
