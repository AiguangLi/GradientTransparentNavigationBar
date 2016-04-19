//
//  UIImage+Part.m
//  GradientTranparentNavigationBar
//
//  Created by kimi on 16/4/19.
//  Copyright © 2016年 mooeen. All rights reserved.
//

#import "UIImage+Part.h"

@implementation UIImage (Part)

-(UIImage *) partImageInRect:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef scale:self.scale orientation:self.imageOrientation];
    
    CGImageRelease(imagePartRef);
    return retImg;
}

@end
