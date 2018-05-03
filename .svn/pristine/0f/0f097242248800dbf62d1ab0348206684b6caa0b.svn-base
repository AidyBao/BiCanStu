//
//  ZXRefreshHeader.m
//  YDHYK
//
//  JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXRefreshHeader.h"

@implementation ZXRefreshHeader


#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=55; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bcrefresh%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=55; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bcrefresh%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:2 forState:MJRefreshStateIdle];
    [self setImages:idleImages duration:2 forState:MJRefreshStatePulling];
    [self setImages:refreshingImages duration:2 forState:MJRefreshStateRefreshing];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
