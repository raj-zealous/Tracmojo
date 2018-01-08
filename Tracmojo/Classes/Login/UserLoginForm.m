//
//  UserLoginForm.m
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "FacebookInstance.h"
#import <FacebookSDK/FacebookSDK.h>

#import "UserLoginForm.h"
#import "UserRegisterForm.h"
#import "ModelClass.h"
#import "DarckWaitView.h"
#import "AppDelegate.h"
#import "Dashboard.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "FHSTwitterEngine.h"
#import "Validate.h"
#import "IntroductionViewController.h"


static NSString * const kClientId = @"729168122628-4mkmi2ac0n7ptn2ljqhc7nqd2nc0s3b3.apps.googleusercontent.com";

@interface UserLoginForm()<GPPSignInDelegate,FHSTwitterEngineAccessTokenDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet GPPSignInButton *signInButton;

@end

@implementation UserLoginForm
{
    ModelClass *mc;
    DarckWaitView *dark;
    NSString *strids;
    GPPSignIn *GoogleSignin;
    NSString *twitterID;
    NSMutableDictionary *dictUserData;
}

- (void)viewDidLoad {
    
   
    
  
     _myCustomVIEW.hidden=YES;
    
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    dark=[[DarckWaitView alloc]init];
    
    if ([UIScreen mainScreen].applicationFrame.size.height <= 480) {
       _scrollVIEW.contentSize=CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+50);
    }
    else
    {
        _scrollVIEW.contentSize=CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    }
    
 
     _scrollVIEW.showsVerticalScrollIndicator=NO;
    [_btnGo setBackgroundColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0]];
    [_btnCreateAccount setBackgroundColor:[UIColor colorWithRed:10/255.0 green:84.0/255.0 blue:120.0/255.0 alpha:1.0]];
    _arrtemp=[[NSMutableArray alloc]init];
    [GPPSignIn sharedInstance].clientID = kClientId;
    [GPPSignIn sharedInstance].scopes= [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,kGTLAuthScopePlusUserinfoEmail, nil];
    [GPPSignIn sharedInstance].shouldFetchGoogleUserID=YES;
    [GPPSignIn sharedInstance].shouldFetchGoogleUserEmail=YES;
    [GPPSignIn sharedInstance].delegate=self;
    
    [[FHSTwitterEngine sharedEngine] permanentlySetConsumerKey:TWITTER_CONSUMER_KEY andSecret:TWITTER_SECRET_KEY];
    [[FHSTwitterEngine sharedEngine] setDelegate:self];
    [[FHSTwitterEngine sharedEngine] loadAccessToken];
    [_myCustomVIEW setHidden:YES];
    
    
  
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]==NULL)
    {
        
    }
    else
    {
        Dashboard *dash=[[Dashboard alloc]initWithNibName:@"Dashboard" bundle:nil];
        dash.strID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]];
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
   

    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _btnCreateAccount.layer.cornerRadius=_btnCreateAccount.frame.size.height/6;
    _btnCreateAccount.layer.masksToBounds=YES;
    _btnGo.layer.cornerRadius=_btnGo.frame.size.height/6;
    _btnGo.layer.masksToBounds=YES;
    
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtEmailID resignFirstResponder];
    
   
  _txtUsername.text=DELEGATE.email;
    

   
        _txtPassword.text=DELEGATE.password ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Login api calling

- (IBAction)btnCustomVIEWclicked:(id)sender {
}

