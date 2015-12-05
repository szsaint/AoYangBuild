//
//  contentFrameModel.h
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContentModel;
@interface contentFrameModel : NSObject

@property (nonatomic,strong)ContentModel *model;


@property (nonatomic,assign)CGRect userIconF;

@property (nonatomic,assign)CGRect userNameF;

//@property (nonatomic,assign)CGRect thumbF;

@property (nonatomic,assign)CGRect contentF;

@property (nonatomic,assign)CGRect timeF;

@property (nonatomic,assign)CGFloat cellH;

@end
