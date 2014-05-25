//
//  ViewController.m
//  DrawerNavDemo
//
//  Created by Zhao yang on 10/31/13.
//  Copyright (c) 2013 maize. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Create Some Test Buttons
    
    UIButton *btnShowLeftView = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
    UIButton *btnShowRightView = [[UIButton alloc] initWithFrame:CGRectMake(160, 50, 100, 25)];
    
    [btnShowLeftView setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [btnShowRightView setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [btnShowLeftView setBackgroundColor:[UIColor blackColor]];
    [btnShowRightView setBackgroundColor:[UIColor blackColor]];
    [btnShowLeftView setTitle:@"Show left" forState:UIControlStateNormal];
    [btnShowRightView setTitle:@"Show right" forState:UIControlStateNormal];
    
    [btnShowRightView addTarget:self action:@selector(showRightView) forControlEvents:UIControlEventTouchUpInside];
    [btnShowLeftView addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    // Create left view

    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UILabel *lblLeft = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 29)];
    lblLeft.text = @"Left View";
    [self.leftView addSubview:lblLeft];
    self.leftView.backgroundColor = [UIColor orangeColor];
    
    // Create right view
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UILabel *lblRight = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 29)];
    lblRight.text = @"Right View";
    [self.rightView addSubview:lblRight];
    self.rightView.backgroundColor = [UIColor redColor];

    
    // Create center view
    
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.centerView.backgroundColor = [UIColor grayColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 29)];
    lbl.text = @"Center View";
    [self.centerView addSubview:lbl];
    [self.centerView addSubview:btnShowLeftView];
    [self.centerView addSubview:btnShowRightView];

    // Set parameters
    self.leftViewVisibleWidth = 120;
    self.rightViewVisibleWidth = 220;
    self.leftViewCenterX = 70;
    self.rightViewCenterX = 150;
    self.showDrawerMaxTrasitionX = 40;

    // Initializations
    [self initialDrawerViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
