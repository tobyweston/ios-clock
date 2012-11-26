//
//  BADAppDelegate.h
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDigitalFont @"digitalk-mono"
#define kDigitalFontNotWorking @"Digital-7 Mono"
#define kDigitalFontAlternative @"DS-Digital"


@class BADClockController;

@interface BADAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BADClockController *viewController;

@end
