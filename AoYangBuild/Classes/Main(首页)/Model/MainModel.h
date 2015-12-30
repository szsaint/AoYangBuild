//
//  MainModel.h
//  AoYangBuild
//
//  Created by wl on 15/12/30.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <jastor/jastor.h>

@interface MainModel : Jastor

@end

@interface ImageSorce : Jastor
@property (nonatomic,copy)NSString *source;
@end
@interface HeaderModel : Jastor
@property (nonatomic,copy)NSString *title;
@property (nonatomic,retain)ImageSorce *featured_image;
@end