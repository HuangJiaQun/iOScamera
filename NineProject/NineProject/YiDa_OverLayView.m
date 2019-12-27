//
//  YiDa_OverLayView.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "YiDa_OverLayView.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation YiDa_OverLayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
*/
- (id)initWithFrame:(CGRect)frame withCamera:(UIImagePickerController*)camera
{
    self = [super initWithFrame:frame];
    if (self) {
        self.camera=camera;
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
    }
    return self;
}

/**
 @功能：闪光灯按钮响应事件
 @参数：无
 @返回值：无
 */
- (void)flashBtnClicked
{
    if (self.camera) {
        if (self.camera.cameraDevice ==UIImagePickerControllerCameraDeviceRear) {
            static int num=0;
            num++;
            if (num==3) {
                num=0;
            }
            if (num==0) {
                self.camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;//自动
                [self.flashBtn setTitle:@"闪光灯自动" forState:UIControlStateNormal];
            }
            if (num==1) {
                self.camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
                [self.flashBtn setTitle:@"闪光灯开" forState:UIControlStateNormal];
            }
            if (num==2) {
                self.camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff;
                [self.flashBtn setTitle:@"闪光灯关" forState:UIControlStateNormal];
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
    
    if (self.camera) {
        if (self.camera.cameraDevice==UIImagePickerControllerCameraDeviceRear) {
            self.camera.cameraDevice=UIImagePickerControllerCameraDeviceFront;//前置
        }else{
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
    if (self.camera) {
        [self.camera takePicture];//拍照
    }
}

/**
 @功能：取消拍照
 @参数：无
 @返回值：无
 */
- (void)cancelBtnClicked
{
    if (self.camera) {
        [self.camera dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

/**
 @功能：切换遮罩层
 @参数：无
 @返回值：无
 */
- (void)switchBtnClicked
{
    static BOOL swithchlay=FALSE;
    if (swithchlay) {
        self.imageView.image= [UIImage imageNamed:@"coverFloat"];
        swithchlay=FALSE;
    }else{
        self.imageView.image = [UIImage imageNamed:@"overlay"];
        swithchlay=TRUE;
    }
    
    
}



@end
