//
//  LogIn.h
//  Metis
//
//  Created by mac on 14-5-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CommonUtils.h"
#import "Register.h"
#import "AppConstants.h"
#import "HttpSender.h"
#import <CommonCrypto/CommonDigest.h>



@interface LogIn : UIViewController

//@property (retain, nonatomic) UIViewController* thisView;
@property (retain, nonatomic) IBOutlet UITextField *textField_userName;
@property (retain, nonatomic) IBOutlet UITextField *textField_password;
@property (retain, nonatomic) IBOutlet UIButton *button_logIn;
//@property (nonatomic, copy) void (^getSaltHandler)(NSURLResponse *response, NSData *data, NSError *connectionError);
//@property (nonatomic, copy) void (^logInHandler)(NSURLResponse *response, NSData *data, NSError *connectionError);


@property (nonatomic,retain) NSString* logInEmail;
@property (nonatomic, retain) NSString* logInPassword;


-(BOOL)isTextFieldEmpty;
-(IBAction)logInBtnClicked:(id)sender;
- (IBAction)registerBtnClicked:(id)sender;


-(void)jumpToMainView;
-(void)jumpToRegisterView;

@end
