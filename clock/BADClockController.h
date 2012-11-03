//
//  BADClockController.h
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADClockController : UIViewController

- (void)scheduleScheduledTimeRefreshEvery:(NSTimeInterval)seconds from:(NSDate *)date;

- (void)stopScheduledTimeRefresh;

- (IBAction)showAlarmView:(UIButton *)sender;

@end
