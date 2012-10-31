//
//  BADViewController.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADViewController.h"
#import "PSLog.h"

@interface BADViewController ()

@property(nonatomic, retain) IBOutlet UILabel *time;
@property(nonatomic, retain) NSTimer *timer;

@end


@implementation BADViewController

@synthesize time;
@synthesize timer;

#pragma mark - Delegate methods

- (void)viewDidLoad {
    PSLog(@"");
    [super viewDidLoad];
    time.font = [UIFont fontWithName:@"DS-Digital" size:150.0];
    [self updateTime];
    [self scheduleScheduledTimeRefreshEvery:60 from:[NSDate date]];
}

#pragma mark - UI Updates

- (void)updateTime {
    NSString *now = [self currentTimeAsStringWithFormat:@"HH:mm"];
    PSLog(@"Updating time to %@", now);
    time.text = now;
}

#pragma mark - Time related methods

- (void)scheduleScheduledTimeRefreshEvery:(NSTimeInterval)seconds from:(NSDate *)date {
    double delay = seconds - [[self currentTimeAsStringWithFormat:@"ss"] doubleValue];
    [self startScheduledTimeRefreshEvery:60 delayedBy:delay];
}

- (void)startScheduledTimeRefreshEvery:(NSTimeInterval)seconds delayedBy:(double)delayInSeconds {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self updateTime];
        if (timer != nil)
            [self stopScheduledTimeRefresh];
        timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    });

}

- (void)stopScheduledTimeRefresh {
    [timer invalidate];
    timer = nil;
}

- (NSString *)currentTimeAsStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:[NSDate date]];
}

@end