- (IBAction)btnLoginClicked:(id)sender
{
    //[[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IsUpdated"];

    NSString *strUser=[NSString stringWithFormat:@"%@",_txtUsername.text];
    NSString *strPassword=[NSString stringWithFormat:@"%@",_txtPassword.text];
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtEmailID resignFirstResponder];
    if ([_txtUsername.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter your email" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [_txtUsername becomeFirstResponder];
        [alert show];
    }
    else if (![Validate isValidEmailAddress:_txtUsername.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid email" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [_txtUsername becomeFirstResponder];
        [alert show];
    }
    else if ([_txtPassword.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter your password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [_txtPassword becomeFirstResponder];
        [alert show];
    }
 
    else
    {
        if ([Validate isConnectedToNetwork])
        {
             [self.view endEditing:YES];
            [mc login:strUser pass:strPassword device_id:DELEGATE.tokenstring device_type:@"i" selector:@selector(loginSelectorClicked:)];
        }
        
    }
}


-(void)loginSelectorClicked
{
    
}
-(void)loginSelectorClicked:(NSMutableDictionary *)result
{
        NSString *strCode=[NSString stringWithFormat:@"%@",[result valueForKey:@"code"]];
   
    NSString *strID=[NSString stringWithFormat:@"%@",[[result valueForKey:@"User"] valueForKey:@"user_id"]];
    
   
    if ([strCode isEqualToString:@"200"])
    {
        
        DELEGATE.email=@"";
        DELEGATE.password=@"";
        
        
        NSString *str_email=[NSString stringWithFormat:@"%@",[[result valueForKey:@"User"] objectForKey:@"email_id"]];
        [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults]setObject:str_email forKey:@"userEmail"];
        [[NSUserDefaults standardUserDefaults]setValue:@"Y" forKey:@"login"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:[result valueForKey:@"message"] forKey:@"messageKey"];
        [[NSUserDefaults standardUserDefaults]setValue:[result objectForKey:@"callinvitation"] forKey:@"callInvitation"];
        
        if(DELEGATE.isfirsttime == TRUE){
            IntroductionViewController *obj=[[IntroductionViewController alloc] initWithNibName:@"IntroductionViewController" bundle:nil];
            [self.navigationController pushViewController:obj animated:TRUE];

        }
        else{
            Dashboard *dash=[[Dashboard alloc]init];
            dash.strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
            dash.str_callinvitation=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"callinvitation"]];
            [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
        }
        
        
        
        
        
    
        
        
    }
    else if([strCode isEqualToString:@"601"])
    {
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"This e-mail id is already registered!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [myalert show];
    }
    else
    {
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [myalert show];
    }
}

#pragma mark Forget Password
- (IBAction)btnForgetPasswordClicked:(id)sender
{
    UIColor *color = [UIColor darkGrayColor];
    _txtEmailID.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    


    _btnsendemail.layer.cornerRadius=_btnsendemail.frame.size.height/6;
    _btnsendemail.layer.masksToBounds=YES;
    _btncancel.layer.cornerRadius=_btncancel.frame.size.height/6;
    _btncancel.layer.masksToBounds=YES;
    
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtEmailID resignFirstResponder];
    [_myCustomVIEW setHidden:NO];
   // [self.myCustomVIEW addSubview:_txtEmailID];
 
    //[self.myCustomVIEW addSubview:_btnEmailView];
    //[self.myCustomVIEW addSubview:_btnSend];
  //  [self.myCustomVIEW addSubview:_imgLogo];
   // [self.myCustomVIEW addSubview:_imgVIEW];
    [_btnSend setBackgroundColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0]];
    [_btnSend addTarget:self action:@selector(btnSendEmailClicked:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)btnSendEmailClicked:(id)sender
{
    if ([self txtEmailValid])
    {
            [_txtEmailID resignFirstResponder];
        [self.view endEditing:YES];
        if ([Validate isConnectedToNetwork])
        {
        [mc Email_id:[NSString stringWithFormat:@"%@",_txtEmailID.text] selector:@selector(txtEmailVALID:)];
        }
    }
    
}

-(BOOL)txtEmailValid
{
 
    if ([_txtEmailID.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return NO;
    }
    else if(![Validate isValidEmailAddress:_txtEmailID.text])
    {
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [myalert show];
        return NO;
    }
    return YES;
}


-(void)txtEmailVALID:(NSDictionary*)result
{
    if ([Validate isConnectedToNetwork])
    {
        NSString *strCode=[NSString stringWithFormat:@"%@",[result valueForKey:@"code"]];
        if ([strCode isEqualToString:@"200"])
        {
            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Password has been sent to your registered email address." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            myalert.tag=200;
            [myalert show];
        }
        else if ([strCode isEqualToString:@"401"])
        {
            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@" No such user found with this email id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            myalert.tag=200;
            [myalert show];
        }
        else
        {
            UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Something went wrong please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            myalert.tag=200;
            [myalert show];
        }
    }
    _txtEmailID.text=@"";
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 112)
    {
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    else if (alertView.cancelButtonIndex == buttonIndex)
    {
        [_myCustomVIEW setHidden:YES];
    }
    
    
}

- (IBAction)btnCreateAccClicked:(id)sender
{
    UserRegisterForm *userRegister=[[UserRegisterForm alloc]initWithNibName:@"UserRegisterForm" bundle:nil];
    [self.navigationController pushViewController:userRegister animated:YES];
}


#pragma mark facebook session

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen)
    {
        [self getInformationUser];
        return;
    }
    
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed)
    {
        // If the session is close
        [FacebookInstance logOut];
        [dark hide];
    }
    
    // Handle errors
    if (error)
    {
        NSString *alertText = @"";
        NSString *alertTitle = @"";
        
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES)
        {
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
        }
        else
        {
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
            {

            }
            else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
            {
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
            }
            else
            {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
            }
        }
        [FacebookInstance logOut];
    }
}

