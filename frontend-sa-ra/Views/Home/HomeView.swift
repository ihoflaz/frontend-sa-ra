import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                // Aktif Turlar
                Section("Aktif Turlar") {
                    ForEach(getActiveTours()) { tour in
                        TourRowView(tour: tour)
                    }
                }
                
                // Yaklaşan Turlar
                Section("Yaklaşan Turlar") {
                    ForEach(getUpcomingTours()) { tour in
                        TourRowView(tour: tour)
                    }
                }
                
                // Hızlı Erişim
                Section("Hızlı Erişim") {
                    NavigationLink(destination: EmergencyContactsView()) {
                        Label("Acil Durum Kişileri", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.red)
                    }
                    
                    NavigationLink(destination: BluetoothSettingsView()) {
                        Label("Bluetooth Ayarları", systemImage: "bluetooth")
                            .foregroundStyle(.blue)
                    }
                    
                    NavigationLink(destination: LocationView()) {
                        Label("Konum Takibi", systemImage: "location")
                            .foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("Ana Sayfa")
        }
    }
    
    // Demo veriler için yardımcı fonksiyonlar
    private func getActiveTours() -> [Tour] {
        return [
            Tour(name: "Roma Turu", guide: "Mehmet Demir", startDate: Date(), endDate: Date().addingTimeInterval(86400 * 3)),
            Tour(name: "Paris Turu", guide: "Ayşe Kaya", startDate: Date(), endDate: Date().addingTimeInterval(86400 * 5))
        ]
    }
    
    private func getUpcomingTours() -> [Tour] {
        return [
            Tour(name: "İstanbul Turu", guide: "Ali Yılmaz", startDate: Date().addingTimeInterval(86400 * 7), endDate: Date().addingTimeInterval(86400 * 10)),
            Tour(name: "Kapadokya Turu", guide: "Zeynep Demir", startDate: Date().addingTimeInterval(86400 * 14), endDate: Date().addingTimeInterval(86400 * 17))
        ]
    }
}

// Tur modeli
struct Tour: Identifiable {
    let id = UUID()
    let name: String
    let guide: String
    let startDate: Date
    let endDate: Date
}

// Tur satır görünümü
struct TourRowView: View {
    let tour: Tour
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(tour.name)
                .font(.headline)
            
            HStack {
                Image(systemName: "person.circle")
                Text("Rehber: \(tour.guide)")
                    .font(.subheadline)
            }
            .foregroundStyle(.gray)
            
            HStack {
                Image(systemName: "calendar")
                Text("\(tour.startDate.formatted(date: .abbreviated, time: .shortened)) - \(tour.endDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
            }
            .foregroundStyle(.gray)
        }
        .padding(.vertical, 4)
    }
}

// Önizleme
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 