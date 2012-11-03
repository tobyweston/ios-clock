//
//  BADAlarmController.m
//  clock
//
//  Created by Toby Weston on 31/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADAlarmController.h"
#import "PSLog.h"

@interface BADAlarmController ()

@property(nonatomic, retain) IBOutlet UILabel *alarm;
@property(nonatomic, retain) IBOutlet UILabel *backgroundTime;

@end


@implementation BADAlarmController

@synthesize alarm;
@synthesize backgroundTime;

#pragma mark - Delegate methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
}

-(void)viewDidLoad {
    PSLog(@"");
    [super viewDidLoad];
    [self setupLabels];
}

#pragma mark - Actions

- (IBAction)dismissView:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UI setup

- (void)setupLabels {
    UIFont *font = [UIFont fontWithName:@"Digital-7 Mono" size:140.0];
    backgroundTime.font = font;
    backgroundTime.text = @"88:88";
    alarm.font = font;
    alarm.text = @"12:00";
}

@end
