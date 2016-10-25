//
//  PeriscopeApi.h
//  PeriscopeLive
//
//  Created by David.Dai on 2016/10/24.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
//http://static.pmmlabs.ru/OpenPeriscope/#/loginTwitter

#define kPeriscopeParaLoginSession           @"session_key"
#define kPeriscopeParaLoginSessionSecret     @"session_secret"
#define kPeriscopeParaLoginUserId            @"user_id"
#define kPeriscopeParaLoginUserName          @"user_name"

#define kPeriscopeParaCookie                 @"cookie"

#define kPeriscopeParaBroadcast              @"broadcast"
#define kPeriscopeParaBroadcastID            @"broadcast_id"
#define kPeriscopeParaBroadcastTitle         @"status"
#define kPeriscopeParaBroadcastWidth         @"width"
#define kPeriscopeParaBroadcastHeight        @"height"
#define kPeriscopeParaBroadcastRegion        @"region"


@interface PeriscopeApi : NSObject

//auth
+ (NSString *)loginWithTwitterUrl;

//live
+ (NSString *)createBroadcastUrl;
+ (NSString *)publishBroadcastUrl;
+ (NSString *)pingBroadcastUrl;
+ (NSString *)endBroadcastUrl;
+ (NSString *)broadcastSummaryUrl;

//user Profile
+ (NSString *)settingsUrl;
@end
