//
//  Register.h
//  Metis
//
//  Created by ligang5 on 14-5-27.
//  Copyright (c) 2014年 ligang5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpSender.h"
#import "CommonUtils.h"
#import "AppConstants.h"

@interface Register : UIViewController <UITextFieldDelegate, HttpSenderDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField_email;
@property (strong, nonatomic) IBOutlet UITextField *textField_userName;
@property (strong, nonatomic) IBOutlet UITextField *textField_password;
@property (strong, nonatomic) IBOutlet UITextField *textField_confromPassword;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl_gender;
@property (strong, nonatomic) IBOutlet UIButton *button_signUp;
@property (strong, nonatomic) IBOutlet UIButton *button_cancel;

-(IBAction)signUpButtonClicked;
-(IBAction)cancelButtonClicked;
//-(void)genderSegmentedControlChanged:(int*)gender;
-(IBAction)backgroundBtn:(id)sender;

@end
