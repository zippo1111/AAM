//
//  Extension+UIImageView.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import UIKit

extension UIImageView {
    static let noImage = UIImage(systemName: "photo.artframe")

    func loadImage(from fileURL: URL) async {
        guard let data = try? Data(contentsOf: fileURL) else {
            print("Error loading image from file: \(fileURL)")
            self.image = UIImageView.noImage
            return
        }

        guard let image = UIImage(data: data) else {
            print("Error creating UIImage from data: \(data.count) bytes")
            self.image = UIImageView.noImage
            return
        }

        DispatchQueue.main.async {
            self.image = image
        }
    }
}
