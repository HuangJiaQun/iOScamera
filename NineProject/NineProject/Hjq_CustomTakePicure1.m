//
//  Hjq_CustomTakePicure1.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "Hjq_CustomTakePicure1.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>//调用闪光灯框架
#import <AssetsLibrary/AssetsLibrary.h>


@interface Hjq_CustomTakePicure1 ()
@property (nonatomic,retain)UIImageView*imageView;
@end

@implementation Hjq_CustomTakePicure1

- (void)dealloc {
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureSessionDidStartRunningNotification object:nil];
}

//监听方法
- (void)cameraNotification:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *mediaType = self.pickerVC.mediaTypes;//获取媒体类型
        
        for (NSString *str in mediaType) {
            NSLog(@"%@",str);
        }
        
        NSString *str = mediaType[0];
        
        if ([str isEqualToString:@"public.image"]) {//模式为拍照
            //设置相机视图变换(放大缩小，旋转等)
            //self.pickerVC.cameraViewTransform = CGAffineTransformScale(self.pickerVC.cameraViewTransform, 0.5, 0.5);
            
            //设置闪光灯开(后置摄像头才有效)
            //self.pickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        }
    });
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameraNotification:) name:AVCaptureSessionDidStartRunningNotification object:nil];
    //AVCaptureSessionDidStartRunningNotification==用来监听手机拍照的动作
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 100, self.view.bounds.size.width-50, self.view.bounds.size.height-120)];
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUP:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGesture];
    
    //返回
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"返回" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    button2.frame = CGRectMake(self.view.center.x-100, 50, 200, 40);
    [button2 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)swipeUP:(UISwipeGestureRecognizer*)gesture
{
    
    NSLog(@"当前位置：%@", NSStringFromCGPoint([gesture locationInView:gesture.view]));
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp)
        
    {
        
        NSLog(@"手指向上轻扫了");
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"拍照神器" message:nil preferredStyle:UIAlertControllerStyleActionSheet]; //类型UIAlertControllerStyleAlert表示模态对话框
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"拍照");
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                NSLog(@"当前设备不支持拍照!");
                return;
            }
            
            //创建图像选取器控制器
            self.pickerVC = [[UIImagePickerController alloc] init];
            self.pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;//设置媒体模式为拍照模式
            self.pickerVC.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];//设置媒体类型为静态图像
            self.pickerVC.delegate = self;//设置委托代理
            self.pickerVC.allowsEditing = NO;//允许编辑
            
            self.pickerVC.showsCameraControls = YES;//显示或隐藏拍照控件菜单,默认是YES
            //self.pickerVC.cameraDevice = UIImagePickerControllerCameraDeviceFront;//设置摄像头前置(注意：前置时拍出的图片是左右颠倒的，需要处理)
            
            //iOS10后无效
            //self.pickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;//设置闪光灯开(后置摄像头才有效)
            //self.pickerVC.cameraViewTransform = CGAffineTransformScale(self.pickerVC.cameraViewTransform, 0.5, 0.5);//设置相机视图变换(放大缩小，旋转等)
            [self presentViewController:self.pickerVC animated:YES completion:^{}];//弹出图像选取器控制器
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"视频录制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"视频录制");
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                NSLog(@"当前设备不支持视频录制!");
                return;
            }
            self.pickerVC = [[UIImagePickerController alloc] init];
            self.pickerVC.sourceType=UIImagePickerControllerSourceTypeCamera;//设置媒体模式为拍照模式
            self.pickerVC.mediaTypes=[NSArray arrayWithObject:(NSString*)kUTTypeMovie];//设置媒体类型为视频
            self.pickerVC.videoMaximumDuration=600;//最大录制时间，默认值是10分钟(10*60)
            self.pickerVC.videoQuality=UIImagePickerControllerQualityTypeMedium;
            //设置拍摄质量(高，中，低),默认UIImagePickerControllerQualityTypeMedium
            self.pickerVC.allowsEditing = YES;//允许编辑
            self.pickerVC.delegate = self;//设置委托代理
            [self presentViewController:self.pickerVC animated:YES completion:^{}];//弹出图像选取器控制器
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"相册目录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"相册目录");
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                NSLog(@"当前设备不支持访问相册根目录!");
                return;
            }
            
            self.pickerVC=[[UIImagePickerController alloc]init];
            self.pickerVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//设置媒体模式为相册根目录模式
            self.pickerVC.allowsEditing=YES;
            self.pickerVC.delegate=self;
            
            [self presentViewController:self.pickerVC animated:YES completion:^{
            }];
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }]];
        [self presentViewController:alertVC animated:YES completion:^{ //这里必须是视图控制器模态弹出，视图是不可以的！！
        }];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 @功能：图像保存后的状态回调
 @参数：保存的图像 错误信息 设备上下文
 @返回值：无
 */
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (!error)
    {
        NSLog(@"图像保存成功");
    }
    else
    {
        NSLog(@"图像保存失败:%@", [error localizedDescription]);
    }
}

