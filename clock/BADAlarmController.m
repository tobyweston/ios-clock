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

#define kOneMinute   60
#define kFiveMinutes 300

@interface BADAlarmController ()

@property(nonatomic, retain) IBOutlet UILabel *alarm;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;
@property(nonatomic, retain) UIColor *originalTextColor;
@property (weak, nonatomic) IBOutlet UIButton *setAlarmButton;

@property(nonatomic) CGPoint startOfSwipe;
@property(nonatomic) BOOL shouldBlink;

@end


@implementation BADAlarmController

@synthesize alarm;
@synthesize setAlarmButton;
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
    [self setupLabelsAndButton];
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

- (void)setupLabelsAndButton {
    UIFont *font = [UIFont fontWithName:kDigitalFont size:140.0];
    originalTextColor = alarm.textColor;
    backgroundTime.font = font;
    backgroundTime.text = @"88:88";
    alarm.font = font;
    alarm.text = @"12:00";
    setAlarmButton.titleLabel.font = [UIFont fontWithName:kDigitalFontAlternative size:22];
    setAlarmButton.titleLabel.textColor = originalTextColor;
    setAlarmButton.titleLabel.text = @"Set";
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
    BADHoldGestureRegonizer *gesture = [[BADHoldGestureRegonizer alloc] initWithTarget:self panAction:@selector(changeTime:) andHoldAction:@selector(changeTime:)];
    [gesture setDelegate:self];
    [self.view addGestureRecognizer:gesture];
}

#pragma mark - Gesture delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
     return NO;
}

#pragma mark - Alarm methods

- (void)changeTime:(UIGestureRecognizer *)sender {
    BADHoldGestureRegonizer *gesture = (BADHoldGestureRegonizer*) sender;
    if (gesture.state == UIGestureRecognizerStateBegan)
        shouldBlink = NO;
    
    BADTime *time = [BADTime timeFromString:alarm.text];
    if ([gesture directionInView:self.view] == UISwipeGestureRecognizerDirectionLeft) 
        alarm.text = [[time decreaseBy:kOneMinute] string];
    else 
        alarm.text = [[time increaseBy:kOneMinute] string];
}

@end
