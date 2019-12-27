//
//  Hjq_NewCoverVC.h
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hjq_NewCoverVC : UIViewController
@property (nonatomic, strong) UIImage *saveImage;
/**
 @功能：初始化控制器
 @参数：原始图像 遮罩层 图像选择控制器
 @返回值：self
 */
- (id)initWithOriginImage:(UIImage*)originImage layerImage:(UIImage*)layerImage picker:(UIImagePickerController*)picker;
@end

NS_ASSUME_NONNULL_END
