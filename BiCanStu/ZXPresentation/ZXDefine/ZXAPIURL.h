//
//  ZXAPIURL.h
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#ifndef ZXAPIURL_h
#define ZXAPIURL_h

//接口地址及状态定义

#define ZXPAGE_SIZE  10       //单页数据条数

#define ZXAPI_TIMEOUT_INTREVAL   10 //接口超时时间
#define ZXAPI_SUCCESS             0 //接口调用成功
#define ZXAPI_SIGN_FAILED    100001 //签名认证失败
#define ZXAPI_PARAM_ERROR    100002 //参数校验失败
#define ZXAPI_LOGIN_INVALID  100003 //TOKEN 校验失败
#define ZXAPI_ERROR          200005 //业务操作失败
#define ZXAPI_SYSTEM_ERROR   300001 //系统异常

//MARK: -
#define ZXAPI_FORMAT_ERROR   900900           //接口返回数据非json字典
#define ZXFORMAT_ERROR_MSG   @"接口数据格式错误" //接口返回数据非json字典
//MARK: -
#define ZXAPI_HTTP_TIME_OUT  -1001            //请求超时
#define ZXAPI_HTTP_ERROR     900901           //HTTP请求失败
#define ZXAPI_HTTP_ERROR_MSG   @"此时无法访问服务器"    //HTTP请求失败
#define ZXAPI_HTTP_TIMEOUT_MSG @"访问超时,请稍后再试"    //HTTP请求失败

//MARK: -
#define ZXHUD_MBDELAY_TIME 1.0  //HUD显示时间

//正式环境
#define ZX_BASE_URL                   @"http://www.fmbican.com:8080/bican_interface/"
//#define ZX_BASE_URL                   @"http://www.fmbican.com:8089/bican_pc/"    //web端 不签名
//测试环境
//#define ZX_BASE_URL                 @"http://139.199.13.161:8080/bican_interface/"

//MARK: - 资源地址
#define ZXAPI_RESOURCE_URL          @"file/upload"  //资源接口地址

//MARK: - 用户模块
#define ZXAPI_LOGIN_URL             @"user/loginByPwd"

#endif /* ZXAPIURL_h */
