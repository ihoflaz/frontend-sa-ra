// 
//  LoginView.swift
//  sa-ra-(saferange)
//
//  Created by Ahsen on 29.12.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var phoneNumber: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sa-RA")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Text("Safe-Range")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 50)
                
                TextField("Telefon Numarası (5551234567 veya 5559876543)", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: {
                    appViewModel.login(phoneNumber: phoneNumber)
                }) {
                    Text("Giriş Yap")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                
                if let error = appViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding()
            .disabled(appViewModel.isLoading)
            .overlay {
                if appViewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
}
