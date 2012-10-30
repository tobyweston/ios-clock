//
//  BADViewController.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADViewController.h"


@implementation BADViewController

@synthesize time;
@synthesize timer;

- (void) viewDidLoad {
//    [self updateTime];
    [self startScheduledTimeRefreshEvery:3];
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) updateTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    time.text = [formatter stringFromDate:[NSDate date]];
}

- (void)startScheduledTimeRefreshEvery:(NSTimeInterval) seconds {
    timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)stopScheduledTimeRefresh {
    [timer invalidate];
}

@end
