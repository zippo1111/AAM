//
//  InfoEntity.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct InfoEntity: Codable {
    let id: String
    let title: String?
    let text: String?
    let image: String?
    let sort: Int?
    let date: String
}
