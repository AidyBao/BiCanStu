//
//  ZXRouter.m
//  ZXStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRouter.h"
#import "ZXRootViewControllers.h"

@implementation ZXRouter

+ (void)changeRootViewController:(UIViewController *)rootVC{
    UIWindow * window = [ZXRootViewControllers appWindow];
    window.rootViewController = rootVC;
}

+ (void)shouldSelectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [ZXRootViewControllers zx_tabbarController];
    [tabbarvc.delegate tabBarController:tabbarvc shouldSelectViewController:[[tabbarvc viewControllers] objectAtIndex:index]];
}

+ (void)selectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [ZXRootViewControllers zx_tabbarController];
    [tabbarvc setSelectedIndex:index];
}

@end
