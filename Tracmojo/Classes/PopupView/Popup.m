//
//  Popup.m
//  Tracmojo
//
//  Created by macmini3 on 06/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "Popup.h"
#import "Validate.h"
#import "Dashboard.h"

@implementation Popup

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.txtinvitecode.delegate = self;
    }
    return self;
}

- (void)layoutSubviews
{
    strInviteCode = self.txtinvitecode.text;
    
    [self.alertView setHidden:true];
    [self.okExitView setHidden:true];
    [self.okView setHidden:true];
//    self.alertView.layer.borderColor = [[UIColor colorWithRed:48.0/255.0 green:94.0/255.0 blue:170.0/255.0 alpha:1]CGColor];
    self.btnOK.layer.borderColor = [[UIColor colorWithRed:48.0/255.0 green:94.0/255.0 blue:170.0/255.0 alpha:1]CGColor];
    self.btnExitSuccess.layer.borderColor = [[UIColor colorWithRed:48.0/255.0 green:94.0/255.0 blue:170.0/255.0 alpha:1]CGColor];
    self.btnOKSuccess.layer.borderColor = [[UIColor colorWithRed:48.0/255.0 green:94.0/255.0 blue:170.0/255.0 alpha:1]CGColor];
    [self.txtinvitecode setDelegate:self];
    [self.hideShowView setHidden:true];
    self.alertTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 0,10);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return TRUE;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

-(BOOL)txtEmailValid
{
    
    if ([self.txtinvitecode.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter invitation code" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(IBAction)btngo:(id)sender
{
    if ([self txtEmailValid])
    {
        [self.txtinvitecode resignFirstResponder];
        
        strInviteCode = self.txtinvitecode.text;
        NSLog(@"%@",strInviteCode);
        
        mc=[[ModelClass alloc] init];
        mc.delegate=self;
            
        if ([Validate isConnectedToNetwork])
        {
            
            [mc Invitation_User:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] invite_code:strInviteCode selector:@selector(didgetResponserConfirmTrac:)];
        }
    }
}
-(IBAction)btninfo:(id)sender
{
 
    [self.okExitView setHidden:true];
    [self.okView setHidden:false];
    [self.hideShowView setHidden:false];
    [self.hideShowView setUserInteractionEnabled:false];
    [self.btngo setUserInteractionEnabled:false];

    [self.btnpersonaltrac setUserInteractionEnabled:false];
    [self.btngrouptrac setUserInteractionEnabled:false];
    
    [self.alertView setHidden:false];
    mc=[[ModelClass alloc] init];
    mc.delegate=self;
    
    if ([Validate isConnectedToNetwork])
    {
        [mc Title:@"unique code help" selector:@selector(didgetinfo:)];
    }
    
    
}

- (IBAction)btnAlertOK:(UIButton *)sender
{
    
    [self.okView setHidden:true];
    [self.alertView setHidden:true];
    [self.btnpersonaltrac setUserInteractionEnabled:true];
    [self.btngrouptrac setUserInteractionEnabled:true];
    [self.btngo setUserInteractionEnabled:true];
    
    
}

- (IBAction)btnOKClicked:(UIButton *)sender
{
    mc=[[ModelClass alloc] init];
    mc.delegate=self;
    
    if ([Validate isConnectedToNetwork])
    {
        [mc addsponsoredtrac: [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] invite_code:strInviteCode isflag:true selector: @selector(getconfirmation:)];
    }
    

    [self.alertView setHidden:true];
    [self.btnpersonaltrac setUserInteractionEnabled:true];
    [self.btngrouptrac setUserInteractionEnabled:true];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"dash" forKey:@"title"];
    DELEGATE.tabBarController.selectedIndex=0;
    
    DELEGATE.ischeckadd=YES;
    DELEGATE.isfinal1=NO;
    DELEGATE.isFromReview=NO;
    
    DELEGATE.dic_addPersonaltrac=nil;
    DELEGATE.isNewTrackSelected=NO;
    DELEGATE.contact_participants=nil;
    [DELEGATE.p_emailArray removeAllObjects];
    DELEGATE.dic_edittrac=nil;
    
    for (UIView *view in self.window.subviews) {
        
        if (view.tag == 1001) {
            [view removeFromSuperview];
        }
        
    }
    
    [[DELEGATE.tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor]
                                                         }
                                             forState:UIControlStateNormal];
    [[DELEGATE.tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor]
                                                         }
                                             forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"FireSponseredTrac"
     object:self];

    
    
}

- (IBAction)btnExitClicked:(UIButton *)sender
{
    [self.alertView setHidden:true];
    [self.btnpersonaltrac setUserInteractionEnabled:true];
    [self.btngrouptrac setUserInteractionEnabled:true];
}


-(void)getconfirmation:(NSDictionary*)result
{
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        [self makeToast:[result objectForKey:@"message"]];
    }
    else
    {
        [self makeToast:[result objectForKey:@"message"]];
    }
}

-(void)didgetinfo:(NSDictionary*)result
{
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[[result objectForKey:@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
        NSRange range = (NSRange){0,[newString length]};
        [newString enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            UIFont *replacementFont =  [UIFont fontWithName:@"Roboto-Regular" size:15.0];
            [newString addAttribute:NSFontAttributeName value:replacementFont range:range];
            UIColor *color = [UIColor redColor];
            [newString addAttribute:NSForegroundColorAttributeName value:color range:range];
            
//            NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
//            [newString addAttributes:attrs range:range];
        }];
        
        self.alertTextView.attributedText = attributedString;
        self.alertTextView.font = [UIFont fontWithName:@"Roboto-Regular" size:15];
        self.alertTextView.textColor = [UIColor colorWithRed:48.0/255.0 green:94.0/255.0 blue:170.0/255.0 alpha:1];
    }
    else
    {
    }
}


-(void)didgetResponserConfirmTrac:(NSDictionary*)result
{
    self.txtinvitecode.text = @"";
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        [self.okView setHidden:true];
        [self.okExitView setHidden:false];
        [self.alertView setHidden: false];
        [self.btnpersonaltrac setUserInteractionEnabled:false];
        [self.btngrouptrac setUserInteractionEnabled:false];
        
        NSString *busName = [result objectForKey:@"business_name"];
        self.alertTextView.text = [NSString stringWithFormat:@"Excellent\n\nYou are choosing to create one or more tracs proposed for you by :\n\n%@\n\nOnce you select OK below, they will appear under your 'My Tracs' section.\n\nYou have full control over these these tracs as you would for tracs created by yourself.\n\nThe provider of these tracs will have indicated whether they will be 'following' you ie. be able to view your response to these tracs only. You can check and change this ability within the app.\n\nEnjoy your new tracs!",busName];
        
//        [self makeToast:[result objectForKey:@"message"]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[result objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
//        [self makeToast:[result objectForKey:@"message"]];
    }
}
@end
