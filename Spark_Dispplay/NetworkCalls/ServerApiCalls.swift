//
//  ServerApiCalls.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image.scaleImage(toSize: CGSize.init(width: 35, height: 22))
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

