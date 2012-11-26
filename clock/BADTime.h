//
//  BADTime.h
//  clock
//
//  Created by Toby Weston on 03/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADTime : NSObject

+ (BADTime*)now;
+ (BADTime*)timeFromString:(NSString*) string;


- (BADTime*)initWithTime:(NSDate*) time;
- (BADTime*)increaseBy:(NSTimeInterval) interval;
- (BADTime*)decreaseBy:(NSTimeInterval) interval;
- (NSString*)string;
- (double)seconds;

@end
