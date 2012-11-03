//
//  BADTime.m
//  clock
//
//  Created by Toby Weston on 03/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADTime.h"

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
    [formatter setDateFormat:@"HH:mm"];
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

- (BADTime*)increase {
    time = [time dateByAddingTimeInterval:60];
    return self;
}

- (BADTime*)decrease {
    time = [time dateByAddingTimeInterval:-60];
    return self;
}

#pragma mark - Getters

- (NSString*)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self.time];
}

- (NSString*)string {
    return [self stringWithFormat:@"HH:mm"];
}

- (double)seconds {
    return [[[BADTime now] stringWithFormat:@"ss"] doubleValue];
}

@end
