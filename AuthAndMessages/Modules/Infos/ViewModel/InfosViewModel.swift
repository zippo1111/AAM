//
//  InfosViewModel.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct InfosViewModel {
    private var model = InfosModel()

    func fetchData() async -> [InfoViewModel]? {
        let json: String? = await model.getJson()

        guard let jsonData = json?.data(using: .utf8) else {
            return nil
        }

        do {
            let response = try JSONDecoder().decode([InfoEntity].self, from: jsonData)
            return response.map {
                let image = $0.image != nil ? "\(Constants.imagesHost)\($0.image!)" : nil
                
                return InfoViewModel(
                    id: $0.id,
                    title: $0.title,
                    text: $0.text,
                    image: image,
                    sort: $0.sort,
                    date: $0.date
                )
            }
        } catch {
            print(error)
            return nil
        }
    }
}

fileprivate extension InfosViewModel {
    enum Constants {
        static let imagesHost = "http://dev-exam.l-tech.ru"
    }
}
