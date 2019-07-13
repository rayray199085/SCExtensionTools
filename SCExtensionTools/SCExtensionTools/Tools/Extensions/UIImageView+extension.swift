//
//  UIImageView+extension.swift
//  MySinaWeibo
//
//  Created by Stephen Cao on 28/3/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import SDWebImage
extension UIImageView{

    /// isolate sdwebimage
    ///
    /// - Parameters:
    ///   - urlString: image url string
    ///   - placeholderImage: placeholder
    ///   - isAvatar: ture if this image is used for avatar
    func setImage(urlString: String?,placeholderImage: UIImage?, isAvatar:Bool = false){
        guard let imageUrlString = urlString,
            let url = URL(string: imageUrlString) else {
                image = placeholderImage
                return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: { (receivedSize, expectedSize, targetURL) in//NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
            
        }) { [weak self] (image, error, cacheType, imageURL) in//UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL
            if isAvatar{
                guard let height = self?.bounds.height else{
                    return
                }
                self?.cornerRadius(radius: height / 2)
            }else{
                self?.image = image?.modifyImageSize(newSize: self?.bounds.size)
            }
        }
    }
    func cornerRadius(radius:CGFloat){
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.addEllipse(in: bounds)
        ctx!.clip()
        image!.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        image = newImage
    }
}
