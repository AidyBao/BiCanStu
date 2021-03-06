//
//  ZXHUD.h
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ZX_LOADING_TEXT @"加载中..."
#define ZX_IMAGE_LOADING   @"ZXLoading"
#define ZX_IMAGE_SUCCESS   @"ZXSuccess"
#define ZX_IMAGE_FAILURE   @"ZXFailure"

@interface ZXHUD : NSObject

//MBProgressHUD
/**正确 delay>0 自动移除 否则需要手动移除*/
+ (void)MBShowSuccessInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay;
/**错误 delay>0 自动移除 否则需要手动移除*/
+ (void)MBShowFailureInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay;
/**加载 delay>0 自动移除 否则需要手动移除*/
+ (void)MBShowLoadingInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)MBHideForView:(UIView *)view animate:(BOOL)animate;

@end
