//
//  ViewController.m
//  PeriscopeLive
//
//  Created by David.Dai on 16/10/8.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import "ViewController.h"
#import "PeriscopeApiManager.h"

@interface ViewController ()
@property (nonatomic,strong) NSDictionary *periscopeLoginDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error)
    {
        if (session)
        {
            [[PeriscopeApiManager defaultManager] loginWithTwitter:session];
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
    }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
}

- (IBAction)publishBroadcast:(id)sender
{
    [[PeriscopeApiManager defaultManager] publishBroadcastWithTitle:@"Test"];
}

- (IBAction)aliveBroadcast:(id)sender
{
    [[PeriscopeApiManager defaultManager] aliveBroadcast];
}

- (IBAction)closeBroadcast:(id)sender
{
    [[PeriscopeApiManager defaultManager] endBroadcast];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
