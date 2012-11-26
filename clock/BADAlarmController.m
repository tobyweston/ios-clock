//
//  BADAlarmController.m
//  clock
//
//  Created by Toby Weston on 31/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAlarmController.h"
#import "BADTime.h"
#import "BADAppDelegate.h"
#import "BADHoldGestureRegonizer.h"
#import "UIPanGestureRecognizer+DirectionalUIGesture.h"

@interface BADAlarmController ()

@property(nonatomic, retain) IBOutlet UILabel *alarm;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;
@property(nonatomic, retain) UIColor *originalTextColor;
@property(nonatomic, retain) UIPanGestureRecognizer *swipeGesture;

@property(nonatomic) CGPoint startOfSwipe;
@property(nonatomic) BOOL shouldBlink;

@end


@implementation BADAlarmController

@synthesize alarm;
@synthesize backgroundTime;
@synthesize originalTextColor;
@synthesize startOfSwipe;
@synthesize shouldBlink;
@synthesize swipeGesture;


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
    UIFont *font = [UIFont fontWithName:kDigitalFont size:140.0];
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
    swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeTime:)];
    [swipeGesture setDelegate:self];
    [self.view addGestureRecognizer:swipeGesture];

    BADHoldGestureRegonizer *holdGesture = [[BADHoldGestureRegonizer alloc] initWithTarget:self action:@selector(changeTimeFast:)];
    [holdGesture setDelegate:self];
    [self.view addGestureRecognizer:holdGesture];
}

#pragma mark - Gesture delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
     return YES;
}

#pragma mark - Alarm methods

- (void)changeTime:(UIGestureRecognizer *)sender {
    if (sender != swipeGesture)
        return;
    if (swipeGesture.state == UIGestureRecognizerStateBegan)
        shouldBlink = NO;
    
    BADTime *time = [BADTime timeFromString:alarm.text];
    if ([swipeGesture directionInView:self.view] == UISwipeGestureRecognizerDirectionLeft) 
        alarm.text = [[time decreaseBy:60] string];
    else 
        alarm.text = [[time increaseBy:60] string];
}

- (void)changeTimeFast:(UIGestureRecognizer *)sender {
    BADTime *time = [BADTime timeFromString:alarm.text];
    if ([swipeGesture directionInView:self.view] == UISwipeGestureRecognizerDirectionLeft)
        alarm.text = [[time decreaseBy:300] string];
    else
        alarm.text = [[time increaseBy:300] string];
}
@end
