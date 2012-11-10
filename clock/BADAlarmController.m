//
//  BADAlarmController.m
//  clock
//
//  Created by Toby Weston on 31/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAlarmController.h"
#import "BADTime.h"

@interface BADAlarmController ()

@property(nonatomic, retain) IBOutlet UILabel *alarm;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;
@property(nonatomic, retain) UIColor *originalTextColor;

@property(nonatomic) CGPoint startOfSwipe;
@property(nonatomic) BOOL shouldBlink;

@end


@implementation BADAlarmController

@synthesize alarm;
@synthesize backgroundTime;
@synthesize originalTextColor;
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
    [self setupGestures];
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

#pragma mark - UI setup

- (void)setupLabels {
    UIFont *font = [UIFont fontWithName:@"Digital-7 Mono" size:140.0];
    originalTextColor = alarm.textColor;
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
    alarm.textColor = originalTextColor;
    [self.view sendSubviewToBack:backgroundTime];
    if (self.shouldBlink)
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(blinkOff) userInfo:nil repeats:NO];
}

- (void)setupGestures {
    UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeTime:)];
    [swipe setDelegate:self];
    [self.view addGestureRecognizer:swipe];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTimeFast:)];
//    [tap setDelegate:self];
//    [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changeTimeFast:)];
    [longTap setDelegate:self];
//    [longTap setMinimumPressDuration:1];
    [self.view addGestureRecognizer:longTap];
}

#pragma mark - Gesture delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
     return YES;
}

#pragma mark - Alarm methods

- (void)changeTime:(UIGestureRecognizer *)sender {
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *) sender;
    CGPoint current = [gesture locationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        shouldBlink = NO;
        startOfSwipe = current;
    }
    
    BADTime *time = [BADTime timeFromString:alarm.text];
    if (self.startOfSwipe.x < current.x) {
        alarm.text = [[time decrease] string];
    } else {
        alarm.text = [[time increase] string];
    }
    NSLog(@".");
}

- (void)changeTimeFast:(UIGestureRecognizer *)sender {
    NSLog(@"Long tap detected");
}
@end
