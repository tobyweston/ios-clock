//
//  BADHoldGestureRegonizer.m
//  clock
//
//  Created by Toby Weston on 11/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>
#import "BADHoldGestureRegonizer.h"

#define kMinimumPressDuration 1

@interface BADHoldGestureRegonizer ()

@property (nonatomic, retain) NSTimer *holdTimer;
@property (nonatomic, retain) NSTimer *eventTimer;
@property (nonatomic, retain) id target;
@property (nonatomic) SEL action;

@end


@implementation BADHoldGestureRegonizer

@synthesize minimumPressDuration;
@synthesize holdTimer;
@synthesize eventTimer;
@synthesize target;
@synthesize action;


#pragma mark - Initialise

- (id)init {
    if (self = [super init]) {
        self.minimumPressDuration = kMinimumPressDuration;
    }
    return self;
}

- (id)initWithTarget:(id)theTarget action:(SEL)theAction {
    if (self = [super initWithTarget:theTarget action:theAction]) {
        self.target = theTarget;
        self.action = theAction;
        self.minimumPressDuration = kMinimumPressDuration;
    }
    return self;
}


#pragma mark - Checks

- (void)holdEventFired:(NSTimer *)timer {
    NSLog(@"should I fire?");
    if (timer == holdTimer) {
        NSLog(@"hold event fired");
        self.state = UIGestureRecognizerStateBegan;
        [timer invalidate];
        self.holdTimer = nil;
        [self startFiringEvents];
    }
}

#pragma mark - Gesture methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"Begin");
    if ([touches count] != 1 || [[touches anyObject] tapCount] > 1) {
        self.state = UIGestureRecognizerStateFailed;
        NSLog(@"Failed");
        return;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.minimumPressDuration target:self selector:@selector(holdEventFired:) userInfo:nil repeats:NO];
    self.holdTimer = timer;
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed)
         return;
    // capture direction
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"End");
    [super touchesEnded:touches withEvent:event];
    [self stopFiringEvents];
    [self resetTimer];
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Canceled");
    [super touchesCancelled:touches withEvent:event];
    [self stopFiringEvents];
    [self resetTimer];
    self.state = UIGestureRecognizerStateFailed;
}


#pragma mark - Target action methods

- (void)startFiringEvents {
    if (eventTimer == nil) {
        NSLog(@"Staring events...");
        BADHoldGestureRegonizer *gesturer = self;
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:action];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation setArgument:&gesturer atIndex:2];
        eventTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 invocation:invocation repeats:YES];
    }
}

- (void)stopFiringEvents {
    if (eventTimer != nil) {
        NSLog(@"Stopping events...");
        [eventTimer invalidate];
    }
    eventTimer = nil;
}


#pragma mark - Reset methods

- (void)reset {
    [super reset];
    [self resetTimer];
}

- (void)resetTimer {
    if (holdTimer != nil) {
        [holdTimer invalidate];
    }
    holdTimer = nil;
}

@end
