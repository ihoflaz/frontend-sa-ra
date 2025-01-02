//
//  SettingsView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isBluetoothEnabled = true
    @State private var isPushNotificationsEnabled = true
    @State private var isLocationTrackingEnabled = true
    @State private var isEmergencyContactsEnabled = true
    @State private var showPrivacyPolicy = false
    @State private var showEmergencyContacts = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BluetoothSettingsView()) {
                    HStack {
                        Image(systemName: "bluetooth")
                            .foregroundStyle(.blue)
                        Text("Bluetooth Ayarları")
                    }
                }
                
                // Bluetooth Ayarları
                Section("Bluetooth Ayarları") {
                    Toggle("Bluetooth", isOn: $isBluetoothEnabled)
                    
                    if isBluetoothEnabled {
                        HStack {
                            Text("Bluetooth Durumu")
                            Spacer()
                            Text("Bağlı")
                                .foregroundStyle(.green)
                        }
                        
                        NavigationLink("Bağlı Cihazlar") {
                            ConnectedDevicesView()
                        }
                    }
                }
                
                // Bildirim Ayarları
                Section("Bildirim Ayarları") {
                    Toggle("Push Bildirimleri", isOn: $isPushNotificationsEnabled)
                    
                    if isPushNotificationsEnabled {
                        NavigationLink("Bildirim Tercihleri") {
                            NotificationPreferencesView()
                        }
                    }
                }
                
                // Gizlilik Ayarları
                Section("Gizlilik") {
                    Toggle("Konum Takibi", isOn: $isLocationTrackingEnabled)
                    Toggle("Acil Durum Kişileri", isOn: $isEmergencyContactsEnabled)
                    
                    Button("Gizlilik Politikası") {
                        showPrivacyPolicy = true
                    }
                    .foregroundStyle(.blue)
                }
                
                // Acil Durum Ayarları
                Section("Acil Durum") {
                    if isEmergencyContactsEnabled {
                        Button("Acil Durum Kişilerini Düzenle") {
                            showEmergencyContacts = true
                        }
                        .foregroundStyle(.red)
                    }
                }
                
                // Uygulama Bilgileri
                Section("Uygulama Hakkında") {
                    HStack {
                        Text("Versiyon")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .navigationTitle("Ayarlar")
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
        }
        .sheet(isPresented: $showEmergencyContacts) {
            EmergencyContactsView()
        }
    }
}

// Bağlı Cihazlar Görünümü
struct ConnectedDevicesView: View {
    let devices = [
        "iPhone 12 - Ahmet",
        "iPhone 13 - Mehmet",
        "iPhone 14 - Ayşe"
    ]
    
    var body: some View {
        List(devices, id: \.self) { device in
            HStack {
                Text(device)
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
        .navigationTitle("Bağlı Cihazlar")
    }
}

// Bildirim Tercihleri Görünümü
struct NotificationPreferencesView: View {
    @State private var isGroupMessagesEnabled = true
    @State private var isEmergencyAlertsEnabled = true
    @State private var isLocationUpdatesEnabled = true
    
    var body: some View {
        List {
            Toggle("Grup Mesajları", isOn: $isGroupMessagesEnabled)
            Toggle("Acil Durum Uyarıları", isOn: $isEmergencyAlertsEnabled)
            Toggle("Konum Güncellemeleri", isOn: $isLocationUpdatesEnabled)
        }
        .navigationTitle("Bildirim Tercihleri")
    }
}

// Gizlilik Politikası Görünümü
struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Gizlilik Politikası")
                        .font(.title)
                        .bold()
                    
                    Text("1. Veri Toplama")
                        .font(.headline)
                    Text("Uygulamamız, size daha iyi hizmet verebilmek için bazı kişisel verilerinizi toplar...")
                    
                    Text("2. Veri Kullanımı")
                        .font(.headline)
                    Text("Toplanan veriler sadece tur rehberliği hizmetlerinin iyileştirilmesi için kullanılır...")
                    
                    Text("3. Veri Güvenliği")
                        .font(.headline)
                    Text("Verileriniz en üst düzey güvenlik önlemleriyle korunmaktadır...")
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Acil Durum Kişileri Görünümü
struct EmergencyContactsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var contacts = [
        EmergencyContact(name: "Ahmet Yılmaz", phone: "+90 555 123 45 67", relation: "Aile"),
        EmergencyContact(name: "Ayşe Kaya", phone: "+90 555 987 65 43", relation: "Arkadaş")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.headline)
                        Text(contact.phone)
                            .font(.subheadline)
                        Text(contact.relation)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .onDelete(perform: deleteContact)
                
                Button(action: addContact) {
                    Label("Yeni Kişi Ekle", systemImage: "person.badge.plus")
                }
            }
            .navigationTitle("Acil Durum Kişileri")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
    
