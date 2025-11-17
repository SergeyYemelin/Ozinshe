//
//  Extension UIImageView.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 06.11.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        if #available(iOS 13.0, *) {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        await MainActor.run {
                            self.image = image
                        }
                    }
                } catch {
                    print("Ошибка загрузки изображения:", error)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
