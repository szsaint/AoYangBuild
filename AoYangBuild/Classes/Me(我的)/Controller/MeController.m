//
//  MeController.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "MeController.h"
#import "SetController.h"
//#import "OrderHistoryController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ChoseImageController.h"

#import "AllCompanyController.h"
#import "CreatCompanyController.h"
#import "WaitAplicationController.h"

#import "AYMeCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "OrderDetailController.h"
#define ORIGINAL_MAX_WIDTH 400

@interface MeController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChoseImageControllerDlegate>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *companyName;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UIImageView *userIcon;

@property (nonatomic,strong)UIBarButtonItem *leftItem;

@end

@implementation MeController{
    NSString *_companyname;
}
-(instancetype)init{
    if (self=[super init]) {
        self.title=@"我的";
        self.tabBarItem.image=[UIImage imageNamed:@"user icon（not Selected）"];
        self.tabBarItem.selectedImage=[UIImage imageNamed:@"user icon（Selected）"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setHeaderView];
    
}
-(void)setUI{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatSuccess) name:@"creatSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetNickname) name:@"resetNickname" object:nil];
    //Notification icon  Set icon
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView=tableView;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=vcColor;
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    self.view=self.tableView;
    
    //nav
    UIButton *setBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"Set icon"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setBtnItem =[[UIBarButtonItem alloc]initWithCustomView:setBtn];
    
    UIButton *message =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [message setBackgroundImage:[UIImage imageNamed:@"Notification icon"] forState:UIControlStateNormal];
    [message addTarget:self action:@selector(messageBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *messageItem =[[UIBarButtonItem alloc]initWithCustomView:message];
    self.leftItem =messageItem;
    

    self.navigationItem.rightBarButtonItem =setBtnItem;
}
-(void)setBtnOnClick:(UIButton *)sender{
    SetController *setVC =[[SetController alloc]init];
    setVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setVC animated:YES];

}
-(void)messageBtnOnClick:(UIButton *)sender{
    WaitAplicationController *waitVC =[[WaitAplicationController alloc]init];
    waitVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:waitVC animated:YES];
}
-(void)setHeaderView{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor=appColor;//56  123  230
    
    UIImageView *user =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80 , 80)];
    user.layer.cornerRadius=user.width/2;
    user.layer.masksToBounds=YES;
    user.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userBtnONClick:)];
    [user addGestureRecognizer:tap];
    user.backgroundColor=[UIColor whiteColor];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths lastObject];
    //设置一个图片的存储路径
//    NSString *imagePath = [path stringByAppendingPathComponent:@"icon.png"];
//    
//    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
//    if (img) {
//        [user setBackgroundImage:img forState:UIControlStateNormal];
//    }else{
//        [user setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//    }
      NSUserDefaults *userD =[NSUserDefaults standardUserDefaults];
