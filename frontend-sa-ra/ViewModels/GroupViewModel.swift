//
//  GroupViewModel.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 31.12.2024.
//

import Foundation

class GroupViewModel: ObservableObject {
    @Published var groups: [Group] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init() {
        loadMockGroups()
    }
    
    private func loadMockGroups() {
        // Demo gruplar
        groups = [
            Group(
                id: "1",
                name: "Roma Turu",
                description: "7 günlük Roma turu",
                guideId: "guide1",
                startDate: Date(),
                endDate: Date().addingTimeInterval(7*24*60*60),
                isActive: true,
                participants: [
                    "5551234567": "Demo Kullanıcı",
                    "5552223344": "Test Kullanıcı"
                ]
            ),
            Group(
                id: "2",
                name: "Paris Turu",
                description: "5 günlük Paris turu",
                guideId: "guide2",
                startDate: Date(),
                endDate: Date().addingTimeInterval(5*24*60*60),
                isActive: true,
                participants: [
                    "5551234567": "Demo Kullanıcı"
                ]
            )
        ]
    }
    
    func createGroup(name: String, description: String, startDate: Date, endDate: Date) {
        isLoading = true
        
        // Demo grup oluşturma simülasyonu
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let newGroup = Group(
                id: UUID().uuidString,
                name: name,
                description: description,
                guideId: "currentGuide",
                startDate: startDate,
                endDate: endDate,
                isActive: true,
                participants: [:]
            )
            
            self?.groups.append(newGroup)
            self?.isLoading = false
        }
    }
    
    func deleteGroup(at indexSet: IndexSet) {
        isLoading = true
        
        // Demo silme simülasyonu
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.groups.remove(atOffsets: indexSet)
            self?.isLoading = false
        }
    }
    
    // Gruba katılım fonksiyonu
    func joinGroup(groupId: String, userId: String, userName: String) {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let index = self?.groups.firstIndex(where: { $0.id == groupId }) {
                self?.groups[index].participants[userId] = userName
            }
            self?.isLoading = false
        }
    }
    
    // Gruptan ayrılma fonksiyonu
    func leaveGroup(groupId: String, userId: String) {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let index = self?.groups.firstIndex(where: { $0.id == groupId }) {
                self?.groups[index].participants.removeValue(forKey: userId)
            }
            self?.isLoading = false
        }
    }
}
