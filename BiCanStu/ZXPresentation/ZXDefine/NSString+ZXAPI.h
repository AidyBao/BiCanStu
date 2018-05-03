//
//  NSString+ZXAPI.h
//  Bican
//
//  Created by screson on 2018/3/2.
//  Copyright © 2018年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZXAPI)

- (NSString *)apiPath;
- (NSString *)filePath;

- (BOOL)zx_isEmpty;

- (NSString *)zx_trimming;

@end
