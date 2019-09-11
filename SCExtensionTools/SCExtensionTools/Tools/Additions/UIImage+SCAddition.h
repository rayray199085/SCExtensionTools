//
//  UIImage+UIImage_SCAddition.h
//  SmallM
//
//  Created by Stephen Cao on 30/8/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (UIImage_SCAddition)
- (instancetype)addWatermarkWith: (NSString *)watermarkImageName;
@end

NS_ASSUME_NONNULL_END
