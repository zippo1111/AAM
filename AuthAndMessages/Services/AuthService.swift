//
//  AuthService.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct AuthService {
//    func getPhoneMask(completion: @escaping (String?) -> Void) {
//        Network.shared.getRequest(urlString: Constants.phoneMaskUrl) { result in
//            switch(result) {
//            case .success(let response):
//                guard let phoneMask = response as? String else {
//                    completion(nil)
//                }
//
//                completion(phoneMask)
//            case .failure(_):
//                completion(nil)
//            }
//        }
//    }

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
}

fileprivate extension AuthService {
    enum Constants {
//        static let phoneMaskUrl = "http://dev-exam.l-tech.ru/api/v1/phone_masks"
        static let authPhonePasswordUrl = "http://dev-exam.l-tech.ru/api/v1/auth"
        static let infosDataUrl = "http://dev-exam.l-tech.ru/api/v1/posts"
    }
}
