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


#pragma mark - Gesture methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([touches count] != 1 || [[touches anyObject] tapCount] > 1) {
        self.state = UIGestureRecognizerStateFailed;
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
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self stopFiringEvents];
    [self resetTimer];
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self stopFiringEvents];
    [self resetTimer];
    self.state = UIGestureRecognizerStateFailed;
}


#pragma mark - Event methods and target actions

- (void)holdEventFired:(NSTimer *)timer {
    if (timer == holdTimer) {
        self.state = UIGestureRecognizerStateBegan;
        [timer invalidate];
        self.holdTimer = nil;
        [self startFiringEvents];
    }
}

- (void)startFiringEvents {
    if (eventTimer == nil) {
        BADHoldGestureRegonizer *gesturer = self;
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:action];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation setArgument:&gesturer atIndex:2];
        eventTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 invocation:invocation repeats:YES];
    }
}

- (void)stopFiringEvents {
    if (eventTimer != nil) {
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
