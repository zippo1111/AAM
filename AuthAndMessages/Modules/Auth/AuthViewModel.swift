//
//  AuthViewModel.swift
//  AuthAndMessages
//
//  Created by Mangust on 17.05.2025.
//

import Foundation

struct AuthViewModel {
    private let authService = AuthService()

    func isAuthSuccessfull(_ phone: String, _ password: String, completion: @escaping (Bool) -> Void) {
        let cleanedPhone = phone.filter { $0.isNumber }
        authService.isAuthSuccessfull(phone: cleanedPhone, password: password, completion: { isSuccess in
            completion(isSuccess)
        })
    }

    func getPhoneMask() async -> String? {
        await authService.getPhoneMask()
    }
}
