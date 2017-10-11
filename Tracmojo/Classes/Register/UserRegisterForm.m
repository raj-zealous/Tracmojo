//
//  UserRegisterForm.m
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "UserRegisterForm.h"
#import "PrivacyTerms.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ModelClass.h"
#import "Dashboard.h"
#import "Validate.h"
#import <MapKit/MapKit.h>
#import "UserLoginForm.h"

@interface UserRegisterForm ()
{
    NSMutableString *combinedText;
    NSString*strcode;
}
@end

@implementation UserRegisterForm
{
    ModelClass *mc;
     DarckWaitView *dark;
    NSString *strCurrentID,*email,*phone,*name,*callingCode,*countryCode,*callcode;
}
- (void)viewDidLoad
{
     strcode=@"+";
    
     if (_isTwi) {
      _txtUsername.text=_STRUSERNAME;
         
     }
    
    self.isTicked = false;
    
    _btnSubmit.layer.cornerRadius=_btnSubmit.frame.size.height/6;
    _btnSubmit.layer.masksToBounds=YES;

    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    [_scrollVIEW setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    _scrollVIEW.showsVerticalScrollIndicator=NO;
    [_btnSubmit setBackgroundColor:[UIColor colorWithRed:10/255.0 green:84.0/255.0 blue:120.0/255.0 alpha:1.0]];
    if (DELEGATE.isGoogle==YES)
    {
        _txtEmail.text=_strEmail;
        DELEGATE.isGoogle=NO;
    }
    else
    {
        _txtEmail.text=@"";
    }
    
    //NSLog(@"%@",_twitter_dic);
    
    if ([[NSString stringWithFormat:@"%@",[_twitter_dic objectForKey:@"code"]] isEqualToString:@"200"])
    {
        _txtEmail.text=[NSString stringWithFormat:@"%@",[[_twitter_dic objectForKey:@"User"] objectForKey:@"twitter_email"]];       
         _txtUsername.text=[NSString stringWithFormat:@"%@",[[_twitter_dic objectForKey:@"User"] objectForKey:@"first_name"]];
         _txtLastName.text=[NSString stringWithFormat:@"%@",[[_twitter_dic objectForKey:@"User"] objectForKey:@"last_name"]];
        
    }
    
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                               @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    
    NSLocale *locale = [NSLocale currentLocale];
    countryCode = [locale objectForKey: NSLocaleCountryCode];
    callingCode = [dictCodes objectForKey:countryCode];
    _txtPhoneAdder.text=[NSString stringWithFormat:@"%@%@",strcode,callingCode];
    
    

    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    recognizer.numberOfTapsRequired = 1;
    self.lblPrivacyPolicy.userInteractionEnabled = true;
    [self.lblPrivacyPolicy addGestureRecognizer:recognizer];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture1:)];
    recognizer1.numberOfTapsRequired = 1;
    self.lblPrivacyPolicy2.userInteractionEnabled = true;
    [self.lblPrivacyPolicy2 addGestureRecognizer:recognizer1];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIToolbar *toolBar =[[UIToolbar alloc]initWithFrame:CGRectMake(0,0,320,50)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [toolBar sizeToFit];
    [toolBar setItems: [NSArray arrayWithObjects:
                        
                        [[UIBarButtonItem alloc]initWithTitle:@"Previous" style:UIBarButtonItemStyleDone target:self action:@selector(preClicked)],
                        
                        [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextClicked)],
                        
                        [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                        [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)],
                        nil]];
    [textField setInputAccessoryView:toolBar];
    return YES;
    
}


-(void)doneClicked
{
    [_txtEmail resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtUsername resignFirstResponder];
    [_txtPhoneNo resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtPhoneAdder resignFirstResponder];
}


