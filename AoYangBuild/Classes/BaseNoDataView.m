//
//  BaseNoDataView.m
//  AoYangBuild
//
//  Created by wl on 15/12/29.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "BaseNoDataView.h"

@implementation BaseNoDataView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-80)/2, 150, 80, 80)];
        img.image =[UIImage imageNamed:@"nodata"];
        [self addSubview:img];
        
        UILabel *lbl =[[UILabel alloc]init];
        lbl.text =@"暂无记录";
        lbl.textColor =[UIColor lightGrayColor];
        lbl.font =[UIFont systemFontOfSize:15];
        CGSize s =[lbl.text sizeWithAttributes:@{NSFontAttributeName:lbl.font}];
//        CGSize s = [lbl.text textSizeWithFont:lbl.font constrainedToSize:CGSizeMake(MAXFLOAT, 999) lineBreakMode:NSLineBreakByCharWrapping];
        lbl.frame = CGRectMake((frame.size.width - s.width ) /2, 240, s.width, s.height);
        [self addSubview:lbl];

        
    }
    return self;
}
@end
