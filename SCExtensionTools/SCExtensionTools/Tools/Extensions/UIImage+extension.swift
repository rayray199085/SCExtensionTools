//
//  UIImage+extension.swift
//  MySinaWeibo
//
//  Created by Stephen Cao on 27/3/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImage{
    
    /// modify an image size
    ///
    /// - Parameters:
    ///   - size: imageView.bounds.size
    ///   - backgroundColor: parent view color, default is white
    /// - Returns: an image with new size
    func modifyImageSize(newSize:CGSize?, cornerRadius: CGFloat = 0) -> UIImage? {
        guard let newSize = newSize else{
            return nil
        }
        let imageSize = size
        let width = imageSize.width
        let height = imageSize.height
        
        let widthFactor = newSize.width/width
        let heightFactor = newSize.height/height
        let scalerFactor = (widthFactor < heightFactor) ? widthFactor : heightFactor
        
        let scaledWidth = width * scalerFactor
        let scaledHeight = height * scalerFactor
        let targetSize = CGSize(width: scaledWidth, height: scaledHeight)
        
        let imageBound = CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight)
        UIGraphicsBeginImageContextWithOptions(targetSize, true, UIScreen.main.scale)
        if cornerRadius > 0{
            let bezierPath = UIBezierPath(roundedRect: imageBound, cornerRadius: 5)
            bezierPath.addClip()
        }
        draw(in: imageBound)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage!
    }
    
}
extension UIImage{
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?)->()){
        SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
            completion(image)
        }
    }
}
extension UIImage {
    
    func circularImage(size: CGSize?) -> UIImage?{
        let newSize = size ?? self.size
        
        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)
        
        context.setBlendMode(.copy)
        context.setFillColor(UIColor.clear.cgColor)
        
        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
