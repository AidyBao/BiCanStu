//
//  ZXMessageRootViewController.m
//  BiCanStu
//
//  Created by screson on 2018/4/26.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ZXMessageRootViewController.h"

@interface ZXMessageRootViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblList;

@end

@implementation ZXMessageRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tblList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(zx_refresh)];
}

- (void)zx_refresh {
    NSLog(@"refreshing...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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