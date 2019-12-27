//
//  YiDa_OverLayView.h
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YiDa_OverLayView : UIView
@property (nonatomic, strong) UIImageView *imageView;//遮罩层图片
@property (nonatomic, assign) UIImagePickerController *camera;//相机
@property (nonatomic, strong) UIButton *flashBtn;//闪光灯
@property (nonatomic, strong) UIButton *frontBtn;//前后置摄像头
@property (nonatomic, strong) UIButton *cameraBtn;//开始拍照
@property (nonatomic, strong) UIButton *cancelBtn;//取消拍照
@property (nonatomic, strong) UIButton *switchBtn;//切换遮罩层

/**
 @功能：初始化遮罩层视图
 @参数：frame 相机对象
 @返回值：self
 */
- (id)initWithFrame:(CGRect)frame withCamera:(UIImagePickerController*)camera;
@end

NS_ASSUME_NONNULL_END