-(void)preClicked
{
    if ([_txtUsername isFirstResponder]) {
        
    }
    
    else     if ([_txtLastName isFirstResponder]) {
        [_txtLastName resignFirstResponder];
        [_txtUsername becomeFirstResponder];
        
    }
    
    else     if ([_txtEmail isFirstResponder]) {
        [_txtEmail resignFirstResponder];
        [_txtLastName becomeFirstResponder];
        
    }
    else     if ([_txtPassword isFirstResponder]) {
        [_txtPassword resignFirstResponder];
        [_txtEmail becomeFirstResponder];
        
    }
    else     if ([_txtPhoneAdder isFirstResponder]) {
        [_txtPhoneAdder resignFirstResponder];
        [_txtPassword becomeFirstResponder];
        
    }
    
    else     if ([_txtPhoneNo isFirstResponder]) {
        [_txtPhoneNo resignFirstResponder];
        [_txtPhoneAdder becomeFirstResponder];
        
    }
    

    
    
}

-(void)nextClicked
{
    if ([_txtUsername isFirstResponder]) {
        [_txtUsername resignFirstResponder];
        [_txtLastName becomeFirstResponder];
        
    }
    
    else     if ([_txtLastName isFirstResponder]) {
        [_txtLastName resignFirstResponder];
        [_txtEmail becomeFirstResponder];
        
    }
    
    else     if ([_txtEmail isFirstResponder]) {
        [_txtEmail resignFirstResponder];
        [_txtPassword becomeFirstResponder];
        
    }
    else     if ([_txtPassword isFirstResponder]) {
        [_txtPassword resignFirstResponder];
        [_txtPhoneAdder becomeFirstResponder];
        
    }
    else     if ([_txtPhoneAdder isFirstResponder]) {
        [_txtPhoneAdder resignFirstResponder];
        [_txtPhoneNo becomeFirstResponder];
        
    }
    
    
    

}




