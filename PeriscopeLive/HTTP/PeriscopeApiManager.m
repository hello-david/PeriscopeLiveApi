//
//  PeriscopeApiManager.m
//  PeriscopeLive
//
//  Created by David.Dai on 2016/10/24.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import "PeriscopeApiManager.h"
#import "PeriscopeApi.h"

@interface PeriscopeApiManager()
@property (nonatomic,strong) NSDictionary   *loginResponseDic;
@property (nonatomic,strong) NSDictionary   *createResponseDic;
@property (nonatomic,strong) NSString       *cookie;
@property (nonatomic,strong) NSString       *sessionToken;
@property (nonatomic,strong) NSString       *sessionSecret;
@property (nonatomic,strong) NSString       *serverRegion;
@property (nonatomic,strong) NSDictionary   *broadcastInfo;

@end

@implementation PeriscopeApiManager

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken = 0;
    __strong static id shareObj = nil;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
    });
    return shareObj;
}

- (void)loginWithTwitter:(TWTRSession *)session
{
    if(!session)return;
    NSDictionary *dic = @{
                          kPeriscopeParaLoginSession        : session.authToken,
                          kPeriscopeParaLoginSessionSecret  : session.authTokenSecret,
                          kPeriscopeParaLoginUserId         : session.userID,
                          kPeriscopeParaLoginUserName       : session.userName,
                          };
    [LAHttp httpsPostWithURL:[PeriscopeApi loginWithTwitterUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
    {
        if(resultObj.jsonObj)
        {
            self.loginResponseDic  = (NSDictionary *)resultObj.jsonObj;
            self.sessionToken      = session.authToken;
            self.sessionSecret     = session.authTokenSecret;
            self.cookie            = [self.loginResponseDic objectForKey:kPeriscopeParaCookie];
            [self createBroadcast];
            [self getUserProfileSettings];
        }
    }];
}

//rtmps://host:port/application?t=credential/streamname
- (void)createBroadcast
{
    if(!self.cookie)return;
    NSDictionary *dic = @{
                          kPeriscopeParaBroadcastHeight : @(480),
                          kPeriscopeParaBroadcastWidth  : @(720),
                          kPeriscopeParaBroadcastRegion : @"ap-northeast-1",
                          kPeriscopeParaCookie          : self.cookie,
                          };
    
    [LAHttp httpsPostWithURL:[PeriscopeApi createBroadcastUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
     {
         self.createResponseDic   = (NSDictionary *)resultObj.jsonObj;
         self.broadcastInfo       = [self.createResponseDic objectForKey:kPeriscopeParaBroadcast];
         self.rtmpsAddr = [NSString stringWithFormat:@"rtmps://%@:%@/%@?t=%@/%@",
                           [self.broadcastInfo objectForKey:@"Host"],
                           [self.createResponseDic objectForKey:@"port"],
                           [self.createResponseDic objectForKey:@"application"],
                           [self.createResponseDic objectForKey:@"credential"],
                           [self.createResponseDic objectForKey:@"stream_name"]];
         NSLog(@"%@",self.rtmpsAddr);
     }];
}

- (void)publishBroadcastWithTitle:(NSString *)title
{
    if(!self.cookie)return;
    NSDictionary *dic = @{
                          kPeriscopeParaLoginSession        : self.sessionToken,
                          kPeriscopeParaLoginSessionSecret  : self.sessionSecret,
                          kPeriscopeParaCookie              : self.cookie,
                          kPeriscopeParaBroadcastID         : [self.broadcastInfo objectForKey:@"id"],
                          kPeriscopeParaBroadcastTitle      : title,
                          };
    [LAHttp httpsPostWithURL:[PeriscopeApi publishBroadcastUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
     {
         NSLog(@"Publish:%@",resultObj.jsonObj);
     }];
}

- (void)uploadBroadcastCoverImage:(UIImage *)imge
{
    
}

- (void)getUserProfileSettings
{
    NSDictionary *dic = @{
                          kPeriscopeParaCookie              : self.cookie,
                          };
    [LAHttp httpsPostWithURL:[PeriscopeApi settingsUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
     {
         NSLog(@"User Settings:%@",resultObj.jsonObj);
     }];
}

- (void)aliveBroadcast
{
    if(!self.cookie)return;
    NSDictionary *dic = @{
                          kPeriscopeParaCookie              : self.cookie,
                          kPeriscopeParaBroadcastID         : [self.broadcastInfo objectForKey:@"id"],
                          };
    [LAHttp httpsPostWithURL:[PeriscopeApi pingBroadcastUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
     {
         NSLog(@"Alive:%@",resultObj.jsonObj);
     }];
}

- (void)endBroadcast
{
    if(!self.cookie)return;
    NSDictionary *dic = @{
                          kPeriscopeParaCookie              : self.cookie,
                          kPeriscopeParaBroadcastID         : [self.broadcastInfo objectForKey:@"id"],
                          };
    [LAHttp httpsPostWithURL:[PeriscopeApi endBroadcastUrl] andJSonParameterDic:dic andResponseBlock:^(RequestResultObj *resultObj)
     {
         NSLog(@"EndBroadcast:%@",resultObj.jsonObj);
     }];
}

- (void)getRegion
{
    [LAHttp httpsGetWithURL:@"https://signer.periscope.tv/" andJSonParameterDic:nil andResponseBlock:^(RequestResultObj *resultObj) {
        NSString *response = [[NSString alloc]initWithData:resultObj.data encoding:NSUTF8StringEncoding];
        self.serverRegion  = response;
    }];
}
@end
