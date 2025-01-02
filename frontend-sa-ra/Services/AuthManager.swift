import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    // Demo kullanıcılar
    private let mockUsers: [String: User] = [
        "5551234567": User(
            id: "1",
            phoneNumber: "5551234567",
            firstName: "Demo",
            lastName: "Kullanıcı",
            email: "demo@example.com",
            role: .user,
            isVerified: true,
            status: .active,
            createdAt: Date(),
            updatedAt: Date()
        ),
        "5559876543": User(
            id: "2",
            phoneNumber: "5559876543",
            firstName: "Demo",
            lastName: "Admin",
            email: "admin@example.com",
            role: .admin,
            isVerified: true,
            status: .active,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]
    
    // Giriş yapan kullanıcı
    private var currentUser: User?
    
    // Kullanıcı girişi simülasyonu
    func login(phoneNumber: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let user = self?.mockUsers[phoneNumber] {
                self?.currentUser = user
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Geçersiz telefon numarası"])))
            }
        }
    }
    
    // Çıkış yapma
    func signOut() {
        currentUser = nil
    }
    
    // Mevcut kullanıcıyı alma
    var loggedInUser: User? {
        return currentUser
    }
}
