//
//  ZXRouter+RemoteNotice.m
//  ZXStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRouter+RemoteNotice.h"

static NSDictionary * lastNoticeInfo = nil;

@implementation ApsModel


@end

@implementation ZXRemoteNoticeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"aps":[ApsModel class]};
}

- (ZXRemoteNoticeType)type{
    if ([_pushType isKindOfClass:[NSString class]] && _pushType.length) {
        if ([_pushType isEqualToString:@"order"]) {
            return ZXRemoteNoticeTypeOrderUpdate;
        }
        if ([_pushType isEqualToString:@"notice"]) {
            return ZXRemoteNoticeTypeNewNotice;
        }
    }
    return ZXRemoteNoticeTypeTakeUnknown;
}

@end

@implementation ZXRouter (RemoteNotice)

+ (void)showNoticeDetail:(NSDictionary *)userInfo{
    /*
    if ([userInfo isKindOfClass:[NSDictionary class]] && userInfo.count) {
        ZXRemoteNoticeModel * noticeModel = [ZXRemoteNoticeModel mj_objectWithKeyValues:userInfo];
        //if ([[ZXRootViewControllers zx_tabbarController].view window]) {
        UIViewController * rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
        if (rootVC == [ZXRootViewControllers zx_tabbarController]) {
            UIViewController * selectedVC = [[ZXRootViewControllers zx_tabbarController] selectedViewController];
            UINavigationController * nav = nil;
            if ([[ZXRootViewControllers zx_tabbarController] presentedViewController]) {//判断时候present了某个vc
                selectedVC = [[ZXRootViewControllers zx_tabbarController] presentedViewController];
            }
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)selectedVC;
                selectedVC = [[(UINavigationController *)selectedVC viewControllers] firstObject];
            }else{
                nav = selectedVC.navigationController;
            }
            
            if ([selectedVC isKindOfClass:[GJLoginRootViewController class]] ||
                [selectedVC isKindOfClass:[GJLoginNavigationController class]] ||
                [selectedVC isKindOfClass:[GJGetVerCodeViewController class]] ||
                [selectedVC isKindOfClass:[GJLaunchViewController class]]) {
                lastNoticeInfo = userInfo;
                return;
            }
            if (![nav isKindOfClass:[UINavigationController class]]) {
                lastNoticeInfo = userInfo;
                return;
            }
            lastNoticeInfo = nil;
            if (noticeModel.type == ZXRemoteNoticeTypeTakeUnknown) {
                [ZXAudioUtils vibrate];
                [ZXAlertUtils showAAlertWithTitle:@"新消息" message:noticeModel.aps.alert];
            }else{
                [ZXAudioUtils vibrate];
                [ZXAlertUtils showAAlertWithTitle:@"新消息" message:noticeModel.aps.alert buttonTexts:@[@"忽略",@"马上查看"] buttonAction:^(int buttonIndex) {
                    if (buttonIndex == 1) {
                        switch (noticeModel.type) {
                            case ZXRemoteNoticeTypeNewNotice:
                            {
                                if (![noticeModel.drugstoreId isEqualToString:[[ZXGlobalData shareInstance] storeId]]) {
                                    [ZXAlertUtils showAAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"该公告属于[%@],请在个人中心切换药店后查看",noticeModel.drugstoreName] buttonText:@"好的" buttonAction:nil];
                                }else{
                                    GJMessageDetailViewController *detailVC = [[GJMessageDetailViewController alloc]init];
                                    detailVC.hidesBottomBarWhenPushed = YES;
                                    detailVC.noticeId = noticeModel.pushId;
                                    [nav pushViewController:detailVC animated:true];
                                }
                            }
                                break;
                            case ZXRemoteNoticeTypeOrderUpdate:
                            {
                                if (![noticeModel.drugstoreId isEqualToString:[[ZXGlobalData shareInstance] storeId]]) {
                                    [ZXAlertUtils showAAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"该订单属于[%@],请在个人中心切换药店后查看",noticeModel.drugstoreName] buttonText:@"好的" buttonAction:nil];
                                }else{
                                    HOrderDetailViewController * orderDetailVC = [[HOrderDetailViewController alloc] init];
                                    orderDetailVC.orderId = noticeModel.pushId;
                                    [nav pushViewController:orderDetailVC animated:true];
                                }
                                
                            }
                                break;
                            default:
                                break;
                        }
                    }
                }];
            }
        }else{
            lastNoticeInfo = userInfo;
        }
    }else{
        lastNoticeInfo = nil;
    }
     */
}

+ (void)checkNoticeCache{
    [self showNoticeDetail:lastNoticeInfo];
}

@end
