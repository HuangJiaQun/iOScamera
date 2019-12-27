//
//  YiDa_NewCoverVC.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "YiDa_NewCoverVC.h"

@interface YiDa_NewCoverVC ()

@property (nonatomic, strong) UIImage *originImage;//原始图片
@property (nonatomic, strong) UIImage *layerImage;//遮罩层
@property (nonatomic, assign) UIImagePickerController *picer;//图像选择控制器
@property (nonatomic, strong) UIImageView *imageView;//显示拍的图片

@end

@implementation YiDa_NewCoverVC

/**
 @功能：初始化控制器
 @参数：原始图像 遮罩层 图像选择控制器
 @返回值：self
 */
- (id)initWithOriginImage:(UIImage*)originImage layerImage:(UIImage*)layerImage picker:(UIImagePickerController*)picker
{
    if (self=[super init]) {
        self.originImage = originImage;//保存拍的图片
        self.layerImage = layerImage;//保存遮照层
        self.picer = picker;//保存picker
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加拍的图片
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = self.originImage;
    [self.view addSubview:self.imageView];
    
    //添加遮罩层
    UIImageView *layerView = [[UIImageView alloc] initWithFrame:self.imageView.bounds];
    layerView.image = self.layerImage;
    [self.imageView addSubview:layerView];
    
    //如果是前置拍的照，要进行反转处理
    if (self.picer.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        //前置拍的图片
        self.imageView.transform = CGAffineTransformIdentity;
        self.imageView.transform = CGAffineTransformScale(self.picer.cameraViewTransform, -1, 1);//x轴反转
        
        //前置遮罩层
        layerView.transform = CGAffineTransformIdentity;
        layerView.transform = CGAffineTransformScale(self.picer.cameraViewTransform, -1, 1);//x轴反转
    }
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(10, 20, 60, 40);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    
    UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    useBtn.frame = CGRectMake(self.view.bounds.size.width-65, 20, 60, 40);
    [useBtn setTitle:@"使用" forState:UIControlStateNormal];
    [useBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [useBtn addTarget:self action:@selector(useButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:useBtn];
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
 @功能：取消按钮响应
 @参数：无
 @返回值：无
 */
- (void)cancelButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 @功能：使用按钮响应
 @参数：无
 @返回值：无
 */
- (void)useButtonClicked
{
    UIImage *saveImage = [self addImage:self.layerImage toImage:self.imageView.image];//合并图片
    
    //将该图像保存到相机胶卷中
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

/**
 @功能：两张图片合并(顶层图片添加到底层图片上)
 @参数：顶层图片 底层图片
 @返回值：合并后的图片
 */
-(UIImage*)addImage:(UIImage *)topImage toImage:(UIImage *)bottomImage
{
//    UIGraphicsBeginImageContext(self.imageView.bounds.size);//开启图形上下文
//    [bottomImage drawInRect:self.imageView.bounds];//绘制底层图片
//    [topImage drawInRect:self.imageView.bounds];//绘制顶层图片
//    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();//获取合成图片
//    UIGraphicsEndImageContext();//关闭图形上下文
    
    UIGraphicsBeginImageContext(self.imageView.bounds.size);
    [bottomImage drawInRect:self.imageView.bounds];
    [topImage drawInRect:self.imageView.bounds];
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;//返回合成的图片
}

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
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
