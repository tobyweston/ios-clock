//
//  BADAppDelegate.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAppDelegate.h"
#import "BADClockController.h"
#import "PSLog.h"

@interface BADAppDelegate ()

@property (nonatomic, retain) UIImageView *launch;

@end


@implementation BADAppDelegate

@synthesize launch;

#pragma mark - Lifecycle methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[BADClockController alloc] initWithNibName:@"BADClockView" bundle:nil];
    self.viewController.wantsFullScreenLayout = YES;
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    [self loadLaunchImageAndBringToFront];
    [self fadeOutLaunchImage];
    return YES;
}

#pragma mark - Launch image manipulations

- (void)loadLaunchImageAndBringToFront {
    launch = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	if (rintf([[UIScreen mainScreen] bounds].size.height) == 568)
		launch.image = [UIImage imageNamed:@"Default-568h"]; // iPhone 5
	else
		launch.image = [UIImage imageNamed:@"Default"];
    launch.alpha = 0.9;
	[self.window addSubview:launch];
	[self.window bringSubviewToFront:launch];
}

- (void)fadeOutLaunchImage {
    __block BADAppDelegate *blockSelf = self;
	[UIView animateWithDuration:3
					 animations:^{
						 blockSelf.launch.alpha = 0.0;
					 }
					 completion:^(BOOL finished){
						 [blockSelf.launch removeFromSuperview];
						 blockSelf.launch = nil;
					 }];
}

@end
