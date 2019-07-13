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
    func modifyImageSize(newSize:CGSize?) -> UIImage? {
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
        
        UIGraphicsBeginImageContext(targetSize)
        draw(in: CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage!
    }
    
    func circleFaviconWithFromQuqrtz2D(borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        
        let imageW: CGFloat = size.width + 22 * borderWidth
        let imageH: CGFloat = size.height + 22 * borderWidth
        let imageSize = CGSize.init(width: imageW, height: imageH)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        borderColor.set()
        let bigRadius: CGFloat = imageW * 0.5
        let centerX = bigRadius
        let centerY = bigRadius
        let center = CGPoint.init(x: centerX, y: centerY)
        let endAngle = CGFloat(Double.pi * 2)
        
        context?.addArc(center: center, radius: bigRadius, startAngle: 0, endAngle: endAngle, clockwise: false)
        context?.fillPath()
        
        let smallRadius = bigRadius - borderWidth
        context?.addArc(center: center, radius: smallRadius, startAngle: 0, endAngle: endAngle, clockwise: false)
        context?.clip()
        
        draw(in: CGRect.init(x: borderWidth, y: borderWidth, width: size.width, height: size.height))
        
        let circleFavicon = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return circleFavicon!
    }
}
extension UIImage{
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?)->()){
        SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
            completion(image)
        }
    }
}
