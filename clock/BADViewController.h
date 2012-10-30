//
//  BADViewController.h
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) NSTimer *timer;

- (void) startScheduledTimeRefreshEvery:(NSTimeInterval) seconds;

- (void) stopScheduledTimeRefresh;

@end
