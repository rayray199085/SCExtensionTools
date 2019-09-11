//
//  UIImage+UIImage_SCAddition.m
//  SmallM
//
//  Created by Stephen Cao on 30/8/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "UIImage+SCAddition.h"

@implementation UIImage (UIImage_SCAddition)
- (instancetype)addWatermarkWith: (NSString *)watermarkImageName{
    
    UIGraphicsBeginImageContextWithOptions(self.size, YES, 0.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    UIImage *waterImage = [UIImage imageNamed:watermarkImageName];
    
    CGFloat scale = self.size.width / 3 / waterImage.size.width;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = self.size.width - waterW - margin;
    CGFloat waterY = self.size.height - waterH - margin;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
