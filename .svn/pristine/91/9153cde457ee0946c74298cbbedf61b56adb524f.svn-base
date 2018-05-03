//
//  NSString+ZXAPI.m
//  Bican
//
//  Created by screson on 2018/3/2.
//  Copyright © 2018年 ZT. All rights reserved.
//

#import "NSString+ZXAPI.h"

@implementation NSString (ZXAPI)

- (NSString *)apiPath {
    NSString * module = self;
    if ([module hasPrefix:@"/"]) {
        module = [module substringFromIndex:1];
    }
    return [NSString stringWithFormat:@"%@api/%@",ZX_BASE_URL,module];
}

- (NSString *)filePath {
    NSString * path = self;
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    return [NSString stringWithFormat:@"%@/%@",ZX_BASE_URL,path];
}

- (BOOL)zx_isEmpty {
    NSString * str = self;
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str.length) {
        return false;
    }
    return true;
}

- (NSString *)zx_trimming {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
