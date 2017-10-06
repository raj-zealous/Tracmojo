//
//  UserRegisterForm.h
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface UserRegisterForm : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblPrivacyPolicy;
@property (strong, nonatomic) IBOutlet UILabel *lblPrivacyPolicy2;

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneAdder;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNo;
@property (strong, nonatomic) NSString *strEmail,*strTwitterID;
@property (strong, nonatomic) NSDictionary *twitter_dic;
@property(strong,nonatomic)NSString *str_email,*strIDS,*STRUSERNAME;
@property(atomic) BOOL isTwi;
@property(atomic) BOOL isTicked;

@property (strong, nonatomic) IBOutlet UIButton *tickButton;



@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollVIEW;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmitClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnPrivacyClicked:(id)sender;
- (IBAction)btnFacebookClicked:(id)sender;

@end