#pragma mark - UIImagePickerControllerDelegate
//拍照或视频录制结束，相册选取结束回调的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    /*
     // info dictionary keys
     UIKIT_EXTERN UIImagePickerControllerInfoKey const
     外部uikit 图片采摘器控制器信息键 常量 UIImagePickerControllerMediaType __禁止使用电视; 图片采摘控制器媒体类型     // an NSString (UTI, i.e. kUTTypeImage)=静态图像
     
     UIImagePickerControllerOriginalImage __TVOS_PROHIBITED;  // a UIImage  //原始图像
     
     UIImagePickerControllerEditedImage __TVOS_PROHIBITED;    // a UIImage //获取编辑后的图片
     
     UIImagePickerControllerCropRect __TVOS_PROHIBITED;       // an NSValue (CGRect) //裁剪矩形
     
     UIImagePickerControllerMediaURL __TVOS_PROHIBITED;       // an NSURL //媒体URL//视频文件url//kUTTypeMovie
     
     UIImagePickerControllerReferenceURL        NS_DEPRECATED_IOS(4_1, 11_0, "Replace with public API: UIImagePickerControllerPHAsset") __TVOS_PROHIBITED;  // an NSURL that references an asset in the AssetsLibrary framework
     ==//创建ALAssetsLibrary对象并将视频保存到媒体库(注意：需要导入AssetsLibrary.framework)
     
     UIImagePickerControllerMediaMetadata       NS_AVAILABLE_IOS(4_1)//iOS4.1提供 ;  // 包含捕获的照片元数据的nsdictionary//媒体元数据
     
     UIImagePickerControllerLivePhoto NS_AVAILABLE_IOS(9_1) __TVOS_PROHIBITED;  // a PHLivePhoto //现场照片
     
     UIImagePickerControllerPHAsset NS_AVAILABLE_IOS(11_0) __TVOS_PROHIBITED;  // a PHAsset
     
     UIImagePickerControllerImageURL NS_AVAILABLE_IOS(11_0) __TVOS_PROHIBITED;  // an NSURL
     
     */
    
    /*
     UIImagePickerControllerSourceTypePhotoLibrary,/模式为相册库
     UIImagePickerControllerSourceTypeCamera,//模式为拍照
     UIImagePickerControllerSourceTypeSavedPhotosAlbum//模式为相册胶卷
     */
    
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        self.imageView.image=[info objectForKey:UIImagePickerControllerEditedImage];
    }
    else if (picker.sourceType==UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        self.imageView.image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的图片(原始图像用UIImagePickerControllerOriginalImage)
    }
    else if (picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        NSString*mediatype=[info objectForKey:UIImagePickerControllerMediaType];
        
        if ([mediatype isEqualToString:(NSString*)kUTTypeImage])
        {
            UIImage *editedimage=[info objectForKey:UIImagePickerControllerOriginalImage];
            self.imageView.image=editedimage;
            if (picker.cameraDevice==UIImagePickerControllerCameraDeviceFront) {//前置拍的图片
                self.imageView.transform=CGAffineTransformIdentity;//清空
                self.imageView.transform=CGAffineTransformScale(picker.cameraViewTransform, -1, 1);//x轴反转
            }
            UIImageWriteToSavedPhotosAlbum(editedimage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        else if ([mediatype isEqualToString:(NSString *)kUTTypeMovie])
        {
            NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];//获取视频文件url
            
            //创建ALAssetsLibrary对象并将视频保存到媒体库(注意：需要导入AssetsLibrary.framework)
            //OS10 保存照片到相册：用PHPhotoLibrary来代替ALAssetsLibrary
            ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error){
                
                if (!error)
                {
                    NSLog(@"视频保存成功");
                }
                else
                {
                    NSLog(@"视频保存失败：%@", [error localizedDescription]);
                }
            }];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //隐藏图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}
@end
