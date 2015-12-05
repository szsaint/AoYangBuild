//
//  AYArticleFrameModel.h
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AYAticleModel.h"

@interface AYArticleFrameModel : NSObject

@property(nonatomic,strong)AYAticleModel *model;//文章数据模型



/*
 自定义单元view的frame
 */
@property (nonatomic,assign,readonly) CGRect articleF;
/*
 *  标题的frame
 */
@property (nonatomic,assign,readonly) CGRect titleF;

/*
 * 企业名称的frame
 */
@property (nonatomic,assign,readonly) CGRect businessF;
/**
 图片的frame
 */
@property (nonatomic,assign,readonly) CGRect hotimageF;

/**
 回复数的frame
 **/
@property (nonatomic,assign,readonly) CGRect timeF;

/*
 回复图片的frame
 */
@property (nonatomic,assign,readonly) CGRect commentImageF;
/*
 回复数量的frame
 */
@property (nonatomic,assign,readonly) CGRect commentCountF;

/*
 *  第一张照片的frame(如果有的话)
 */
@property (nonatomic,assign,readonly) CGRect firstImageF;
/*
 *  第二张照片的frame(如果有的话)
 */
@property (nonatomic,assign,readonly) CGRect secondImageF;
/*
 *  第三张照片的frame(如果有的话)
 */
@property (nonatomic,assign,readonly) CGRect thirdImageF;

/*
 *   单元格的高度
 */

@property (nonatomic,assign,readonly) CGFloat cellH;




//下划线的高度 看着办就可
@property (nonatomic,assign,readonly) CGRect lineF;

@end
