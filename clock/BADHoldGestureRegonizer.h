//
//  BADHoldGestureRegonizer.h
//  clock
//
//  Created by Toby Weston on 11/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADHoldGestureRegonizer : UIPanGestureRecognizer

@property (nonatomic) CFTimeInterval minimumPressDuration;

- (id)initWithTarget:(id)theTarget panAction:(SEL)thePanAction andHoldAction:(SEL)theHoldAction;
- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
