//
//  Register.m
//  Metis
//
//  Created by ligang5 on 14-5-27.
//  Copyright (c) 2014年 ligang5. All rights reserved.
//

#import "Register.h"

@implementation Register

@synthesize textField_email;
@synthesize textField_confromPassword;
@synthesize textField_password;
@synthesize textField_userName;
@synthesize segmentedControl_gender;
@synthesize button_cancel;
@synthesize button_signUp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    textField_confromPassword.delegate = self;
    textField_email.delegate = self;
    textField_password.delegate = self;
    textField_userName.delegate = self;
    
    textField_confromPassword.placeholder = @"请再次输入密码";
    textField_email.placeholder = @"请输入您的邮箱";
    textField_password.placeholder = @"请输入您的密码，至少6位";
    textField_userName.placeholder = @"请输入您的用户名";
    
    textField_email.keyboardType = UIKeyboardTypeEmailAddress;
    
    textField_password.secureTextEntry = YES;
    textField_confromPassword.secureTextEntry = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(IBAction)signUpButtonClicked
{
    NSString* email = [textField_email text];
    NSString* password = [textField_password text];
    NSString* conformPassword = [textField_confromPassword text];
    NSString* userName = [textField_userName text];
    NSNumber* gender = [NSNumber numberWithInteger:[segmentedControl_gender selectedSegmentIndex]];
    NSString* salt = [CommonUtils randomStringWithLength:6];
    
    
//    NSLog(@"random String: %@",salt);
    if (password.length<6) {
        [CommonUtils showSimpleAlertViewWithTitle:@"Warning" WithMessage:@"Wrong password length" WithDelegate:self WithCancelTitle:@"OK"];
    }
    else if (![CommonUtils isEmailValid:email]) {
        [CommonUtils showSimpleAlertViewWithTitle:@"Warning" WithMessage:@"Wrong email format" WithDelegate:self WithCancelTitle:@"OK"];
    }
    else if (![conformPassword isEqualToString:password])
    {
        [CommonUtils showSimpleAlertViewWithTitle:@"Warning" WithMessage:@"Password conformed error" WithDelegate:self WithCancelTitle:@"OK"];
    }
    else
    {
        NSMutableString* md5_str = [CommonUtils MD5EncryptionWithString:[[NSString alloc]initWithFormat:@"%@%@",password,salt]];
        NSMutableDictionary* mDic = [CommonUtils packParamsInDictionary:email,@"email",md5_str,@"passwd",userName,@"name",gender,@"gender",salt,@"salt",nil];
        
        NSLog(@"test packDictionary: %@",mDic);
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:mDic options:NSJSONWritingPrettyPrinted error:nil];
        HttpSender* httpSender = [[HttpSender alloc]initWithDelegate:self];
        [httpSender sendMessage:jsonData withOperationCode:REGISTER];
    }
    
    
//    NSMutableDictionary* mDic = [CommonUtils packParamsInDictionary:[NSNumber numberWithInt:4],email,@"email",md5_str,@"passwd",userName,@"name",gender,@"gender",salt,@"salt",nil];
    
    
    
}

-(IBAction)cancelButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)backgroundBtn:(id)sender
{
//    [sender resignFirstResponder];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

//-(void)genderSegmentedControlChanged:(int*)gender
//{
//    switch ([segmentedControl_gender selectedSegmentIndex]) {
//        case 0:
//            *gender = 0;
//            break;
//        case 1:
//            *gender = 1;
//            break;
//            
//        default:
//            break;
//    }
//    
//}

#pragma mark - HttpSenderDelegate

-(void)finishWithReceivedData:(NSData *)rData
{
    NSString* temp = [[NSString alloc]initWithData:rData encoding:NSUTF8StringEncoding];
    NSLog(@"Register received Data: %@",temp);
    NSDictionary *response1 = [NSJSONSerialization JSONObjectWithData:rData options:NSJSONReadingMutableLeaves error:nil];
    NSNumber *cmd = [response1 valueForKey:@"cmd"];
    switch ([cmd intValue]) {
        case NORMAL_REPLY:
            NSLog(@"register succeeded");
            break;
        case USER_EXIST:
            NSLog(@"user existed");
            break;
        default:
            break;
    }
}



#pragma mark - UItextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    [textField resignFirstResponder];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}

@end
