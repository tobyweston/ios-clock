//
//  BADViewController.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADViewController.h"


@implementation BADViewController

- (void) viewDidLoad {
    [self updateTime];
    [self scheduleTimeUpdatesEvery:1];
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) updateTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    time.text = [formatter stringFromDate:[NSDate date]];
}

- (void)scheduleTimeUpdatesEvery:(NSTimeInterval) seconds {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}


@end
