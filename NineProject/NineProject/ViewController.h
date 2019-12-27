//
//  ViewController.h
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/10.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerVC;//图像选取控制器
@property (strong, nonatomic) IBOutlet UIImageView *imageView;//显示一张图片


- (IBAction)takePicture:(id)sender;//拍照
- (IBAction)getPicture:(id)sender;//获取系统相册
- (IBAction)getPictureAlbum:(id)sender;//获取相机胶卷
- (IBAction)takeMovie:(id)sender;//视频录制
- (IBAction)customTakePicture:(id)sender;//自定义拍照界面



@end

