//
//  InfosModel.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct InfosModel {
    private let jsonService = JsonService()
    private let authService = AuthService()

    func getJson() async -> String? {
//        await jsonService.get(from:  Constants.jsonUrl)
        await authService.getInfosAsync()
    }
}

fileprivate extension InfosModel {
    enum Constants {
        static let jsonUrl = ""
    }
}
