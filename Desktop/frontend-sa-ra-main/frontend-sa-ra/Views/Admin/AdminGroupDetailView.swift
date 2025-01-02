//
//  AdminGroupDetailView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct AdminGroupDetailView: View {
    let group: Group
    @StateObject private var groupViewModel = GroupViewModel()
    @State private var showingEditSheet = false
    @State private var editedName: String = ""
    @State private var editedDescription: String = ""
    @State private var editedStartDate: Date = Date()
    @State private var editedEndDate: Date = Date()
    
    var body: some View {
        List {
            Section("Grup Bilgileri") {
                VStack(alignment: .leading) {
                    Text("Grup Adı: \(group.name)")
                    Text("Açıklama: \(group.description)")
                    Text("Başlangıç: \(group.startDate.formatted())")
                    Text("Bitiş: \(group.endDate.formatted())")
                    Text("Durum: \(group.isActive ? "Aktif" : "Pasif")")
                }
            }
            
            Section("Katılımcılar") {
                ForEach(Array(group.participants.keys), id: \.self) { userId in
                    if let userName = group.participants[userId] {
                        Text(userName)
                    }
                }
            }
            
            Section {
                Button("Grubu Düzenle") {
                    editedName = group.name
                    editedDescription = group.description
                    editedStartDate = group.startDate
                    editedEndDate = group.endDate
                    showingEditSheet = true
                }
            }
        }
        .navigationTitle("Grup Detayı")
        .sheet(isPresented: $showingEditSheet) {
            NavigationView {
                Form {
                    TextField("Grup Adı", text: $editedName)
                    TextField("Açıklama", text: $editedDescription)
                    DatePicker("Başlangıç Tarihi", selection: $editedStartDate, displayedComponents: [.date])
                    DatePicker("Bitiş Tarihi", selection: $editedEndDate, displayedComponents: [.date])
                }
                .navigationTitle("Grubu Düzenle")
                .navigationBarItems(
                    leading: Button("İptal") {
                        showingEditSheet = false
                    },
                    trailing: Button("Kaydet") {
                        // Demo kaydetme işlemi
                        showingEditSheet = false
                    }
                )
            }
        }
    }
}

// Preview Provider
struct AdminGroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdminGroupDetailView(group: Group(
            id: "1",
            name: "Demo Grup",
            description: "Demo açıklama",
            guideId: "guide1",
            startDate: Date(),
            endDate: Date().addingTimeInterval(7*24*60*60),
            isActive: true,
            participants: ["user1": "Demo Kullanıcı"]
        ))
    }
}
