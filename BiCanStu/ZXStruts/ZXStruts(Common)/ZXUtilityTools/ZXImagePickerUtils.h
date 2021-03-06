//
//  ZXImagePickerUtils.h
//  ZXImagePickerUtils
//
//  JuanFelix on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZXPSuccess,         /**成功获取*/
    ZXPCanceled,        /**用户取消*/
    ZXPCameraDisable,   /**相机不可用*/
    ZXPPhotoLibDisable, /**相册库不可用*/
    ZXPNotImage         /**非图片文件*/
} ZXTakePhotoStatus;

typedef enum : NSUInteger {
    ZXPTakePhoto,       /**拍照*/
    ZXPChoosePhoto      /**从相册取*/
} ZXTakePhotoType;

typedef void(^ZXTakeEndAction)(UIImage * image,ZXTakePhotoStatus status,NSString * errorMsg);

//iOS 10 plist注意配置：
//Privacy - Photo Library Usage Description
//Privacy - Camera Usage Description
@interface ZXImagePickerUtils : NSObject

/**拍照*/
- (void)takePhotoUponVC:(UIViewController *)vc
               callBack:(ZXTakeEndAction)callBack;
/**从相册取*/
- (void)choosePhotoUponVC:(UIViewController *)vc
                 callBack:(ZXTakeEndAction)callBack;

/**用户是否授权 如果未授权是否跳转到设置界面(iOS8之后)*/
+ (BOOL)isAuthorized_jumpToSettingifNo:(BOOL)jump;
/**相机功能是否可用*/
+ (BOOL)isCameraAvailable;
/**前置摄像头是否可用*/
+ (BOOL)isFrontCameraAvailable;
/**后置摄像头是否可用*/
+ (BOOL)isRearCameraAvailable;
/**判断是否支持某种多媒体类型：拍照，视频*/
+ (BOOL)cameraSupportsMedia:(NSString *)mediaType
                 sourceType:(UIImagePickerControllerSourceType)sourceType;
/**检查摄像头是否支持录像*/
+ (BOOL)doesCameraSupportShootingVideos;
/**检查摄像头是否支持拍照*/
+ (BOOL)doesCameraSupportTakingPhotos;
/**相册是否可用*/
+ (BOOL)isPhotoLibraryAvailable;
/**是否可在相册中选择视频*/
+ (BOOL)canUsePickVideosFromPhotoLibrary;
/**是否可在相册中选择图片*/
+ (BOOL)canUserPickPhotosFromPhotoLibrary;

@end