    private func addContact() {
        // Yeni kişi ekleme işlemi
    }
}

struct EmergencyContact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let relation: String
}

// Önizleme
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct BluetoothSettingsView: View {
    @State private var isBluetoothEnabled = false
    @State private var isDiscoverable = false
    @State private var connectedDevices: [String] = []
    @State private var nearbyDevices: [String] = ["iPhone 12 - Ahmet", "iPhone 13 - Mehmet", "iPhone 14 - Ayşe"]
    @State private var showingDevicesList = false
    
    var body: some View {
        List {
            Section("Bluetooth Durumu") {
                Toggle("Bluetooth", isOn: $isBluetoothEnabled)
                    .onChange(of: isBluetoothEnabled) { newValue in
                        if newValue {
                            // Bluetooth'u aç
                            startBluetooth()
                        } else {
                            // Bluetooth'u kapat
                            stopBluetooth()
                        }
                    }
                
                if isBluetoothEnabled {
                    Toggle("Keşfedilebilir", isOn: $isDiscoverable)
                        .onChange(of: isDiscoverable) { newValue in
                            if newValue {
                                // Cihazı keşfedilebilir yap
                                makeDiscoverable()
                            }
                        }
                    
                    HStack {
                        Text("Durum")
                        Spacer()
                        Text(isBluetoothEnabled ? "Aktif" : "Kapalı")
                            .foregroundStyle(isBluetoothEnabled ? .green : .red)
                    }
                }
            }
            
            if isBluetoothEnabled {
                Section("Bağlı Cihazlar (\(connectedDevices.count))") {
                    if connectedDevices.isEmpty {
                        Text("Bağlı cihaz yok")
                            .foregroundStyle(.gray)
                    } else {
                        ForEach(connectedDevices, id: \.self) { device in
                            HStack {
                                Text(device)
                                Spacer()
                                Button("Bağlantıyı Kes") {
                                    disconnectDevice(device)
                                }
                                .foregroundStyle(.red)
                            }
                        }
                    }
                }
                
                Section("Yakındaki Cihazlar") {
                    Button(action: { showingDevicesList.toggle() }) {
                        HStack {
                            Text("Cihazları Tara")
                            Spacer()
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                    
                    if showingDevicesList {
                        ForEach(nearbyDevices, id: \.self) { device in
                            HStack {
                                Text(device)
                                Spacer()
                                Button("Bağlan") {
                                    connectToDevice(device)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Bluetooth Ayarları")
    }
    
    // MARK: - Yardımcı Fonksiyonlar
    private func startBluetooth() {
        // Bluetooth başlatma işlemleri
        print("Bluetooth başlatılıyor...")
    }
    
    private func stopBluetooth() {
        // Bluetooth kapatma işlemleri
        print("Bluetooth kapatılıyor...")
        connectedDevices.removeAll()
    }
    
    private func makeDiscoverable() {
        // Cihazı keşfedilebilir yapma işlemleri
        print("Cihaz keşfedilebilir yapılıyor...")
    }
    
    private func connectToDevice(_ device: String) {
        // Cihaza bağlanma işlemleri
        print("Cihaza bağlanılıyor: \(device)")
        connectedDevices.append(device)
    }
    
    private func disconnectDevice(_ device: String) {
        // Cihaz bağlantısını kesme işlemleri
        print("Cihaz bağlantısı kesiliyor: \(device)")
        if let index = connectedDevices.firstIndex(of: device) {
            connectedDevices.remove(at: index)
        }
    }
}
