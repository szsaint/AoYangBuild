//
//  UIImage+MJ.h
//  04-图片裁剪
//
//  Created by wl on 15/7/29.
//  Copyright (c) 2015年 kiwi. All rights reserved.
//团片剪裁成圆形团片＊＊＊＊＊＊＊＊

#import <UIKit/UIKit.h>

@interface UIImage (KW)
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
