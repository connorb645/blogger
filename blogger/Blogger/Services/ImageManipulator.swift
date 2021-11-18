//
//  ImageCompressor.swift
//  Blogger
//
//  Created by Connor Black on 07/11/2021.
//

import UIKit
import SwiftUI

enum ImageSize {
    case small, medium, large
    
    var size: CGSize {
        switch self {
        case .small:
            return CGSize(width: 80, height: 160)
        case .medium:
            return CGSize(width: 160, height: 320)
        case .large:
            return CGSize(width: 320, height: 640)
        }
    }
}

actor ImageModifier {
    
//    func generateResizedImages(for image: UIImage) -> [UIImage?] {
//        let image1 = image.resized(to: .init(width: 320, height: 640))
//        let image2 = image.resized(to: .init(width: 160, height: 320))
//        let image3 = image.resized(to: .init(width: 80, height: 160))
//        let image4 = image.resized(to: .init(width: 40, height: 80))
//
//        return [image1, image2, image3, image4]
//    }
    
    func thumbnail(for image: UIImage, size: ImageSize) -> UIImage? {
        return image.preparingThumbnail(of: size.size)
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let imageSize = self.size
        let newWidth  = targetSize.width  / self.size.width
        let newHeight = targetSize.height / self.size.height
        var newSize: CGSize

        if(newWidth > newHeight) {
            newSize = CGSize(width: imageSize.width * newHeight, height: imageSize.height * newHeight)
        } else {
            newSize = CGSize(width: imageSize.width * newWidth,  height: imageSize.height * newWidth)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        self.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
