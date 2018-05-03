//
//  ZXRootViewControllers.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRootViewControllers.h"
#import "UITabBarController+ZX.h"
#import "UIColor+ZXColor.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation ZXRootViewControllers

static UITabBarController * zx_tarbarvc = nil;

+ (void)reload{
    zx_tarbarvc = nil;
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate) {
        [self zx_tabbarController].delegate = delegate;
    }
    [ZXRootViewControllers loadfromPlistWithControllerClassNames:@[@"ZXDiscoverRootViewController",@"ZXTaskRootViewController",@"ZXWriteRootViewController",@"ZXMessageRootViewController",@"ZXPersonalRootViewController"]];
    [[ZXRootViewControllers zx_tabbarController] setSelectedIndex:0];
    [self appWindow].rootViewController = zx_tarbarvc;
}

+ (UITabBarController *)zx_tabbarController{
    if (!zx_tarbarvc) {
        zx_tarbarvc = [[UITabBarController alloc] init];
        
        [zx_tarbarvc.tabBar.layer setShadowColor:UIColor.blackColor.CGColor];
        [zx_tarbarvc.tabBar.layer setShadowRadius:2];
        [zx_tarbarvc.tabBar.layer setShadowOffset:CGSizeMake(0, -2)];
        [zx_tarbarvc.tabBar.layer setShadowOpacity:0.1];
    }
    return zx_tarbarvc;
}

+ (void)loadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames{
    if (classNames && classNames.count) {
        [classNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //Plist 中已设置嵌入NavigationController
            Class class = NSClassFromString(obj);
            [[self zx_tabbarController] zx_addChildViewController:[[class alloc] init] atPlistIndex:idx];
        }];
    }else{
        [[self zx_tabbarController] setViewControllers:nil];
    }
}

+ (void)reloadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames{
    zx_tarbarvc = nil;
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate) {
        [self loadfromPlistWithControllerClassNames:classNames];
        [self zx_tabbarController].delegate = delegate;
    }
}

+ (UIViewController *)keyController{
    UIViewController * keyController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    do{
        if (keyController.presentedViewController) {
            keyController = keyController.presentedViewController;
        }else{
            break;
        }
    }while(keyController.presentedViewController);
    return keyController;
}

+ (UIWindow *)appWindow{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow * window = delegate.window;
    return window;
    //return [[UIApplication sharedApplication] keyWindow];
}

@end
