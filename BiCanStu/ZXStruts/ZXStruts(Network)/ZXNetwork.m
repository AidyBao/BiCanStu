//
//  ZXNetworkEngine.m
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXNetwork.h"
#import "ZXAPIURL.h"
#import "ZXNotificationCenter.h"
#import "ZXAPISign.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ZXDefine.h"

#define ZX_SHOW_LOG 1

@implementation ZXNetwork

+ (void)commonProcess:(id)content zxCompletion:(ZXRequestCompletion)zxCompletion{
    if (ZX_SHOW_LOG) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
        NSLog(@"接口返回数据:\n%@",str);
        NSLog(@"------------结束------------");
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSInteger status = [content[@"status"] integerValue];
        
        if (status == ZXAPI_LOGIN_INVALID) {
            [ZXNotificationCenter postNotificationName:ZXNOTICE_LOGIN_OFFLINE object:nil];
            if (zxCompletion) {
                zxCompletion(content,ZXAPI_LOGIN_INVALID,true,content[@"msg"]);
            }
        }else if (zxCompletion) {
            if (status == ZXAPI_SUCCESS) {
                zxCompletion(content,status,true,nil);
            }else{
                zxCompletion(content,status,true,content[@"msg"]);
            }
        }
    }else{
        if (zxCompletion) {
            zxCompletion(content,ZXAPI_FORMAT_ERROR,false,ZXFORMAT_ERROR_MSG);
        }
    }
}

+ (void)httpError:(NSError *)error zxCompletion:(ZXRequestCompletion)zxCompletion{
    if (ZX_SHOW_LOG) {
        NSLog(@"接口错误返回数据:\n%@",error);
        NSLog(@"------------结束------------");
    }
    if (zxCompletion) {
        if (error.code == ZXAPI_HTTP_TIME_OUT) {
            zxCompletion(error,ZXAPI_HTTP_TIME_OUT,false,ZXAPI_HTTP_TIMEOUT_MSG);
        }else{
            zxCompletion(error,ZXAPI_HTTP_ERROR,false,ZXAPI_HTTP_ERROR_MSG);
        }
    }
}

+ (NSURLSessionDataTask *)asyncRequestWithURL:(NSString *)url
                     params:(NSDictionary *)params
                      token:(NSString *)token
                     method:(ZXRequestMethod)method zxCompletion:(ZXRequestCompletion)zxCompletion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    [dicP setObject:@([ZXDateUtils currentMillSeconds]) forKey:@"timestamp"];
    if ([token isKindOfClass:[NSString class]] && token.length) {
        [dicP setObject:[ZXAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = ZXAPI_TIMEOUT_INTREVAL;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    NSURLSessionDataTask * task = nil;
    
    if (ZX_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:\n%@",url);
        NSLog(@"请求参数:\n%@",dicP);
    }
    
    switch (method) {
        case GET:
        {
            task = [manager GET:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        case POST:
        {
            task = [manager POST:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        case DELETE:
        {
            task = [manager DELETE:url parameters:dicP success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        default:
            break;
    }
    return task;
}

+ (NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL
                          images:(NSArray<NSData *> *)images
                           token:(NSString *)token
                          params:(NSDictionary *)params
                    zxCompletion:(ZXRequestCompletion)zxCompletion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    if ([token isKindOfClass:[NSString class]] && token.length) {
        [dicP setObject:[ZXAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    [dicP setObject:@([ZXDateUtils currentMillSeconds]) forKey:@"timestamp"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    if (ZX_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:%@",resourceURL);
//        NSLog(@"请求参数:\n%@",dicP);
    }
    NSURLSessionDataTask * task = [manager POST:resourceURL parameters:dicP constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSInteger count = [images count];
        for (NSInteger idx = 0; idx < count; idx ++) {
            NSData *  imgData = images[idx];
            NSString * fileName = [NSString stringWithFormat:@"Image%ld.jpg", idx + 1];
            
            [formData appendPartWithFileData:imgData
                                        name:[NSString stringWithFormat:@"fileList%ld.jpg", idx + 1]
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        [self commonProcess:responseObject zxCompletion:zxCompletion];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        [self httpError:error zxCompletion:zxCompletion];
    }];
    return task;
}


@end
