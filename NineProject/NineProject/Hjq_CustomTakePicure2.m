//
//  Hjq_CustomTakePicure2.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "Hjq_CustomTakePicure2.h"
#import "Hjq_OverLayView.h"
#import "Hjq_NewCoverVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface Hjq_CustomTakePicure2 ()

@property(nonatomic,strong)Hjq_OverLayView*layview;//遮罩层
@property (nonatomic,strong)UIImagePickerController *picker;
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation Hjq_CustomTakePicure2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
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
    
}


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
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"当前设备不支持拍照!");
        return;
    }
    
    self.picker=[[UIImagePickerController alloc]init];
    self.picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    self.picker.mediaTypes=[NSArray arrayWithObject:(NSString*)kUTTypeImage];
    self.picker.delegate=self;
    self.picker.allowsEditing=NO;
    self.picker.showsCameraControls=NO;
    
    self.layview=[[Hjq_OverLayView alloc]initWithFrame:self.picker.view.bounds withCamera:self.picker];
    
    self.picker.cameraOverlayView=self.layview;//遮罩层视图
    [self presentViewController:self.picker animated:YES completion:^{}];//弹出图像选取器控制器
    
    
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            Hjq_NewCoverVC*new=[[Hjq_NewCoverVC alloc]initWithOriginImage:originImage layerImage:self.layview.imageView.image picker:self.picker];
            [self.picker pushViewController:new animated:YES];
            
        }
        
    }else if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
            
        self.imageView.image=[info objectForKey:UIImagePickerControllerEditedImage];
        //处理拍取的图片
        Hjq_NewCoverVC*new=[[Hjq_NewCoverVC alloc]initWithOriginImage:self.imageView.image layerImage:self.layview.imageView.image picker:self.picker];
        [self.picker pushViewController:new animated:YES];
            
    }
}


@end
