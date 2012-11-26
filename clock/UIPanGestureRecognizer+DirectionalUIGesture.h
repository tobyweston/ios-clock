//
//  NSObject+DirectionalUIGesture.h
//  clock
//
//  Created by Toby Weston on 25/11/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPanGestureRecognizer (DirectionalUIGesture)

- (UISwipeGestureRecognizerDirection)directionInView:(UIView*) view;

@end
