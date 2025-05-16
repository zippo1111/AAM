//
//  AuthService.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct AuthService {
    func getPhoneMask() async -> String? {
        await withCheckedContinuation { continuation in
            Network.shared.getRequest(urlString: Constants.phoneMaskUrl) { result in
                switch(result) {
                case .success(let response):
                    continuation.resume(returning: getPhoneMask(from: response))
                case .failure(_):
                    continuation.resume(returning:(nil))
                }
            }
        }
    }

    func isAuthSuccessfull(phone: String, password: String, completion: @escaping (Bool) -> Void) {
        Network.shared.performRequest(
            urlString: Constants.authPhonePasswordUrl,
            method: "POST",
            parameters: ["phone": phone, "password": password],
            headers: ["Content-Type": "application/x-www-form-urlencoded"]
        ) { result in
            switch(result) {
            case .success(let success):
                completion(success.contains("true"))
            case .failure(_):
                completion(false)
            }
        }
    }

    // Callback => async/await context
    func getInfosAsync() async -> String? {
        await withCheckedContinuation { continuation in
            getInfos { result in
                continuation.resume(returning: result)
            }
        }
    }

    private func getInfos(completion: @escaping (String?) -> Void) {
        Network.shared.getRequest(urlString: Constants.infosDataUrl) { result in
            switch(result) {
            case .success(let json):
                completion(json)
            case .failure(_):
                completion(nil)
            }
        }
    }

    private func getPhoneMask(from jsonString: String) -> String? {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let response = try JSONDecoder().decode(PhoneMaskResponse.self, from: jsonData)
                return response.phoneMask
            } catch {
                return nil
            }
        }

        return nil
    }
}

fileprivate extension AuthService {
    enum Constants {
        static let phoneMaskUrl = "http://dev-exam.l-tech.ru/api/v1/phone_masks"
        static let authPhonePasswordUrl = "http://dev-exam.l-tech.ru/api/v1/auth"
        static let infosDataUrl = "http://dev-exam.l-tech.ru/api/v1/posts"
    }
}
