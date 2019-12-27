//
//  PHPhotoLibrary.m
//  NineProject
//
//  Created by 黄嘉群 on 2019/10/10.
//  Copyright © 2019 黄嘉群. All rights reserved.
//

#import "PHPhotoLibrary.h"
#import <Photos/Photos.h>
@interface PHPhotoLibrary ()

@end

@implementation PHPhotoLibrary

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ios10开始ALAssetsLibrary被标志为弃用(DEPRECATED),并建议使用Photos framework的PHPhotoLibrary
//
//    首先引用Photos framework
//
//#import <Photos/Photos.h>
//
//
//    使用代码：
//
//    方法1：同步存到系统相册
//
//    __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取
//
//        NSError *error =nil;
//
//        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
//
//                createdAssetID = [PHAssetChangeRequest            creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
//
//            } error:&error];
//
//
//
//
//    方法2：存到某个自定义相册
//
//    [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
//
//
//
//                PHAssetChangeRequest *changeAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
//
//
//
//                PHAssetCollection *targetCollection = [[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil]lastObject];
//
//
//
//                PHAssetCollectionChangeRequest *changeCollectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:targetCollection];
//
//
//
//                PHObjectPlaceholder *assetPlaceholder = [changeAssetRequest placeholderForCreatedAsset];
//
//
//
//                [changeCollectionRequest addAssets:@[assetPlaceholder]];
//
//
//
//            } completionHandler:^(BOOL success,NSError * _Nullable error) {
//
//                    NSLog(@"finished adding");
//
//                }];
//
//
//    讲解：
//
//    1.[PHAssetChangeRequest creationRequestForAssetFromImage:image];
//
//    作用是建立一个改变Asset的请求，并将Image或者URL对应的资源放入请求，然后等待处理
//
//
//
//    2. [[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil]lastObject];
//
//    作用是获取一个相册，用于作用图片处理结果后的放置位置。fetchAssetCollectionsWithType使用type定位
//
//    你要保存的相册'类型/位置',这个需要两级的type来定位，第一级分为Album、Smart和Moment三种，
//
//    第二级在第一级的基础上主要分为两种：Album和Smart，Moment是按照时间分类，所以没有二级定位，
//
//    任何二级参数都可以。(具体type含义：Album用户创建的相册分组；Smart：系统创建的分组；Moment：系统生成的时间分组)
//
//    最后options为nil代表使用默认的获取参数(比如时间排序之类，具体按照个人需求)。按照我的例子写的type是只有返回一个‘相册’，
//
//    所以lastobject和下标为firstobject是一样的，但是以Album或者Moment为参数，返回的可能是多个，lastobject取最后一个。
//
//
//
//    3.[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
//
//    作用是建立一个改变Collection的请求
//
//
//
//    4.PHObjectPlaceholder *assetPlaceholder = [changeAssetRequest placeholderForCreatedAsset];
//
//    PHObjectPlaceholder代表一个模型对象的结果,这个结果的提供通过变更请求时创建一个模型对象
//
//
//
//    5.[changeCollectionRequest addAssets:@[assetPlaceholder]];
//
//    最后通过：addAsset来执行最终的结果
//    ————————————————
//    版权声明：本文为CSDN博主「国宝大人」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
//    原文链接：https://blog.csdn.net/u012681458/article/details/52883163
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
