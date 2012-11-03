//
//  BADClockController.m
//  clock
//
//  Created by Toby Weston on 25/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADClockController.h"
#import "BADAlarmController.h"
#import "PSLog.h"

@interface BADClockController ()

@property(nonatomic, retain) IBOutlet UILabel *time;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;
@property(nonatomic, retain) NSTimer *timer;

@end


@implementation BADClockController

@synthesize time;
@synthesize backgroundTime;
@synthesize timer;

#pragma mark - Delegate methods

- (void)viewDidLoad {
    PSLog(@"");
    [super viewDidLoad];
    UIFont *font = [UIFont fontWithName:@"Digital-7 Mono" size:140.0];

    backgroundTime.text = @"88:88";
    backgroundTime.font = font;
    
    time.frame = CGRectMake(time.frame.origin.x, time.frame.origin.y, time.frame.size.width, 450);
    time.font = font;

    [self updateTime];
    [self scheduleScheduledTimeRefreshEvery:60 from:[NSDate date]];
}

#pragma mark - UI Updates

- (void)updateTime {
    NSString *now = [self currentTimeAsStringWithFormat:@"HH:mm"];
    PSLog(@"Updating time to %@", now);
    time.text = now;
}

#pragma mark - Information view

- (IBAction)showInformationView:(UIButton *)sender {
    PSLog(@"");
    BADAlarmController *info = [[BADAlarmController alloc] initWithNibName:@"BADAlarmView" bundle:nil];
    [self presentViewController:info animated:YES completion:nil];
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
