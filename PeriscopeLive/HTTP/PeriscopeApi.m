//
//  PeriscopeApi.m
//  PeriscopeLive
//
//  Created by David.Dai on 2016/10/24.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import "PeriscopeApi.h"

@implementation PeriscopeApi

+ (NSString *)loginWithTwitterUrl
{
    return @"https://api.periscope.tv/api/v2/loginTwitter";
}

+ (NSString *)createBroadcastUrl
{
    return @"https://api.periscope.tv/api/v2/createBroadcast";
}

+ (NSString *)endBroadcastUrl
{
    return @"https://api.periscope.tv/api/v2/endBroadcast";
}

+ (NSString *)publishBroadcastUrl
{
    return @"https://api.periscope.tv/api/v2/publishBroadcast";
}

+ (NSString *)pingBroadcastUrl
{
    return @"https://api.periscope.tv/api/v2/pingBroadcast";
}

+ (NSString *)broadcastSummaryUrl
{
    return @"https://api.periscope.tv/api/v2/broadcastSummary";
}

+ (NSString *)settingsUrl
{
    return @"https://api.periscope.tv/api/v2/getSettings";
}

@end
