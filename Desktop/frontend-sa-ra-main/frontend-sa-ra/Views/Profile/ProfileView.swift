//
//  ProfileView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 31.12.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var isEditingProfile = false
    @State private var showingSettings = false
    
    // Kullanıcı bilgileri
    @State private var name = "Ahmet Yılmaz"
    @State private var phone = "+90 555 123 4567"
    @State private var email = "ahmet.yilmaz@email.com"
    
    var body: some View {
        NavigationView {
            List {
                // Profil Bilgileri
                Section("Profil") {
                    NavigationLink(destination: PersonalInfoView()) {
                        HStack {
                            Image(systemName: "person.circle")
                                .foregroundStyle(.blue)
                            Text("Kişisel Bilgiler")
                        }
                    }
                }
                
                // Bluetooth Ayarları
                Section("Bağlantı") {
                    NavigationLink(destination: BluetoothSettingsView()) {
                        HStack {
                            Image(systemName: "bluetooth")
                                .foregroundStyle(.blue)
                            Text("Bluetooth Ayarları")
                        }
                    }
                }
                
                // Bildirimler
                Section("Bildirimler") {
                    NavigationLink(destination: NotificationPreferencesView()) {
                        HStack {
                            Image(systemName: "bell")
                                .foregroundStyle(.blue)
                            Text("Bildirim Ayarları")
                        }
                    }
                }
                
                // Güvenlik
                Section("Güvenlik") {
                    NavigationLink(destination: EmergencyContactsView()) {
                        HStack {
                            Image(systemName: "shield")
                                .foregroundStyle(.blue)
                            Text("Acil Durum Kişileri")
                        }
                    }
                }
                
                // Çıkış Yap
                Section {
                    Button(action: {
                        appViewModel.logout()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(.red)
                            Text("Çıkış Yap")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profil")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isEditingProfile = true
                    }) {
                        Text("Düzenle")
                    }
                }
            }
            .sheet(isPresented: $isEditingProfile) {
                NavigationView {
                    EditProfileView(name: $name, phone: $phone, email: $email, isPresented: $isEditingProfile)
                }
            }
        }
    }
}

struct EditProfileView: View {
    @Binding var name: String
    @Binding var phone: String
    @Binding var email: String
    @Binding var isPresented: Bool
    
    // Geçici değişiklikler için
    @State private var tempName: String = ""
    @State private var tempPhone: String = ""
    @State private var tempEmail: String = ""
    
    var body: some View {
        List {
            Section("Kişisel Bilgiler") {
                TextField("Ad Soyad", text: $tempName)
                TextField("Telefon", text: $tempPhone)
                TextField("E-posta", text: $tempEmail)
            }
        }
        .navigationTitle("Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("İptal") {
                    isPresented = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Kaydet") {
                    name = tempName
                    phone = tempPhone
                    email = tempEmail
                    isPresented = false
                }
            }
        }
        .onAppear {
            tempName = name
            tempPhone = phone
            tempEmail = email
        }
    }
}

struct PersonalInfoView: View {
    @State private var name = "Ahmet Yılmaz"
    @State private var email = "ahmet@example.com"
    @State private var phone = "+90 555 123 45 67"
    
    var body: some View {
        List {
            Section("Kişisel Bilgiler") {
                TextField("Ad Soyad", text: $name)
                TextField("E-posta", text: $email)
                TextField("Telefon", text: $phone)
            }
        }
        .navigationTitle("Kişisel Bilgiler")
    }
}

#Preview {
    ProfileView()
}
