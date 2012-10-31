//
//  BADViewController.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADViewController.h"

@interface BADViewController ()

@property(nonatomic, retain) IBOutlet UILabel *time;
@property(nonatomic, retain) NSTimer *timer;

@end


@implementation BADViewController

@synthesize time;
@synthesize timer;

#pragma mark - Delegate methods

- (void)viewDidLoad {
//    [self updateTime];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [self startScheduledTimeRefreshEvery:3];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self stopScheduledTimeRefresh];
    [self viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Time related methods

- (void)updateTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    time.text = [formatter stringFromDate:[NSDate date]];
}

- (void)startScheduledTimeRefreshEvery:(NSTimeInterval)seconds {
    timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)stopScheduledTimeRefresh {
    [timer invalidate];
}

@end