#pragma mark Facebook login api calling 

-(void)getInformationUser
{
    
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *aUser, NSError *error) {
             if (!error)
             {
                 //NSLog(@"%@",aUser);
                 strids=[NSString stringWithFormat:@"%@",[aUser valueForKey:@"id"]];
                 NSString *stremail=[NSString stringWithFormat:@"%@",[aUser valueForKey:@"email"]];
                 NSString *strfirst_name=[NSString stringWithFormat:@"%@",[aUser valueForKey:@"first_name"]];
                 NSString *strlast_name=[NSString stringWithFormat:@"%@",[aUser valueForKey:@"last_name"]];
                 [_arrtemp addObject:aUser];
                 [[NSUserDefaults standardUserDefaults]setValue:@"Y" forKey:@"login"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
                 if ([Validate isConnectedToNetwork])
                 {
                [mc Social_Media_Type:@"f" UuserID:strids Email_id:stremail first_name:strfirst_name last_name:strlast_name Device_id:DELEGATE.tokenstring Device_type:@"i" Sel:@selector(loginClicked:)];
                 }
                 [[NSUserDefaults standardUserDefaults]setObject:strids forKey:@"userID"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
             else
                 [dark hide];
         }];
    }
    else
        [dark hide];
}


-(void)loginClicked:(NSMutableDictionary *)result
{
    //NSLog(@"%@",result);
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]] forKey:@"userID"];

    [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    //[self.navigationController pushViewController:dash animated:YES];
}

