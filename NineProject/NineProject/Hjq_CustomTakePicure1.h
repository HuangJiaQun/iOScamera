//
//  Hjq_CustomTakePicure1.h
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/11.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hjq_CustomTakePicure1 : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *pickerVC;//拍照选取器
@end

NS_ASSUME_NONNULL_END
