//
//  LogIn.m
//  Metis
//
//  Created by mac on 14-5-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LogIn.h"



@interface LogIn ()<UITextFieldDelegate,HttpSenderDelegate>
{
    enum TAG_LOGIN
    {
        Tag_userName = 50,
        Tag_password
    };
}


@end

@implementation LogIn

@synthesize textField_password;
@synthesize textField_userName;
@synthesize button_logIn;
@synthesize logInEmail;
@synthesize logInPassword;

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
    
    self.textField_userName.tag = Tag_userName;
    self.textField_userName.returnKeyType = UIReturnKeyDone;
    self.textField_userName.delegate = self;
    self.textField_userName.placeholder = @"请输入您的邮箱";
    self.textField_userName.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.textField_password.tag = Tag_password;
    self.textField_password.returnKeyType = UIReturnKeyDone;
    self.textField_password.delegate = self;
    self.textField_password.placeholder = @"请输入密码";
    self.textField_password.secureTextEntry = YES;
    
   /* __block LogIn* thisView = self;
    
    self.getSaltHandler = ^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSString *temp3 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data: %@",temp3);
        //NSLog(@"response: %@",response);
        NSDictionary *response1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSNumber *cmd = [response1 valueForKey:@"cmd"];
        NSString *salt = [response1 valueForKey:@"salt"];
        NSString *str = [thisView.logInPassword stringByAppendingString:salt];
        
        if ([cmd intValue] == GET_SALT) {
            NSLog(@"here");
            const char *cstr = [str UTF8String];
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(cstr, strlen(cstr), result);
            NSMutableString *hash = [NSMutableString string];
            for (int i = 0; i < 16; i++)
                [hash appendFormat:@"%02X", result[i]];
            
            NSDictionary *params = [[NSDictionary alloc]init];
            [params setValue:thisView.logInEmail forKey:@"email"];
            [params setValue:hash forKey:@"password"];
            [params setValue:[NSNumber numberWithBool:YES] forKey:@"has_salt"];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
            NSLog(@"%@",jsonData);
            HttpSender *httpSender = [[HttpSender alloc]init];
            //[httpSender sendMessage:jsonData withOperationCode:LOGIN withHandler:thisView.logInHandler];
            
        }
        else
        {
            NSLog(@"获取盐值失败");
        }
        NSLog(@"%@",cmd);
         
        [thisView jumpToNext];

    };
    
    self.getSaltHandler = ^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSString *temp3 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data: %@",temp3);
    };*/
    
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

-(void)jumpToMainView
{
    ViewController* mainView = [[ViewController alloc]init];
    [self presentViewController:mainView animated:YES completion:nil];
}

-(void)jumpToRegisterView
{
    
    Register* registerView = [[Register alloc]init];
    [self presentViewController:registerView animated:YES completion:nil];

}


-(BOOL)isTextFieldEmpty
{
    if ([(UITextField *)[self.view viewWithTag:Tag_userName] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_userName] text] isEqualToString:@""]) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"User name can't be empty" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_password] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_password] text] isEqualToString:@""]) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Password can't be empty" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil, nil];
        [alert show];
    }
    return YES;

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
    switch (textField.tag) {
            
        case Tag_userName:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if (![CommonUtils isEmailValid: textField.text]) {
                    
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The format of email is invalid" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
            break;
        case Tag_password:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 5) {
                    
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The length of the password should't less than 5" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
            break;
            default:
            break;
    }
    
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

#pragma mark - Button click
-(IBAction)logInBtnClicked:(id)sender
{
    NSLog(@"%@",[self.textField_userName text]);
    self.logInEmail = [self.textField_userName text];
    self.logInPassword = [self.textField_password text];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.logInEmail forKey:@"email"];
    [dictionary setValue:@"" forKey:@"passwd"];
    [dictionary setValue:[NSNumber numberWithBool:NO] forKey:@"has_salt"];
    
    NSLog(@"%@",dictionary);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    HttpSender *httpSender = [[HttpSender alloc]initWithDelegate:self];
    [httpSender sendMessage:jsonData withOperationCode:LOGIN];
    //[self jumpToNext];
    

}


- (IBAction)registerBtnClicked:(id)sender {
    [self jumpToRegisterView];
}

#pragma mark - HttpSenderDelegate

-(void)finishWithReceivedData:(NSData *)rData
{
    NSString* temp = [[NSString alloc]initWithData:rData encoding:NSUTF8StringEncoding];
    NSLog(@"Received Data: %@",temp);
    NSDictionary *response1 = [NSJSONSerialization JSONObjectWithData:rData options:NSJSONReadingMutableLeaves error:nil];
    NSNumber *cmd = [response1 valueForKey:@"cmd"];
    switch ([cmd intValue]) {
        case GET_SALT:
        {
            NSString *salt = [response1 valueForKey:@"salt"];
            NSString *str = [self.logInPassword stringByAppendingString:salt];
            NSLog(@"password+salt: %@",str);
            
            //MD5 encrypt
            NSMutableString *md5_str = [NSMutableString string];
            md5_str = [CommonUtils MD5EncryptionWithString:str];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setValue:self.logInEmail forKey:@"email"];
            [params setValue:md5_str forKey:@"passwd"];
            [params setValue:[NSNumber numberWithBool:YES] forKey:@"has_salt"];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
            NSLog(@"%@",[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding]);
            
            HttpSender *httpSender = [[HttpSender alloc]initWithDelegate:self];
            [httpSender sendMessage:jsonData withOperationCode:LOGIN];

        }
            break;
            case LOGIN_SUC:
        {
            NSLog(@"login succeeded");
            [self jumpToMainView];
        }
            break;
            case PASSWD_NOT_CORRECT:
        {
            NSLog(@"password not correct");
        }
            break;
            case USER_NOT_FOUND:
        {
            NSLog(@"user not found");
        }
            break;
            
        default:
            break;
    }

    
}

@end
