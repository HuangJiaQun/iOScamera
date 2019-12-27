//
//  Hjq_OverLayView.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "Hjq_OverLayView.h"

#import <MobileCoreServices/MobileCoreServices.h>
@implementation Hjq_OverLayView

/**
@功能：初始化遮罩层视图
@参数：frame 相机对象
@返回值：self
*/
- (id)initWithFrame:(CGRect)frame withCamera:(UIImagePickerController*)camera
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.camera = camera;//保存拍照对象
        
        //遮罩层
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.image = [UIImage imageNamed:@"coverFloat"];
        [self addSubview:self.imageView];
        
        //闪光灯
        self.flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.flashBtn.frame = CGRectMake(10, 20, 100, 40);
        [self.flashBtn setTitle:@"闪光灯auto" forState:UIControlStateNormal];
        [self.flashBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.flashBtn addTarget:self action:@selector(flashBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.flashBtn];
        
        //前后置摄像头按钮
        self.frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.frontBtn.frame = CGRectMake(self.bounds.size.width-70, 20, 60, 35);
        [self.frontBtn setBackgroundImage:[UIImage imageNamed:@"自拍切换"] forState:UIControlStateNormal];
        [self.frontBtn addTarget:self action:@selector(frontBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.frontBtn];
        
        //开始拍照按钮
        self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cameraBtn.frame = CGRectMake(self.center.x-14, self.bounds.size.height-38, 28, 28);
        [self.cameraBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.cameraBtn addTarget:self action:@selector(cameraBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cameraBtn];
        
        //取消按钮
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.frame = CGRectMake(5, self.bounds.size.height-50, 60, 40);
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelBtn];
        
        //切换遮罩层
        self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.switchBtn.frame = CGRectMake(self.bounds.size.width-105, self.bounds.size.height-50, 100, 40);
        [self.switchBtn setTitle:@"切换遮罩层" forState:UIControlStateNormal];
        [self.switchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.switchBtn addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.switchBtn];
        
        
        //相册获取
        self.Album = [UIButton buttonWithType:UIButtonTypeCustom];
        self.Album.frame = CGRectMake(self.bounds.size.width-105, self.bounds.size.height-100, 100, 40);
        [self.Album setTitle:@"相册" forState:UIControlStateNormal];
        [self.Album setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.Album addTarget:self action:@selector(AlbumClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.Album];
    }
    return self;
}

/**
 @功能：打开相册
 @参数：无
 @返回值：无
 */
- (void)AlbumClicked{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"当前设备不支持访问相册根目录!");
        return;
    }
    
    
    self.camera.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//设置媒体模式为相册根目录模式
    self.camera.allowsEditing=YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





/**
 @功能：闪光灯按钮响应事件
 @参数：无
 @返回值：无
 */
- (void)flashBtnClicked
{
    if (self.camera)
    {
        if (self.camera.cameraDevice == UIImagePickerControllerCameraDeviceRear)
        {
            static int num = 0;
            num++;
            if (num == 3)
            {
                num = 0;
            }
            
            if (num == 0)
            {
                self.camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
                [self.flashBtn setTitle:@"闪光灯auto" forState:UIControlStateNormal];
            }
            
            if (num == 1)
            {
                self.camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
                [self.flashBtn setTitle:@"闪光灯on" forState:UIControlStateNormal];
            }
            
            if (num == 2)
            {
                self.camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
                [self.flashBtn setTitle:@"闪光灯off" forState:UIControlStateNormal];
            }
        }
    }
}

/**
 @功能：前置，后置摄像头按钮响应事件
 @参数：无
 @返回值：无
 */
- (void)frontBtnClicked
{
    if (self.camera)
    {
        if (self.camera.cameraDevice == UIImagePickerControllerCameraDeviceRear)
        {
            self.camera.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        else
        {
            self.camera.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
    }
}

/**
 @功能：开始拍照或视频录制
 @参数：无
 @返回值：无
 */
- (void)cameraBtnClicked
{
    if (self.camera)
    {
        [self.camera takePicture];
    }
}

/**
 @功能：取消拍照
 @参数：无
 @返回值：无
 */
- (void)cancelBtnClicked
{
    if (self.camera)
    {
        [self.camera dismissViewControllerAnimated:YES completion:^{}];
    }
}

/**
 @功能：切换遮罩层
 @参数：无
 @返回值：无
 */
- (void)switchBtnClicked
{
    static BOOL switchLay = FALSE;
    if (switchLay)
    {
        self.imageView.image = [UIImage imageNamed:@"coverFloat"];
        switchLay = FALSE;
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"overlay"];
        switchLay = TRUE;
    }
}



@end
