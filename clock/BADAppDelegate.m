//
//  BADAppDelegate.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAppDelegate.h"

#import "BADViewController.h"

@implementation BADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[BADViewController alloc] initWithNibName:@"BADViewController" bundle:nil];
    self.viewController.wantsFullScreenLayout = YES;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