#pragma mark Facebook Availablity
-(void)btnCheckAvailability:(NSMutableDictionary *)result
{
   
    NSString *strOne=[result valueForKey:@"is_exist"];
    if ([strOne intValue]==1)
    {
      
         [[NSUserDefaults standardUserDefaults]setValue:[result objectForKey:@"callinvitation"] forKey:@"callInvitation"];
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
     
    }
    else
    {
        [dark showWithMessage:nil];
        [FacebookInstance openReadSessionAllowLoginUI: YES completedBlock:^(FBSession *session, FBSessionState state, NSError *error)
         {
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

#pragma mark Facebook Integration Check Api
- (IBAction)btnFacebookLoginClicked:(id)sender
{   DELEGATE.email=@"";
    DELEGATE.password=@"";
    
    NSString *strStrID=[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"];
    
    if (strStrID!=NULL)
    {
        if ([Validate isConnectedToNetwork])
        {
        [mc Media_Type:@"f" UserID:strStrID Device_id:DELEGATE.tokenstring Device_type:@"i" selector:@selector(btnCheckAvailability:)];
        }
    }
    else
    {
        [dark showWithMessage:nil];
        [FacebookInstance openReadSessionAllowLoginUI: YES completedBlock:^(FBSession *session, FBSessionState state, NSError *error)
         
         {
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

#pragma mark GooglePlus Integration

- (IBAction)btnGooglePlusClicked:(id)sender
{   DELEGATE.email=@"";
    DELEGATE.password=@"";
    
    [dark showWithMessage:nil];
    [self.view endEditing:YES];
    GPPSignIn *signIn= [GPPSignIn sharedInstance];
    signIn.clientID = kClientId;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // defined in GTLPlusConstants.h
                     nil];
    signIn.shouldFetchGoogleUserEmail= YES;
    signIn.shouldFetchGoogleUserID=YES;
    signIn.delegate = self;
    signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe, nil];
    [[GPPSignIn sharedInstance] authenticate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    

    
    
}

#pragma mark twitter availability
-(void)btnGoogleAvailability:(NSMutableDictionary *)result
{
    

    NSString *strOne=[NSString stringWithFormat:@"%@",[result valueForKey:@"is_exist"]];
    if ([strOne intValue]==1)
    {
        
        
        Dashboard *dash=[[Dashboard alloc] initWithNibName:@"Dashboard" bundle:nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults]setValue:@"Y" forKey:@"login"];

         [[NSUserDefaults standardUserDefaults]setValue:[result objectForKey:@"callinvitation"] forKey:@"callInvitation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dash.strID=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]]];
        
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    else
    {
        
        //suhail
        
        NSData *ImgData=nil;
        NSURL *url=[[NSURL alloc] initWithString:[dictUserData valueForKey:@"url"]];
        ImgData=[NSData dataWithContentsOfURL:url];
        _strGoogleID = [NSString stringWithFormat:@"%@",[dictUserData valueForKey:@"id"]];
        _strGoogleName=[NSString stringWithFormat:@"%@",[dictUserData valueForKey:@"displayName"]];
        _strGoogleEmail = [NSString stringWithFormat:@"%@",[[[dictUserData valueForKey:@"emails"] objectAtIndex:0] valueForKey:@"value"]];
        
        if ([[NSString stringWithFormat:@"%@",[[dictUserData objectForKey:@"name"] objectForKey:@"familyName"]]isEqualToString:@""] || [[NSString stringWithFormat:@"%@",[[dictUserData objectForKey:@"name"] objectForKey:@"givenName"]] isEqualToString:@""] || [_strGoogleEmail isEqualToString:@""])
        {
            //suhail
            
            UserRegisterForm *regi=[[UserRegisterForm alloc] initWithNibName:@"UserRegisterForm" bundle:nil];
            regi.strEmail=[NSString stringWithFormat:@"%@",
                           [GPPSignIn sharedInstance].authentication.userEmail];
            DELEGATE.isGoogle=YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"google"];
            
            [self.navigationController pushViewController:regi animated:YES];
            


        }
        else
        {
            if ([Validate isConnectedToNetwork])
            {
            [mc Social_Media_Type:@"g" UuserID:_strGoogleID Email_id:_strGoogleEmail first_name:[NSString stringWithFormat:@"%@",[[dictUserData objectForKey:@"name"] objectForKey:@"givenName"]] last_name:[NSString stringWithFormat:@"%@",[[dictUserData objectForKey:@"name"] objectForKey:@"familyName"]] Device_id:DELEGATE.tokenstring Device_type:@"i" Sel:@selector(btnGooglePluseClicked:)];
            }
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:_strGoogleID forKey:@"GoogleID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
      

       
    }
    
    
 
    [dark hide];

}



-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication])
    {
        self.signInButton.hidden = YES;
    } else {
        self.signInButton.hidden = NO;
    }
}

- (void)refreshUserInfo
{
    if ([GPPSignIn sharedInstance].authentication == nil)
    {
       
        return;
    }
}


- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    [MBProgressHUD showHUDAddedTo:[DELEGATE window] animated:YES].detailsLabelText = @"Please Wait...";


     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
 
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
    plusService.retryEnabled = YES;
    
   
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    // plusService.apiVersion = @"v1";
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error) {
                if (error) {
                    
                    //Handle Error
                    [MBProgressHUD hideAllHUDsForView:[DELEGATE window] animated:YES];
                    
                } else
                {

                    [plusService executeQuery:query
                                     completionHandler:^(GTLServiceTicket *ticket,
                                                         GTLPlusPerson *person,
                                                         NSError *error) {
                                         if (error) {
                     
                                         }
                                         else
                                         {
                                             //NSLog(@"%@",person.JSON);
                                             NSDictionary *dic=[NSDictionary dictionaryWithDictionary:person.JSON];
                                             

                                             
                                             //Suhail
                                             
                                                 dictUserData = [[NSMutableDictionary alloc] initWithDictionary:person.JSON];
                                             if ([Validate isConnectedToNetwork])
                                             {
                                             [mc Media_Type:@"g" UserID:[dic valueForKey:@"id"] Device_id:DELEGATE.tokenstring Device_type:@"i" selector:@selector(btnGoogleAvailability:)];
                                             }

                                             //
                                             
                                             
                                                                                  }
                                     }];
                    
                    
                    
                   
                }
            }];
}


-(void)btnGooglePluseClicked:(NSDictionary *)result
{

    //Suhail
    
    if ([[result valueForKey:@"code"] intValue] == 200)
    {
        Dashboard *dash=[[Dashboard alloc] initWithNibName:@"Dashboard" bundle:nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults]setValue:@"Y" forKey:@"login"];

     
        [[NSUserDefaults standardUserDefaults] synchronize];
        dash.strID=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]]];
        
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
}

