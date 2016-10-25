//
//  LAHttp.h
//  LiveApp
//
//  Created by Jose Chen on 16/7/28.
//  Copyright © 2016年 ubnt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@class RequestResultObj;

typedef void (^HttpResponseBlock)(RequestResultObj *resultObj);

@interface LAHttp : NSObject

+ (AFHTTPSessionManager *)manager;
/** get 上传格式普通*/
+ (void)httpsGetWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(HttpResponseBlock)responseBlock;

/** get 上传格式json*/
+ (void)httpsGetWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(HttpResponseBlock)responseBlock;


/** post 上传格式普通*/
+ (void)httpsPostWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(HttpResponseBlock)responseBlock;

/** post 上传格式json*/
+ (void)httpsPostWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(HttpResponseBlock)responseBlock;

/** post 上传格式data*/
+ (void)httpsPostWithURL:(NSString *)url andData:(NSData *)postData andResponseBlock:(HttpResponseBlock)responseBlock;

/** 文件下载*/
+ (void)httpsDownLoadWithUrl:(NSString *)urlString andProgressBlock:(void(^)(float progress))progressBlock andSavePathBlock:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))savePathBlock andFinishBlock:(void(^)())finishBlock;

/** 文件上传*/
+ (void)httpsUploadWithUrl:(NSString *)urlString andParemeter:(NSDictionary *)parmeter andUploadImage:(UIImage *)image andProgressBlock:(void(^)(float progress))progressBlock  andFinishBlock:(void(^)(BOOL isSuccess))finishBlock;

//图片上传
+(void)httpsUploadWithUrl:(NSString *)urlString andParemeter:(NSDictionary *)parmeter andUploadImage:(UIImage *)image andResponseBlock:(HttpResponseBlock)responseBlock;

@end

@interface RequestResultObj : NSObject
//request
@property (strong, nonatomic)   id data;
@property (copy, nonatomic)     NSString * url;
//response
@property (nonatomic,strong)    id jsonObj;
@property (nonatomic,strong)    NSError *error;
@property (nonatomic,strong)    NSURLResponse *response;

- (instancetype)initWithUrl:(NSString *)url
               responseData:(NSData *)data;

@end


