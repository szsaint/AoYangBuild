//
//  WaitAplicatinCell.m
//  AoYangBuild
//
//  Created by wl on 15/11/30.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "WaitAplicatinCell.h"
@interface WaitAplicatinCell ()
@property (nonatomic,strong)UILabel *statelab;
@property (nonatomic,strong)UIButton *acceptBtn;
@end

@implementation WaitAplicatinCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)waitAplicatinCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    WaitAplicatinCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier ];
    if (!cell) {
        cell =[[WaitAplicatinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    CGFloat margin =18;
    UILabel *statelab =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-margin-50, 10, 50, 30)];
    statelab.textColor=[UIColor lightGrayColor];
    statelab.text=@"已通过";
    [self.contentView addSubview:statelab];
    statelab.textAlignment=NSTextAlignmentCenter;
    self.statelab=statelab;
    
    UIButton *acceptBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-margin-50, 10, 50, 30)];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn setBackgroundColor:appColor];
    [acceptBtn addTarget:self action:@selector(acceptBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [acceptBtn setTitle:@"接受" forState:UIControlStateNormal];
    acceptBtn.layer.cornerRadius=3;
    acceptBtn.layer.masksToBounds=YES;
    [self.contentView addSubview:acceptBtn];
    self.acceptBtn=acceptBtn;
    
    
}
-(void)acceptBtnOnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(WaitAplicatinCell:acceptBtnOnClick:)]) {
        [self.delegate WaitAplicatinCell:self acceptBtnOnClick:sender];
    }
}
-(void)setState:(NSInteger)state{
    if (state==0) {
        //
        self.statelab.hidden=YES;
    }else if (state==1){
        self.acceptBtn.hidden=YES;
    }else if (state==-1){
        self.statelab.text=@"已拒绝";
        self.acceptBtn.hidden=YES;
    }
}
@end
