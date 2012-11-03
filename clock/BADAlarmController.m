//
//  BADAlarmController.m
//  clock
//
//  Created by Toby Weston on 31/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAlarmController.h"
#import "BADTime.h"
#import "PSLog.h"

@interface BADAlarmController ()

@property(nonatomic, retain) IBOutlet UISwipeGestureRecognizer *swipeRecognizer;
@property(nonatomic, retain) IBOutlet UILabel *alarm;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;
@property(nonatomic, retain) UIColor *text;

@property(nonatomic) CGPoint startOfSwipe;
@property(nonatomic) BOOL shouldBlink;

@end


@implementation BADAlarmController

@synthesize alarm;
@synthesize backgroundTime;
@synthesize text;
@synthesize startOfSwipe;
@synthesize shouldBlink;


#pragma mark - Delegate methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLabels];
}

- (void)viewWillAppear:(BOOL)animated {
    self.shouldBlink = YES;
    [self startBlinking];
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

#pragma mark - Actions

- (IBAction)dismissView:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeTime:(UIGestureRecognizer *)sender {
    UISwipeGestureRecognizer *gesture = (UISwipeGestureRecognizer*) sender;
    CGPoint point = [gesture locationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        shouldBlink = NO;
        startOfSwipe = point;
    }

    BADTime* time = [BADTime timeFromString:alarm.text];
    if (startOfSwipe.x < point.x) {
        alarm.text = [[time decrease] string];
    } else {
        alarm.text = [[time increase] string];
    }
}

#pragma mark - UI setup

- (void)setupLabels {
    UIFont *font = [UIFont fontWithName:@"Digital-7 Mono" size:140.0];
    text = alarm.textColor;
    backgroundTime.font = font;
    backgroundTime.text = @"88:88";
    alarm.font = font;
    alarm.text = @"12:00";
}

- (void)startBlinking {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(blinkOff) userInfo:nil repeats:NO];
}

- (void)blinkOff {
    alarm.textColor = UIColor.blackColor;
    [self.view bringSubviewToFront:backgroundTime];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blinkOn) userInfo:nil repeats:NO];
}

- (void)blinkOn {
    alarm.textColor = text;
    [self.view sendSubviewToBack:backgroundTime];
    if (self.shouldBlink)
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(blinkOff) userInfo:nil repeats:NO];
}

@end
