//
//  NSObject+DirectionalUIGesture.m
//  clock
//
//  Created by Toby Weston on 25/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "UIPanGestureRecognizer+DirectionalUIGesture.h"


@implementation UIPanGestureRecognizer (DirectionalUIGesture)

- (UISwipeGestureRecognizerDirection)directionInView:(UIView*) view {
    CGPoint velocity = [self velocityInView:view];
    if (velocity.x > 0)
        return UISwipeGestureRecognizerDirectionRight;
    return UISwipeGestureRecognizerDirectionLeft;
}

@end
