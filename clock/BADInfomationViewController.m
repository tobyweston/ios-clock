//
//  BADInfomationViewController.m
//  clock
//
//  Created by Toby Weston on 31/10/2012.
//  Copyright (c) 2012 Bad Robot (London) Ltd. All rights reserved.
//

#import "BADInfomationViewController.h"

@interface BADInfomationViewController ()

@end

@implementation BADInfomationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
}

- (IBAction)dismissView:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