#pragma mark Twitter Login

- (IBAction)btnTwitterClicked:(id)sender
{
    DELEGATE.email=@"";
    DELEGATE.password=@"";
    
//    if ([[FHSTwitterEngine sharedEngine]isAuthorized]) {
        UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success)
                                             {
                                                 
                                                 [self listResults];
                                             }];
        [self presentViewController:loginController animated:YES completion:nil];
    
       
}

-(void)listResults
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:[[FHSTwitterEngine sharedEngine]verifyCredentials]];
  
   
    NSString *strID=[temp valueForKey:@"id"];
    
    
    NSString *twitterOauthTokenStr;
    NSString *twitterOauthTokenSecretStr;
    if ([Validate isConnectedToNetwork])
    {
    [mc Social_Media_Type:@"t" UuserID:strID Email_id:@"" first_name:[temp valueForKey:@"name"] last_name:@"" Device_id:DELEGATE.tokenstring Device_type:@"i" Sel:@selector(twitterClicked:)];
    }
    twitterID = [[FHSTwitterEngine sharedEngine] authenticatedID];
    twitterOauthTokenStr = [[FHSTwitterEngine sharedEngine] accessToken].key;
    twitterOauthTokenSecretStr = [[FHSTwitterEngine sharedEngine] accessToken].secret;
    
    
    
}

-(void)twitterClicked:(NSDictionary *)result
{
    
    if ([[result objectForKey:@"status"]isEqualToString:@"Success"]) {
        Dashboard *dash=[[Dashboard alloc] initWithNibName:@"Dashboard" bundle:nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults]setValue:@"Y" forKey:@"login"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
         [[NSUserDefaults standardUserDefaults]setValue:[result objectForKey:@"callinvitation"] forKey:@"callInvitation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dash.strID=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[result objectForKey:@"User"] objectForKey:@"user_id"]]];
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    else
    {
    
    UserRegisterForm *userRegister=[[UserRegisterForm alloc]initWithNibName:@"UserRegisterForm" bundle:nil];
    userRegister.twitter_dic=result;
    userRegister.strTwitterID=twitterID;
    [self.navigationController pushViewController:userRegister animated:YES];
    }
    
}


- (IBAction)btnBackCLicked:(id)sender
{
    
    _txtEmailID.text=nil;
    
    [_txtEmailID resignFirstResponder];
    [_myCustomVIEW setHidden:YES];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}
@end
