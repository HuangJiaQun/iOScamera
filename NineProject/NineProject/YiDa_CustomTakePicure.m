//
//  YiDa_CustomTakePicure.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "YiDa_CustomTakePicure.h"
#import "YiDa_OverLayView.h"
#import "YiDa_NewCoverVC.h"
#import <MobileCoreServices/MobileCoreServices.h>



@interface YiDa_CustomTakePicure ()
@property (nonatomic, strong) YiDa_OverLayView *overLayView;//遮罩层
@property (nonatomic, strong) UIImagePickerController *pickerVC;//拍照选取器
@property (nonatomic, retain) UIImageView *imageView;


@end

@implementation YiDa_CustomTakePicure

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


//- (id)init
//{
//    if (self=[super init]) {
//        //创建顾客对象
//        self.NewCoverVC = [[YiDa_NewCoverVC alloc]init];
//
//        //cooker实现customer的block
//        self.NewCoverVC.myimage=^(UIImage* image){
//            self.imageView.image=image;
//        };
//        //customer开始点
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //用于显示拍照或相册选中的图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-75, self.view.bounds.size.height-160, 150, 150)];
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
    
    //拍照
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(self.view.center.x-100, 100, 200, 40);
    [button addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //返回
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"返回" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    button2.frame = CGRectMake(self.view.center.x-100, 160, 200, 40);
    [button2 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
//    //创建顾客对象
//    self.NewCoverVC = [[YiDa_NewCoverVC alloc]init];
//
//    //cooker实现customer的block
//    self.NewCoverVC.myimage=^(UIImage* image){
//        self.imageView.image=image;
//    };
}





/*
#pragma mark - Navigatio
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 @功能：拍照
 @参数：无
 @返回值：无
 */
- (void)takePhoto
{
    //检测相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"当前设备不支持拍照!");
        return;
    }
    
    self.pickerVC = [[UIImagePickerController alloc] init];
    self.pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;//设置媒体模式为拍照模式
    self.pickerVC.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];//设置媒体类型为静态图像
    self.pickerVC.delegate = self;//设置委托代理
    self.pickerVC.allowsEditing = NO;//不允许编辑,默认是YES
    self.pickerVC.showsCameraControls = NO;//显示或隐藏拍照控件菜单,默认是YES
    
    
    //定义遮罩层
    self.overLayView=[[YiDa_OverLayView alloc]initWithFrame:self.pickerVC.view.bounds withCamera:self.pickerVC];
    //self.overLayView = [[YiDa_OverLayView alloc] initWithFrame:self.pickerVC.view.bounds
                                                   // withCamera:self.pickerVC];
    
    self.pickerVC.cameraOverlayView = self.overLayView;//遮罩层视图
    
    [self presentViewController:self.pickerVC animated:YES completion:^{}];//弹出图像选取器控制器
}

#pragma mark - UIImagePickerControllerDelegate
//拍照或视频录制结束，相册选取结束回调的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)//模式为拍照
    {
        NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];//获取媒体类型
        
        //判断是否为静态图像
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];//获取原始图像
            
            //处理拍取的图片
            YiDa_NewCoverVC*new=[[YiDa_NewCoverVC alloc]initWithOriginImage:originImage layerImage:self.overLayView.imageView.image picker:self.pickerVC];
            [self.pickerVC pushViewController:new animated:YES];
            
        }
             
    }
}
             
@end