//    NSString *avatar = [userD valueForKey:@"avatar"];
//    if (avatar) {
//        [user sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"icon"]];
//    }else{
//        user.image =[UIImage imageNamed:@"icon"];
//    }
    user.image =[UIImage imageNamed:@"icon"];
    
    [view addSubview:user];
    user.center=CGPointMake(view.center.x, view.center.y-20);
    self.userIcon=user;
    self.tableView.tableHeaderView=view;
    
    //用户名
    self.userName=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, SCREEN_WIDTH-40, 25)];
    self.userName.textAlignment=NSTextAlignmentCenter;
    self.userName.font=[UIFont systemFontOfSize:15];
    self.userName.textColor=[UIColor whiteColor];
    NSString *name =[userD valueForKey:@"nickname"];
    if (name) {
        self.userName.text=name;
    }else{
        self.userName.text=@"无名";
    }
    [view addSubview:self.userName];
    
    //名称
    UILabel *companyName =[[UILabel alloc]initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH-40, 25)];
    companyName.textAlignment=NSTextAlignmentCenter;
    companyName.font=[UIFont systemFontOfSize:14];
    companyName.textColor=[UIColor colorWithRed:199/255.0f green:236/255.0f blue:251/255.0f alpha:1];
    NSString *company =[userD objectForKey:@"company"];
    NSString *companyname =[userD objectForKey:@"companyname"];
    if (companyname) {
        companyName.text=companyname;
        _companyname=companyname;
    }else{
    if (company) {
        companyName.text=@"创建公司";
        companyName.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newcompany)];
        [companyName addGestureRecognizer:tap];
    }else{
        companyName.text=@"请选择你所在的公司";
        companyName.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseCompany)];
        [companyName addGestureRecognizer:tap];
    }
    }
    [view addSubview:companyName];
    self.companyName=companyName;
    
    
}
-(void)choseCompany{
    AllCompanyController *searchVC= [[AllCompanyController alloc]init];
    UINavigationController *searNav =[[UINavigationController alloc]initWithRootViewController:searchVC];
    [self presentViewController:searNav animated:YES completion:nil];
//    CreatCompanyController *creatVC =[[CreatCompanyController alloc]init];
//    UINavigationController *creatNav =[[UINavigationController alloc]initWithRootViewController:creatVC];
//    [self presentViewController:creatNav animated:YES completion:nil];
}
-(void)newcompany{
        CreatCompanyController *creatVC =[[CreatCompanyController alloc]init];
        UINavigationController *creatNav =[[UINavigationController alloc]initWithRootViewController:creatVC];
    [self presentViewController:creatNav animated:YES completion:nil];
}
-(void)userBtnONClick:(UIButton *)sender{
    //暂时不支持
//    UIActionSheet *sheet =[[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地相册",@"照相机",nil];
//    [sheet showInView:self.view];
}
#pragma mark  actionSheetdelegate  
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self localPhoto];
    }else if (buttonIndex==1){
        [self crame];
    }
}
-(void)localPhoto{
    UIImagePickerController *pickerVC =[[UIImagePickerController alloc]init];
    pickerVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    NSMutableArray *mediaType =[[NSMutableArray alloc]init];
    [mediaType addObject:(__bridge NSString *)kUTTypeImage];
    pickerVC.delegate=self;//要遵循两个代理
    [self.navigationController presentViewController:pickerVC animated:YES completion:^{
        
    }];
}
-(void)crame{
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isFrontCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                         }];
    }

}
#pragma mark choseVC delegate
-(void)imageCropper:(ChoseImageController *)cropperViewController didFinished:(UIImage *)editedImage{
    self.userIcon.image =editedImage;
    [self saveEditIamge:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)saveEditIamge:(UIImage *)editImage{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path =[paths lastObject];
    
    NSString *iamgePath =[path stringByAppendingPathComponent:@"icon.png"];
    [UIImagePNGRepresentation(editImage) writeToFile:iamgePath atomically:YES];
}
-(void)imageCropperDidCancel:(ChoseImageController *)cropperViewController{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark  ImagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *protraitImg =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@,",NSStringFromCGSize(protraitImg.size));
    protraitImg =[self imageByScalingToMaxSize:protraitImg];
    NSLog(@"%@,",NSStringFromCGSize(protraitImg.size));

    ChoseImageController *chosecVC =[[ChoseImageController alloc]initWithImage:protraitImg cropFrame:CGRectMake(0,(SCREEN_HEIGHT-SCREEN_WIDTH)/2, self.view.width, self.view.width) limitScaleRatio:2.0];
    chosecVC.delegate=self;
    [picker pushViewController:chosecVC animated:YES];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage{
    if (sourceImage.size.width<ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWith =0.0f;
    CGFloat btHeigh =0.0f;
    if (sourceImage.size.width>sourceImage.size.height) {
        btHeigh =ORIGINAL_MAX_WIDTH;
        btWith =sourceImage.size.width*(ORIGINAL_MAX_WIDTH/sourceImage.size.height);
    }else{
        btWith =ORIGINAL_MAX_WIDTH;
        btHeigh=sourceImage.size.height*(ORIGINAL_MAX_WIDTH/sourceImage.size.width);
    }
    CGSize targetSize =CGSizeMake(btWith, btHeigh);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

-(UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize{
    //get target size iamge
    UIImage *newImage =nil;
    CGSize imageSize =sourceImage.size;
    CGFloat width =imageSize.width;
    CGFloat height =imageSize.height;
    CGFloat targetWidth =targetSize.width;
    CGFloat targetHeight =targetSize.height;
    CGFloat scaleFactor =0.0;
    CGFloat scaledWidth =targetWidth;
    CGFloat scaledHeight =targetHeight;
    CGPoint thumbnailPoint =CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize)==NO) {
        CGFloat widthFactor =targetWidth/width;
        CGFloat heghtFactor =targetHeight/height;
        if (widthFactor>heghtFactor)
            scaleFactor=widthFactor;
        else
            scaleFactor =heghtFactor;
        scaledWidth =width*scaleFactor;
        scaledHeight=height*scaleFactor;
        //center the iamge
        if (widthFactor>heghtFactor) {
            thumbnailPoint.y =(targetHeight -scaledHeight)*0.5;
        }else
            if (widthFactor<heghtFactor) {
                thumbnailPoint.x=(targetWidth-scaledWidth)*0.5;
            }

    }
    UIGraphicsBeginImageContext(targetSize);//this will crop
    CGRect thumbbailRect =CGRectZero;
    thumbbailRect.origin=thumbnailPoint;
    thumbbailRect.size.width=scaledWidth;
    thumbbailRect.size.height=scaledHeight;
    [sourceImage drawInRect:thumbbailRect];
    
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    if (newImage==nil) NSLog(@"could not scale iamge");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
    
}
#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"me_cell";
    AYMeCell *cell =[AYMeCell cellWithTableView:tableView identifier:ID];
    if (indexPath.section==0) {
        cell.imageName=@"Account";
        cell.title=@"缴费";
        cell.detailTitle=@"水电费、物业费";
        
    }
    if (indexPath.section==1) {
        cell.imageName=@"Order";
        cell.title=@"预定订单";
        cell.detailTitle=@"会议室、健身房";

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeader=[[UIView alloc]init];
    sectionHeader.backgroundColor=[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    return sectionHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        NSString *company =[[NSUserDefaults standardUserDefaults]valueForKey:@"company"];
        if (!company) {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您无管理员权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        OrderDetailController *detaiVC =[[OrderDetailController alloc]init];
        detaiVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detaiVC animated:YES];
        //订单历史 另开orderdetailVC avoid
//        OrderHistoryController *historyVC =[[OrderHistoryController alloc]init];
//        [self.navigationController pushViewController:historyVC animated:YES];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_companyname&&[[NSUserDefaults standardUserDefaults]objectForKey:@"company"]) {
        self.navigationItem.leftBarButtonItem=self.leftItem;
    }
}
-(void)creatSuccess{
    NSString *companyname = [[NSUserDefaults standardUserDefaults]valueForKey:@"companyname"];
    NSString *company =[[NSUserDefaults standardUserDefaults]valueForKey:@"company"];
    if (companyname) {
        self.companyName.text=companyname;
        self.companyName.userInteractionEnabled=NO;
    }if (company) {
        self.navigationItem.leftBarButtonItem=self.leftItem;
    }

}
-(void)resetNickname{
    NSString *nickname = [[NSUserDefaults standardUserDefaults]valueForKey:@"nickname"];
    self.userName.text =nickname;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