-(BOOL)validation
{
    
    email = [self.txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    phone = [self.txtPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    callcode = [_txtPhoneAdder.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    name = [self.txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(name.length<=0 || name.length>0 || email.length <= 0 || _txtLastName.text.length<=0 || _txtLastName.text.length>0 || _txtPassword.text.length<=0 )
    {
        if(name.length<=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter first name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtUsername becomeFirstResponder];
            [alert show];
        }
        else if ([Validate isNumbersOnly:_txtUsername.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"First name contains invalid characters" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtUsername becomeFirstResponder];
            [alert show];
        }
        else if ([Validate isNumbersOnly:_txtLastName.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Last name contains invalid characters" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtLastName becomeFirstResponder];
            [alert show];
        }
        else if (_txtLastName.text.length<=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter your last name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtLastName becomeFirstResponder];
            [alert show];
        }
        else if(email.length <=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter your email" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtEmail becomeFirstResponder];
            [alert show];
        }
        else if (![Validate isValidEmailAddress:_txtEmail.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid email address" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtEmail becomeFirstResponder];
            [alert show];
        }
        else if (_txtPassword.text.length<=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtPassword becomeFirstResponder];
            [alert show];
        }
        else if(callcode.length <=1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter calling code" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtPhoneAdder becomeFirstResponder];
            [alert show];
        }
       /* else if(phone.length <=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter phone no" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtPhoneNo becomeFirstResponder];
            [alert show];
        }*/
        else
        {
            return YES;
        }
        
       
    }
    else
    {
        NSString *emailid = self.txtEmail.text;
        //  NSString *confirmEmailid = COEtxtConfirmEmail.text;
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL emailMatches=[emailTest evaluateWithObject:emailid];
        // BOOL confirmEmailMatches=[emailTest evaluateWithObject:confirmEmailid];
        if(emailMatches )
        {
            return YES;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid email address" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtEmail becomeFirstResponder];
            [alert show];
        }
    }
    
    
    
    return NO;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == _txtPhoneNo)
    {
        
        if ([_txtPhoneNo isFirstResponder]) {
            NSString *currentString = [_txtPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
            int length = (int)[currentString length] - (int)range.length;
            return (length > 15) ? NO : YES;
            
        }
    }
    else if (textField == _txtPhoneAdder)
    {
        if ([_txtPhoneAdder isFirstResponder]) {
            NSString *currentString = [_txtPhoneAdder.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
            int length = (int)[currentString length] - (int)range.length;
            
            if (length>3) {
                return NO;
            }
            return (length < 1) ? NO : YES;
        }
    }
    return YES;
}

-(IBAction)btnSubmitClicked:(id)sender
{
    
    if(self.isTicked == true){
        NSString *strUsername=[NSString stringWithFormat:@"%@",_txtUsername.text];
        NSString *strPassword=[NSString stringWithFormat:@"%@",_txtPassword.text];
        NSString *strEmail=[NSString stringWithFormat:@"%@",_txtEmail.text];
        NSString *strMobile=[NSString stringWithFormat:@"%@",_txtPhoneNo.text];
        
        NSString *strCell=[NSString stringWithFormat:@"%@-%@",_txtPhoneAdder.text,strMobile];
        NSString *strLast=[NSString stringWithFormat:@"%@",_txtLastName.text];
        
        if ([self validation])
        {
            [self.view endEditing:YES];
            
            if(phone.length > 0){
                
                if(phone.length < 10 || phone.length > 15){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid Phone Number" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [_txtPhoneNo becomeFirstResponder];
                    [alert show];
                    return;
                    
                }
                
            }

            if ([Validate isConnectedToNetwork])
            {
                DELEGATE.password=[NSString stringWithFormat:@"%@",strPassword];
                [mc Email:strEmail Password:strPassword Mobile:strCell First_name:strUsername Last_name:strLast Device_id:DELEGATE.tokenstring Device_type:@"i" selector:@selector(btnSignupCLicked:)];
            }
        }
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You need to agree to terms before completing registration" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    }
    
   
}

-(void)btnSignupCLicked:(NSDictionary *)result
{
    
        
  NSLog(@"result is %@",result);
    
    if(self.isTicked == true){
        NSString *strCode=[NSString stringWithFormat:@"%@",[result valueForKey:@"code"]];
        NSString *strStatus=[NSString stringWithFormat:@"%@",[result valueForKey:@"status"]];
        
        if ([strCode isEqualToString:@"200"] || [strStatus isEqualToString:@"Success"])
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[[result valueForKey:@"User"] valueForKey:@"user_id"] forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            DELEGATE.email=[NSString stringWithFormat:@"%@",[[result valueForKey:@"User"]valueForKey:@"email_id"]];
            
            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            myalert.tag=101;
            [myalert show];
            
            
        }
        else if([strCode isEqualToString:@"601"]||[strStatus isEqualToString:@"error"])
        {
            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"This email id is already registered!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [myalert show];
        }

    }
    else{
    
    }
  
 
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {

        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btntermsClicked:(id)sender
{

    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.Is_from_terms = true;
    
    [self.navigationController pushViewController:privacyVC animated:YES];

}
- (IBAction)btnPrivacyClicked:(id)sender
{
    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.Is_from_terms = false;
    
    privacyVC.strUserID;
    [self.navigationController pushViewController:privacyVC animated:YES];
}




- (IBAction)btnRegistrationTickCLicked:(id)sender
{
   
    if(self.isTicked == true){
        [self.tickButton setImage:[UIImage imageNamed:@"regUserUntick"] forState:UIControlStateNormal];
        self.isTicked = false;
        
    }
    else{
        [self.tickButton setImage:[UIImage imageNamed:@"regUserTick"] forState:UIControlStateNormal];
        self.isTicked = true;
        
    }
    
}


- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    
    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.strUserID;
    [self.navigationController pushViewController:privacyVC animated:YES];


}

- (void)handleTapGesture1:(UITapGestureRecognizer *)sender{
    
    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.strUserID;
    [self.navigationController pushViewController:privacyVC animated:YES];
    
    
}



- (IBAction)btnFacebookClicked:(id)sender
{
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error)
     {
         if (FBSession.activeSession.state == FBSessionStateOpen)
         {
             [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphUser> *user, NSError *error)
              {
                  
            }];}
     }];
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}
@end
