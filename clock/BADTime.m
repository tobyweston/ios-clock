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

+ (BADTime*)now {
    return [[BADTime alloc] initWithTime:[NSDate date]];
}

- (BADTime*)initWithTime:(NSDate*) t {
    self = [super init];
    if (self) {
        self.time = t;
    }
    return self;
}

- (NSString*)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self.time];
}

- (double)seconds {
    return [[[BADTime now] stringWithFormat:@"ss"] doubleValue];
}

@end
