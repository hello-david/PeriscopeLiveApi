//
//  PeriscopeApiManager.h
//  PeriscopeLive
//
//  Created by David.Dai on 2016/10/24.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "LAHttp.h"

@interface PeriscopeApiManager : NSObject
@property (nonatomic,strong) NSString    *rtmpsAddr;

+ (instancetype)defaultManager;

- (void)loginWithTwitter:(TWTRSession *)session;
- (void)createBroadcast;
- (void)publishBroadcastWithTitle:(NSString *)title;
- (void)aliveBroadcast;
- (void)endBroadcast;

- (void)getRegion;
@end
