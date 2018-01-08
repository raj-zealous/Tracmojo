//
//  AccountViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "AccountViewController.h"
#import "ModelClass.h"
#import "Validate.h"
#import "FacebookInstance.h"
#import <GooglePlus/GooglePlus.h>
#import <sqlite3.h>
#import "UIView+Toast.h"
#import "PrivacyTerms.h"

@interface AccountViewController ()
{
    BOOL is_social;
}
@end

@implementation AccountViewController
{
    ModelClass *mc;
    NSString *primary,*secondary,*name1,*name2,*password,*phone;
    
    
}

- (void)viewDidLoad {
    
    _txtCode.tag=88;
    [_send_btn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0]];
    _scrl_obj.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 610);
    
    _txtfld_pass.enabled=NO;
    _send_btn .layer.cornerRadius=_send_btn.frame.size.height/6;
    _send_btn.layer.masksToBounds=YES;
    
    
    primary=[[NSString alloc]init];
    secondary=[[NSString alloc]init];
    name1=[[NSString alloc]init];
    name2=[[NSString alloc]init];
    password=[[NSString alloc]init];
    phone=[[NSString alloc]init];
    
    
    
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    
    if ([Validate isConnectedToNetwork])
    {
        
      
  
               
                
                
        
                       
            
                 [mc myprofile:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] selector:@selector(getprofile:)];

        
        
        
  
        

        
        
    }
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == _txtfld_phone)
    {
        
        

        if ([_txtfld_phone isFirstResponder]) {
            NSString *currentString = [_txtfld_phone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
            int length = (int)[currentString length] - (int)range.length;
            return (length > 15) ? NO : YES;
            
        }
    }
    else if (textField == _txtCode)
    {
        if ([_txtCode isFirstResponder]) {
            NSString *currentString = [_txtCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
            int length = (int)[currentString length] - (int)range.length;
            
            if (length>3) {
                return NO;
            }
            return (length < 1) ? NO : YES;
            
        }
        
    }
    
  
    
    
    
    
    return YES;
    
}

-(void)getprofile:(NSDictionary *)result
{
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
    {
        
        
        if ([[[result valueForKey:@"User"] valueForKey:@"fb_id"] isEqualToString:@""] && [[[result valueForKey:@"User"]  valueForKey:@"gplus_id"] isEqualToString:@""] && [[[result valueForKey:@"User"]  valueForKey:@"twitter_id"] isEqualToString:@""] )
        {
            _lbl_primary.text=[[result valueForKey:@"User"] valueForKey:@"email_id"];
            _txtfld_second.text=[[result valueForKey:@"User"] valueForKey:@"secondary_email"];
            _txtfld_name1.text=[[result valueForKey:@"User"] valueForKey:@"first_name"];
            _txtfld_name2.text=[[result valueForKey:@"User"] valueForKey:@"last_name"];
            
            
            if ([[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"]count]>1) {
                _txtfld_phone.text=[[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"] objectAtIndex:1];
            }
            if ([[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"]count]>0) {
                _txtCode.text=[NSString stringWithFormat:@"%@",[[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"] objectAtIndex:0]];
            }
            
            
            is_social=NO;
        }
        else
        {
            _lbl_primary.text=[[result valueForKey:@"User"] valueForKey:@"email_id"];
            _txtfld_second.text=[[result valueForKey:@"User"] valueForKey:@"secondary_email"];
            _txtfld_name1.text=[[result valueForKey:@"User"] valueForKey:@"first_name"];
            _txtfld_name2.text=[[result valueForKey:@"User"] valueForKey:@"last_name"];
            
            if ([[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"]count]>0) {
                _txtCode.text=[NSString stringWithFormat:@"%@",[[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"] objectAtIndex:0]];
            }
            
            if ([[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"]count]>1) {
                _txtfld_phone.text=[[[[result valueForKey:@"User"] valueForKey:@"mobile"]componentsSeparatedByString:@"-"] objectAtIndex:1];
            }
            
            
            
            is_social=YES;
            
            _txtfld_current.hidden=YES;
            _txtfld_pass.hidden=YES;
            _lbl1.hidden=YES;
            _lbl2.hidden=YES;
            
             if (_txtfld_pass.hidden == YES && _txtfld_current.hidden  == YES)
             {
                 _lblPasswordHightCOnstant.constant  = 0;
                 self.view.setNeedsUpdateConstraints;
             }
            
            _phnlbl.frame=CGRectMake(_phnlbl.frame.origin.x, _phnlbl.frame.origin.y-122, _phnlbl.frame.size.width, _phnlbl.frame.size.height);
            
            _txtCode.frame=CGRectMake(_txtCode.frame.origin.x, _txtCode.frame.origin.y-122, _txtCode.frame.size.width, _txtCode.frame.size.height);\
            
            _txtfld_phone.frame=CGRectMake(_txtfld_phone.frame.origin.x, _txtfld_phone.frame.origin.y-122, _txtfld_phone.frame.size.width, _txtfld_phone.frame.size.height);
            
            _send_btn.frame=CGRectMake(_send_btn.frame.origin.x, _send_btn.frame.origin.y-122, _send_btn.frame.size.width, _send_btn.frame.size.height);
            
            _img1.hidden=YES;
            _img2.hidden=YES;
            
            _scrl_obj.contentSize=CGSizeMake(_scrl_obj.contentSize.width, _scrl_obj.contentSize.height-122);
            
            _txtfld_current.enabled=NO;
        }
        
    }
    else
    {
        
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [myalert show];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField==_txtfld_second) {
        [_txtfld_name1 becomeFirstResponder];
        
    }
    
    if (textField==_txtfld_name1) {
        [_txtfld_name2 becomeFirstResponder];
        
    }
    
    
    if (!is_social) {
        if (textField==_txtfld_name2) {
            [_txtfld_current becomeFirstResponder];
            
        }
        if (textField==_txtfld_current) {
            [_txtfld_pass becomeFirstResponder];
            
        }
    }
    
    else{
        if (textField==_txtfld_name2) {
            [_txtCode becomeFirstResponder];
            
        }
    }
  
    if (textField==_txtCode) {
        [_txtfld_phone becomeFirstResponder];
        
    }
    
    
   
   
    return YES;
    

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtfld_current)
    {
        
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField.tag==0) {
        
        primary=textField.text;
        
    }
    if (textField.tag==1) {
        
        secondary=textField.text;
        
    }
    if (textField.tag==2) {
        
        name1=textField.text;
        
    }
    if (textField.tag==3) {
        
        name2=textField.text;
        
    }
    if (textField.tag==4) {
        
        password=textField.text;
        
    }
    
    if (textField.tag==5) {
        
        phone=textField.text;
        
    }
    if (textField == _txtfld_current) {
        _txtfld_pass.enabled=YES;
    }
    
    
}



-(IBAction) save:(id)sender
{
    
    if ([self validation]) {
        [self.view endEditing:YES];
        
        if ([Validate isConnectedToNetwork])
        {
            
            
            if([_lbl_primary.text isEqualToString:_txtfld_second.text])
                
            {
                UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter different Email id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                [myalert show];
            }
            else{
                
                NSString *sendingPhone=[[NSString stringWithFormat:@"%@-%@",_txtCode.text,_txtfld_phone.text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                
                
                [mc editprofile:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] email_id:@"" sec_emailid:_txtfld_second.text name1:_txtfld_name1.text name2:_txtfld_name2.text Mobile:sendingPhone password:[_txtfld_pass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] current:_txtfld_current.text selector:@selector(editprofiled:)];
            }
            
        }
    }
}


-(void)editprofiled:(NSDictionary *)result

{
    
    [self.view makeToast:[result valueForKey:@"message"]];
    

    
}

-(IBAction) btnback:(id)sender
{
    [DELEGATE hidePopup];
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)validation
{
    
    NSString *email = [self.txtfld_second .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *namef = [self.txtfld_name1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *namel = [self.txtfld_name2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pass = [self.txtfld_pass .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *cpass = [self.txtfld_current .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *confirm = [self.txtfld_pass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *phonenum = [self.txtfld_phone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if(email.length <= 0 ||namel.length <=0  ||namef.length <=0 || pass.length <= 0 ||confirm.length <=0|| cpass.length <=0  ||phonenum.length<=0  )
    {
        
        
        if(email.length>=1 && ![Validate isValidEmailAddress:_txtfld_second.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter secondary email" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtfld_second becomeFirstResponder];
            [alert show];
        }
        
        else  if(namef.length <=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter first name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtfld_name1 becomeFirstResponder];
            [alert show];
            
            
        }
        
        else  if(namel.length <=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter last name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtfld_name2 becomeFirstResponder];
            [alert show];
        }
        
        else if(cpass.length >0 && !is_social)
        {
            if(pass.length <=0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter new password"   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [_txtfld_pass becomeFirstResponder];
                [alert show];
            }
            
            else if(cpass.length<=0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter new password"   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [_txtfld_pass becomeFirstResponder];
                [alert show];
            }
            else
            {
                return YES;
            }
            
        }
        
        else if( phonenum.length<=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter contact no" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtfld_phone becomeFirstResponder];
            [alert show];
        }
        else
        {
            _txtfld_pass.text=@"";
            return YES;
        }
    }
    else
    {
        NSString *emailid = self.txtfld_second.text;
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"please enter valid email address" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txtfld_second becomeFirstResponder];
            
            [alert show];
            
        }
        
        
    }
    
    
    return NO;
}
- (IBAction)btnLogoutClicked:(id)sender
{
    
    UIAlertView *alert_logout=[[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert_logout.tag=102;
    [alert_logout show];
  
}

- (IBAction)btntermsClicked:(id)sender
{
    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.Is_from_terms = true;
    
    [self.navigationController pushViewController:privacyVC animated:YES];

}

- (IBAction)btnprivacyClicked:(id)sender
{
    PrivacyTerms *privacyVC=[[PrivacyTerms alloc]initWithNibName:@"PrivacyTerms" bundle:nil];
    privacyVC.Is_from_terms = false;
    [self.navigationController pushViewController:privacyVC animated:YES];

}

-(void)logoutapi:(NSDictionary *)result

{
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 102)
    {
        if (buttonIndex == 1) {
            
            
            GPPSignIn *signOut= [GPPSignIn sharedInstance];
            [signOut signOut];
            
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"time_stemp"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self deleteAllData];
            [FacebookInstance logOut];
            [DELEGATE hidePopup];
            
            [mc logoutapi:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] selector:@selector(logoutapi:)];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"callInvitation"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
        
            
            UserLoginForm *loginform=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
            loginform.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginform animated:YES];
            
            
            
            
            
        }
    }
    if (alertView.tag==99) {
        if ([Validate isConnectedToNetwork])
        {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


-(void)deleteAllData
{
    [DELEGATE openDatabase];
    sqlite3_stmt *selectStatement;
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM tracmojo"];
    if (sqlite3_prepare_v2(DELEGATE.database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(selectStatement)==SQLITE_ROW)
        {
            sqlite3_finalize(selectStatement);
        }
    }
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}
@end
