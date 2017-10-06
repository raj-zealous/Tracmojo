//
//  UserLoginForm.h
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "FHSTwitterEngine.h"

@interface UserLoginForm : UIViewController<UITextFieldDelegate>

- (IBAction)btnBackCLicked:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnCreateAccount;
@property (strong, nonatomic) IBOutlet UIButton *btnGo;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitterClicked;
@property (strong, nonatomic) NSString  *currentDeviceId,*email;
@property (strong, nonatomic) NSMutableArray *arrtemp;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollVIEW;
@property (strong, nonatomic) NSString *strid, *strEmail, *strName, *strDeviceID;
@property (strong, nonatomic) NSString *strGoogleID, *strGoogleEmail, *strGoogleName;

//Custom VIEW

@property (strong, nonatomic) IBOutlet UIButton *btnEmailView;
@property (strong, nonatomic) IBOutlet UIView *myCustomVIEW;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailID;
@property (strong, nonatomic) IBOutlet UIImageView *imgVIEW;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;

@property (strong, nonatomic) IBOutlet UIButton *btncancel;
@property (strong, nonatomic) IBOutlet UIButton *btnsendemail;
- (IBAction)btnCustomVIEWclicked:(id)sender;


- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnForgetPasswordClicked:(id)sender;
- (IBAction)btnCreateAccClicked:(id)sender;
- (IBAction)btnFacebookLoginClicked:(id)sender;
- (IBAction)btnGooglePlusClicked:(id)sender;
- (IBAction)btnTwitterClicked:(id)sender;


@end
