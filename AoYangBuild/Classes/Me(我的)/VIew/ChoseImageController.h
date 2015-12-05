//
//  ChoseImageController.h
//  AoYangBuild
//
//  Created by wl on 15/11/11.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChoseImageController;
@protocol ChoseImageControllerDlegate <NSObject>

-(void)imageCropper:(ChoseImageController *)cropperViewController didFinished:(UIImage *)editedImage;
-(void)imageCropperDidCancel:(ChoseImageController *)cropperViewController;

@end
@interface ChoseImageController : UIViewController
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,assign)id<ChoseImageControllerDlegate>delegate;
@property (nonatomic, assign) CGRect cropFrame;

@property (nonatomic,assign)UIImage *icon;
-(id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
