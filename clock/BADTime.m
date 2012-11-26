//
//  BADTime.m
//  clock
//
//  Created by Toby Weston on 03/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADTime.h"

#define kTwentyFourHourClock @"HH:mm"
#define kTwelveHourClock     @"h:mm a"


@interface BADTime ()

@property(nonatomic, retain) NSDate *time;

@end


@implementation BADTime

@synthesize time;

#pragma mark - Static initialisers

+ (BADTime*)now {
    return [[BADTime alloc] initWithTime:[NSDate date]];
}

+ (BADTime*)timeFromString:(NSString *)colonSeperatedHoursAndMinutes {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kTwentyFourHourClock];
    return [[BADTime alloc] initWithTime:[formatter dateFromString:colonSeperatedHoursAndMinutes]];
}


#pragma mark - Initialisers

- (BADTime*)initWithTime:(NSDate*) t {
    self = [super init];
    if (self) {
        self.time = t;
    }
    return self;
}


#pragma mark - Time manipulation

- (BADTime*)increaseBy:(NSTimeInterval) interval {
    time = [time dateByAddingTimeInterval:interval * -1];
    return self;
}

- (BADTime*)decreaseBy:(NSTimeInterval) interval {
    time = [time dateByAddingTimeInterval:interval];
    return self;
}


#pragma mark - Getters

- (NSString*)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self.time];
}

- (NSString*)string {
    return [self stringWithFormat:kTwentyFourHourClock];
}

- (double)seconds {
    return [[[[BADTime alloc] initWithTime:self.time] stringWithFormat:@"ss"] doubleValue];
}

@end
