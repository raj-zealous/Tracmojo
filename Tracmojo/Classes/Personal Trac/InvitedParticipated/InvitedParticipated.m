//
//  InvitedParticipated.m
//  Tracmojo
//
//  Created by macmini3 on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//
#import "Validate.h"
#import "InvitedParticipated.h"
#import "InvitedCell.h"
#import <AddressBook/AddressBook.h>
#import "SelectedEmailFromContact.h"
#import "ModelClass.h"
#import "HelpViewController.h"
#import "InvitedFollowers.h"


@interface InvitedParticipated ()
{
    UIButton *btn_tag;
    BOOL ischeck;
    int inviteCount;
    int btnIndex;
    int Intstrparticipetedcount;
    NSArray *myarray;
}
@end

@implementation InvitedParticipated

- (void)viewDidLoad {
    
    DELEGATE.isnavigateBack =  false;
    //view_invite.frame=CGRectMake(view_invite.frame.origin.x, view_invite.frame.origin.y, [UIScreen mainScreen].bounds.size.width, view_invite.frame.size.height);
    
//    track_bg.frame =  CGRectMake(0, track_bg.frame.origin.y, self.view.frame.size.width,track_bg.frame.size.height);
//    lbl_nofollower.frame = CGRectMake(0,lbl_nofollower.frame.origin.y,self.view.frame.size.width, lbl_nofollower.frame.size.height);
//    table_invitelist.frame = CGRectMake(0,table_invitelist.frame.origin.y, self.view.frame.size.width,200);
    
     if ([[DELEGATE.dic_edittrac valueForKey:@"is_owner_participant"]isEqualToString:@"y"]|| DELEGATE.istemp9) {
        
        DELEGATE.isOwnerP=YES;
     ischeck=YES;
         //btnCheck.frame=CGRectMake(view_invite.frame.size.width-31, 101, 28, 22);
        [btnCheck setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
     

    // [view_invite addSubview:btnCheck];
     
    }
    else{
        ischeck=NO;
        btnCheck.frame=CGRectMake(view_invite.frame.size.width-31, 101, 21, 22);
        [btnCheck setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
    }
    
    
    if (DELEGATE.isFromReview) {
          [_btnNext setTitle:@"Done" forState:UIControlStateNormal];
    }
    
    scroll_invite.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,460);
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *help_obj=[[HelpViewController alloc]init];
    [self.navigationController pushViewController:help_obj animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if (DELEGATE.isgroup)
{
    NSString  *strparticipetedcount = [DELEGATE.dic_edittrac objectForKey:@"participant_count"];
    inviteCount = [[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];
    Intstrparticipetedcount= [strparticipetedcount intValue];
    int totalcount =  inviteCount - Intstrparticipetedcount;
    NSString* myNewString = [NSString stringWithFormat:@"%d", totalcount];
    lbl_invitecount.text = myNewString;
  
}
else
{
    
    NSString  *strparticipetedcount = [DELEGATE.dic_edittrac objectForKey:@"follower_count"];
    inviteCount = [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
    Intstrparticipetedcount= [strparticipetedcount intValue];
    int totalcount =  inviteCount - Intstrparticipetedcount;
    NSString* myNewString = [NSString stringWithFormat:@"%d", totalcount];
    lbl_invitecount.text = myNewString;
    
}
    
    
    if (inviteCount ==  0)
    {
        _mailViewTopConstant.constant  =  -80;
       // _mailview.frame=CGRectMake(0, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height,self.view.frame.size.width, 108);
        //    _mailview.frame=CGRectMake(0, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height,self.view.frame.size.width, 108);
        
    }
    

       if(DELEGATE.isgroup==NO)
    {
        lbl_nofollower.text=@"No follower found";
        lblO.hidden=YES;
        btnCheck.hidden=YES;
    }
    
    //NSLog(@"%@",DELEGATE.contact_participants);
    
    
    table_invitelist.hidden=YES;
    
    
    lbl_Add.text=@"";
    if (DELEGATE.isgroup) {
        
        
        
        if (DELEGATE.isFromReview){
                if ([[DELEGATE.dic_edittrac objectForKey:@"type"]isEqualToString:@"g"]) {
                txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];
            }
            else{
                txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];//change 1
            }
            
    }
    

        
        
         if (DELEGATE.isFromReview){
              if ([[DELEGATE.dic_edittrac objectForKey:@"type"]isEqualToString:@"g"]) {
             lbl_Add.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_name"]];
              }
         }
         else{
             lbl_Add.text=_str_add;
         }
        
            
        lbl_personal.hidden=YES;
        
        
        
        [_btnNext setTitle:@"Next" forState:UIControlStateNormal];
        if (DELEGATE.isFromReview) {
            
            [_btnNext setTitle:@"Done" forState:UIControlStateNormal];
        }
        if (!DELEGATE.isFromReview) {
            txt_showtitel.text=_str_title;
            

        }
        lbl_invitefollower.text=@"participants invited";
        
        lbl_mostfollower.text=@"invite more participants";
        lbl_title.text=@"add or change participants of a trac";
        
    }
    else{
        
        
        lbl_title.text=@"add or change followers of a trac";
        
        [_btnNext setTitle:@"Done" forState:UIControlStateNormal];
        //lbl_title.text=@"add or change followers of a trac";
        if ([[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]isEqualToString:@"N"])
        {
            txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            txt_showtitel.enabled=YES;
            
        }
        else
        {
            if (DELEGATE.isFromReview) {
                if ([[DELEGATE.dic_edittrac objectForKey:@"type"]isEqualToString:@"g"]) {
                       txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];
                }
                else{
                       txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];
                }
            }
            else{
                txt_showtitel.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            }
            
            txt_showtitel.enabled=NO;
        }
        
        lbl_Add.hidden=YES;
        if (lbl_Add.hidden ==  YES)
        {
            lbl_addHightConstant.constant = - 2;
            [self.view setNeedsUpdateConstraints];
        }
    }
    //NSLog(@"%@",DELEGATE.contact_participants);
    
    if (!([DELEGATE.contact_participants count] == 0))
    {
        int countMail=0;
        //NSLog(@"%@",DELEGATE.p_emailArray);
        for (int i=0; i<[DELEGATE.p_emailArray count]; i++) {
            
            if ([[[DELEGATE.p_emailArray objectAtIndex:i]valueForKey:@"isChecked"] isEqualToString:@"Y"])
            {
                countMail++;
            }
        }
        
        
        //NSLog(@"%@",DELEGATE.contact_participants);
        
        if (DELEGATE.done) {
            [DELEGATE.contact_participants removeAllObjects];
        }
        
        if (DELEGATE.isnavigateBack == true)
        {
            int totalCount = (inviteCount + countMail) - Intstrparticipetedcount;
            lbl_invitecount.text=[NSString stringWithFormat:@"%d",totalCount];
        }
  
    }
    if (DELEGATE.isEdit)
    {
        ////NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Participants"]);

        if(DELEGATE.isgroup)
        {
            if ([[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count] == 0)
            {
                table_invitelist.hidden=YES;
                lbl_nofollower.hidden=NO;
            }
            else
            {
                lbl_nofollower.hidden=YES;
//                _mailview.frame=CGRectMake(_mailview.frame.origin.x, table_invitelist.frame.origin.y+table_invitelist.frame.size.height,self.view.frame.size.width, _mailview.frame.size.height);
                //[scroll_invite addSubview:_mailview];
                table_invitelist.hidden=NO;
                [table_invitelist reloadData];
                
                ////NSLog(@"%f",table_invitelist.frame.size.width);
                
            }
            
        }
        else
        {
            if ([[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count] == 0)
            {
                table_invitelist.hidden=YES;
                lbl_nofollower.hidden=NO;
            }
            else
            {
                lbl_nofollower.hidden=YES;
             //   _mailview.frame=CGRectMake(_mailview.frame.origin.x, table_invitelist.frame.origin.y+table_invitelist.frame.size.height,self.view.frame.size.width, _mailview.frame.size.height);
              //  [scroll_invite addSubview:_mailview];
                table_invitelist.hidden=NO;
                [table_invitelist reloadData];
                
                ////NSLog(@"%f",table_invitelist.frame.size.width);
            }
            
        }
        
        
    }
    if (DELEGATE.isFromReview){
        if ([[DELEGATE.dic_edittrac objectForKey:@"type"]isEqualToString:@"g"]) {
            lbl_Add.hidden=NO;
            lbl_Add.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_name"]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)touchBack:(id)sender
{
    DELEGATE.isyPlus=YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addparti:(NSDictionary*)dic
{
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"Success"])
    {
        DELEGATE.isyPlus=YES;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
}

-(IBAction)touchNext:(id)sender
{
    
    DELEGATE.ischkFollowers=NO;
    NSString *str_msg=@"Done";
    if([str_msg isEqualToString:@"Done"])
    {
        
        if (DELEGATE.isEdit)
        {
            if (DELEGATE.isgroup)
            {
                //  DELEGATE.contact_followers=nil;
                //   DELEGATE.f_emailArray=nil;
                /*     [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_showtitel.text] forKey:@"trac_detail"];
                 ModelClass *mc=[[ModelClass alloc] init];
                 mc.delegate=self;
                 
                 NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
                 NSString *str_as=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"as"]];
                 NSString *str_on=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"on"]];
                 NSString *str_finishdate=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"finisheddate"]];
                 
                 NSString *str_ideaid,*str_ideaDeatil;
                 if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                 {
                 str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                 }
                 else
                 {
                 str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                 }
                 
                 NSMutableArray * arra_email=[[NSMutableArray alloc] init];
                 for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                 {
                 [arra_email addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                 }
                 
                 for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                 {
                 
                 [arra_email addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                 }
                 
                 NSString *str_ratewordid,*str_rate1,*str_rate2,*str_rate3,*str_rate4,*str_rate5;
                 if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate_flag"]] isEqualToString:@"N"])
                 {
                 str_rate1=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate1"]];
                 str_rate2=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate2"]];
                 str_rate3=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate3"]];
                 str_rate4=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate4"]];
                 str_rate5=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate5"]];
                 }
                 else
                 {
                 str_ratewordid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rateword_id"]];
                 }
                 
                 
                 if ([Validate isConnectedToNetwork])
                 {
                 [mc Updategroup:str_userid name:[DELEGATE.groupdic valueForKey:@"groupreference"] gole:[DELEGATE.groupdic valueForKey:@"details"] idea_id:[DELEGATE.groupdic valueForKey:@"type"] rate_word_id:[DELEGATE.groupdic valueForKey:@"rateword"] cust_rate_word1:[DELEGATE.groupdic valueForKey:@"rate1"] cust_rate_word2:[DELEGATE.groupdic valueForKey:@"rate2"] cust_rate_word3:[DELEGATE.groupdic valueForKey:@"rate3"] cust_rate_word4:[DELEGATE.groupdic valueForKey:@"rate4"] cust_rate_word5:[DELEGATE.groupdic valueForKey:@"rate5"] rating_frequency:[DELEGATE.groupdic valueForKey:@"as"] rating_day:[DELEGATE.groupdic valueForKey:@"on"] finish_date:[DELEGATE.groupdic valueForKey:@"finisheddate"] invited_emails:arra_email trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] selector:@selector(responseFromUpdatetracDetail:)];
                 }*/
                
                NSMutableArray * arra_email=[[NSMutableArray alloc] init];
                NSMutableArray * arra_name=[[NSMutableArray alloc] init];
                
                
                    for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                    {
                        
                        [arra_name addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"name"]];
                        [arra_email addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                        
                    }

                
                
               // if (DELEGATE.isFromReview==NO) {
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                {
                    
                    [arra_name addObject:@""];
                    [arra_email addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                }
                    
              //  }

                
                if (DELEGATE.isFromReview==NO) {
                    InvitedFollowers *invited=[[InvitedFollowers alloc]
                                               initWithNibName:@"InvitedFollowers" bundle:nil];
                    
                    
                    
                    //    DELEGATE.contact_followers=nil;
                    
                    [DELEGATE.groupdic setObject:arra_email forKey:@"P_emails"];
                    invited.str_add=lbl_Add.text;
                    invited.str_title=txt_showtitel.text;
                    [self.navigationController pushViewController:invited animated:YES];
                }
                else{
                    ModelClass *mc=[[ModelClass alloc] init];
                    mc.delegate=self;
                    
                    NSString *str_own;
                    
                    if(DELEGATE.isOwnerP == YES){
                      str_own = @"y";
                        
                    }
                    else{
                        str_own = @"n";
                        
                    }
                    
                    [mc AddParticipants:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] emails:arra_name iseowner:str_own names:arra_email selector:@selector(addparti:)];
                    
                    
                }
            }
            else
            {
                ModelClass *mc=[[ModelClass alloc] init];
                mc.delegate=self;
                
                NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
                NSString *str_as=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"as"]];
                NSString *str_on=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"on"]];
                NSString *str_finishdate=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"finisheddate"]];
                
                NSString *str_ideaid,*str_ideaDeatil;
                ////NSLog(@"%@",DELEGATE.dic_addPersonaltrac);
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                {
                    str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                    str_ideaid=@"";
                }
                else
                {
                    str_ideaDeatil=@"";
                    str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                }
                
                
                NSMutableArray * arra_email=[[NSMutableArray alloc] init];
                NSMutableArray * arra_name=[[NSMutableArray alloc] init];
                
                NSLog(@"-p_emailArray-%@",DELEGATE.p_emailArray);
                NSLog(@"-dic_edittrac-%@",DELEGATE.dic_edittrac);
                
                for (int k=0; k<[DELEGATE.p_emailArray count]; k++) {
                    [arra_name addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"name"]];
                    [arra_email addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                }
                
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Followers"]count]; k++)
                {
                    [arra_name addObject:@""];
                    [arra_email addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Followers"] objectAtIndex:k] objectForKey:@"email_id"]];
                }
                
                NSString *str_ratewordid,*str_rate1,*str_rate2,*str_rate3,*str_rate4,*str_rate5;
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate_flag"]] isEqualToString:@"N"])
                {
                    str_rate1=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate1"]];
                    str_rate2=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate2"]];
                    str_rate3=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate3"]];
                    str_rate4=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate4"]];
                    str_rate5=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate5"]];
                    str_ratewordid=@"";
                }
                else
                {
                    str_rate1=@"";
                    str_rate2=@"";
                    str_rate3=@"";
                    str_rate4=@"";
                    str_rate5=@"";
                    str_ratewordid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rateword_id"]];
                }
                
                if ([Validate isConnectedToNetwork])
                {
                    ////NSLog(@"%@",[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]]);
                    
                    if (DELEGATE.isFromReview) {
                        [mc AddFollowers:str_userid trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] emails:arra_email names:arra_name selector:@selector(addfollowers:)];
                        
                    }
                    else{
                        [mc UpdatePersonalTrac_p_userId:str_userid gole:str_ideaDeatil idea_id:str_ideaid rate_word_id:str_ratewordid cust_rate_word1:str_rate1 cust_rate_word2:str_rate2 cust_rate_word3:str_rate3 cust_rate_word4:str_rate4 cust_rate_word5:str_rate5 rating_frequency:str_as rating_day:str_on finish_date:str_finishdate invited_emails:arra_email trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] selector:@selector(responseFromUpdatetracDetail:)];
                        

                    }
                    
                }
            }
            
        }
        else
        {
            if (DELEGATE.isgroup)
            {
                
                /*   ModelClass *mc=[[ModelClass alloc] init];
                 mc.delegate=self;
                 
                 NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
                 NSString *str_as=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"as"]];
                 NSString *str_on=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"on"]];
                 NSString *str_finishdate=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"finisheddate"]];
                 
                 NSString *str_ideaid,*str_ideaDeatil;
                 if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                 {
                 str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                 }
                 else
                 {
                 str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                 }
                 
                 NSMutableArray * arra_email=[[NSMutableArray alloc] init];
                 for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                 {
                 [arra_email addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                 }
                 
                 for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                 {
                 
                 [arra_email addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                 }
                 
                 NSString *str_ratewordid,*str_rate1,*str_rate2,*str_rate3,*str_rate4,*str_rate5;
                 if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate_flag"]] isEqualToString:@"N"])
                 {
                 str_rate1=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate1"]];
                 str_rate2=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate2"]];
                 str_rate3=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate3"]];
                 str_rate4=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate4"]];
                 str_rate5=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate5"]];
                 }
                 else
                 {
                 str_ratewordid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rateword_id"]];
                 }
                 
                 if ([Validate isConnectedToNetwork])
                 {
                 [mc addgroup:str_userid name:[DELEGATE.groupdic valueForKey:@"groupreference"] gole:[DELEGATE.groupdic valueForKey:@"details"] idea_id:[DELEGATE.groupdic valueForKey:@"type"] rate_word_id:[DELEGATE.groupdic valueForKey:@"rateword"] cust_rate_word1:[DELEGATE.groupdic valueForKey:@"rate1"] cust_rate_word2:[DELEGATE.groupdic valueForKey:@"rate2"] cust_rate_word3:[DELEGATE.groupdic valueForKey:@"rate3"] cust_rate_word4:[DELEGATE.groupdic valueForKey:@"rate4"] cust_rate_word5:[DELEGATE.groupdic valueForKey:@"rate5"] rating_frequency:[DELEGATE.groupdic valueForKey:@"as"] rating_day:[DELEGATE.groupdic valueForKey:@"on"] finish_date:[DELEGATE.groupdic valueForKey:@"finisheddate"] invited_emails:arra_email selector:@selector(responseFromAddtracDetail:)];
                 }
                 */
                //DELEGATE.contact_followers=nil;
                //    DELEGATE.f_emailArray=nil;
                InvitedFollowers *invited=[[InvitedFollowers alloc] initWithNibName:@"InvitedFollowers" bundle:nil];
                invited.str_add=lbl_Add.text;
                invited.str_title=txt_showtitel.text;
                [self.navigationController pushViewController:invited animated:YES];
                
            }
            else
            {
                ModelClass *mc=[[ModelClass alloc] init];
                mc.delegate=self;
                
                NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
                NSString *str_as=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"as"]];
                NSString *str_on=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"on"]];
                NSString *str_finishdate=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"finisheddate"]];
                
                
                NSLog(@"%@",DELEGATE.dic_addPersonaltrac);
                
                
                NSString *str_ideaid,*str_ideaDeatil;
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                {
                    
                    str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                    str_ideaid=@"";
                }
                else
                {
                    str_ideaDeatil=@"";
                    str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                }
                
                
                NSMutableArray * arra_name=[[NSMutableArray alloc] init];
                NSMutableArray * arra_email=[[NSMutableArray alloc] init];
                
                
                for (int k=0; k<[DELEGATE.p_emailArray count]; k++) {
                    [arra_name addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"name"]];
                    [arra_email addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                }
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                {
                    [arra_name addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"name"]];

                    
                    [arra_email addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                }
                
                NSString *str_ratewordid,*str_rate1,*str_rate2,*str_rate3,*str_rate4,*str_rate5;
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate_flag"]] isEqualToString:@"N"])
                {
                    str_rate1=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate1"]];
                    str_rate2=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate2"]];
                    str_rate3=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate3"]];
                    str_rate4=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate4"]];
                    str_rate5=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rate5"]];
                    str_ratewordid=@"";
                }
                else
                {
                    str_rate1=@"";
                    str_rate2=@"";
                    str_rate3=@"";
                    str_rate4=@"";
                    str_rate5=@"";
                    str_ratewordid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"rateword_id"]];
                }
                
                if ([Validate isConnectedToNetwork])
                {
                    [mc addPersonalTrac_p_userId:str_userid gole:str_ideaDeatil idea_id:str_ideaid rate_word_id:str_ratewordid cust_rate_word1:str_rate1 cust_rate_word2:str_rate2 cust_rate_word3:str_rate3 cust_rate_word4:str_rate4 cust_rate_word5:str_rate5 rating_frequency:str_as rating_day:str_on finish_date:str_finishdate invited_emails:arra_email invited_names:arra_name selector:@selector(responseFromAddtracDetail:)];
                }
            }
        }
    }
    else
    {
        UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:str_msg delegate:str_msg cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert_msg show];
    }
}


-(void)addfollowers:(NSDictionary*)dic
{
    
    
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"Success"])
{
        DELEGATE.isyPlus=YES;
       [self.navigationController popViewControllerAnimated:YES];
    
}
else
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

    
}

-(void)responseFromUpdatetracDetail:(NSDictionary*)dic
{
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"Success"])
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=109;
        [alert show];
        
    }
    else
    {
       // UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
      //  [alert show];
        
        
    }
    
}

-(void)responseFromAddtracDetail:(NSDictionary*)dic
{
    
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"Success"])
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=108;
        [alert show];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 109)
    {
        DELEGATE.isNewTrackSelected=NO;
        [DELEGATE.p_emailArray removeAllObjects];
        DELEGATE.dic_edittrac=nil;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
        DELEGATE.tabBarController.selectedIndex = 3;

    }
    
   
    else if (alertView.tag == 108)
    {
        DELEGATE.dic_addPersonaltrac=nil;
        DELEGATE.isNewTrackSelected=NO;
        DELEGATE.contact_participants=nil;
        [DELEGATE.p_emailArray removeAllObjects];
        DELEGATE.dic_edittrac=nil;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
        DELEGATE.tabBarController.selectedIndex= 0;

    }
    if (alertView.tag == 1011)
    {
        
        if (buttonIndex == 0)
        {
            
            
            if (DELEGATE.isgroup)
            {
                
                NSMutableDictionary *temp_dict  = [[NSMutableDictionary alloc] init];
                temp_dict = [DELEGATE.dic_edittrac mutableCopy];
                NSMutableArray *temp_array=[[NSMutableArray alloc] init];
                temp_array = [[temp_dict objectForKey:@"Participants"] mutableCopy];
              
                if (DELEGATE.isFromReview) {
                  
                    
                }
                
                [temp_array removeObjectAtIndex:btnIndex];
                
                
                
                [temp_dict setObject:temp_array forKey:@"Participants"];
                
                
                DELEGATE.dic_edittrac = temp_dict;
                
                if ([[DELEGATE.dic_edittrac objectForKey:@"Participants"] count] == 0 )
                {
                    lbl_nofollower.hidden=NO;
                    table_invitelist.hidden=YES;
                    _mailview.frame=CGRectMake(_mailview.frame.origin.x, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height,self.view.frame.size.width, _mailview.frame.size.height);
                    [scroll_invite addSubview:_mailview];
                }
                else
                {
                    table_invitelist.hidden=NO;
                    lbl_nofollower.hidden=YES;
                    [table_invitelist reloadData];
                }
                
            }
            else
            {
                
                NSMutableDictionary *temp_dict  = [[NSMutableDictionary alloc] init];
                temp_dict = [DELEGATE.dic_edittrac mutableCopy];
                
                NSMutableArray *temp_array=[[NSMutableArray alloc] init];
                temp_array = [[temp_dict objectForKey:@"Followers"] mutableCopy];
                [temp_array removeObjectAtIndex:btnIndex];
                [temp_dict setObject:temp_array forKey:@"Followers"];
                
                DELEGATE.dic_edittrac = temp_dict;
                
                if([[DELEGATE.dic_edittrac objectForKey:@"Followers"] count] == 0 )
                {
                    lbl_nofollower.hidden=NO;
                    table_invitelist.hidden=YES;
                    _mailview.frame=CGRectMake(_mailview.frame.origin.x, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height,self.view.frame.size.width, _mailview.frame.size.height);
                    [scroll_invite addSubview:_mailview];
                }
                else
                {
                    table_invitelist.hidden=NO;
                    lbl_nofollower.hidden=YES;
                    [table_invitelist reloadData];
                }
                
            }
        }
        else if (buttonIndex == 1) {
            
        }
        
    }
    
    
}

-(IBAction)touchInvitedviaEmail:(id)sender
{
    SelectedEmailFromContact *got_email=[[SelectedEmailFromContact alloc] initWithNibName:@"SelectedEmailFromContact" bundle:nil];
    DELEGATE.ischkFollowers=YES;
    [self.navigationController pushViewController:got_email animated:YES];
    
    
    
}


#pragma  tableview method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // ////NSLog(@"%@",DELEGATE.dic_edittrac);
    ////NSLog(@"%@",DELEGATE.dic_edittrac );
    if (DELEGATE.isgroup)
    {
        ////NSLog(@"%@",DELEGATE.dic_edittrac );
        return [[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];
    }
    else
    {
        return [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
    }
    //    ////NSLog(@"%@",[DELEGATE.dic_edittrac objectForKey:@"Participants"] );
    //    return [[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InvitedCell";
    InvitedCell *cell = (InvitedCell *) [table_invitelist dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *arrNib=[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell= (InvitedCell *)[arrNib objectAtIndex:0];
        //cell.backgroundColor =[UIColor clearColor];
        
    }
    tableView.hidden=NO;
    lbl_nofollower.hidden=YES;
    if (DELEGATE.isgroup)
    {
        if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"d"])
        {
            cell.img_responde.image=[UIImage imageNamed:@"decline.png"];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Declined"];
            NSLog(@"Data is :%@",[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row]);

            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
            
        }
        else if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"a"])
        {
             
            cell.img_responde.image=[UIImage imageNamed:@"accpet.png"];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Accepted"];
            NSLog(@"Data is :%@",[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row]);
            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"name"]];
        }
        else
        {
            cell.img_responde.image=[UIImage imageNamed:@"noresponse.png"];
            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"No response"];
        }
        
    }
    else
    {
        if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"d"])
        {
            cell.img_responde.image=[UIImage imageNamed:@"decline.png"];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Declined"];
            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
            
        }
        else if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"a"])
        {
            
            cell.img_responde.image=[UIImage imageNamed:@"accpet.png"];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Accepted"];
            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
        }
        else
        {
            cell.img_responde.image=[UIImage imageNamed:@"noresponse.png"];
            cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
            cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"No response"];
        }
        
    }
    
    cell.btn_delete.tag=indexPath.row;
    if([UIScreen mainScreen].applicationFrame.size.height <= 480)
    {
        cell.btn_delete.frame=CGRectMake([UIScreen mainScreen].applicationFrame.size.width-40, 15, 22, 22);
    }
    else if ([UIScreen mainScreen].applicationFrame.size.height <= 568)
    {
        cell.btn_delete.frame=CGRectMake([UIScreen mainScreen].applicationFrame.size.width-40, 15, 22, 22);
    }
    else if ([UIScreen mainScreen].applicationFrame.size.height <= 667)
    {
        cell.btn_delete.frame=CGRectMake([UIScreen mainScreen].applicationFrame.size.width-100, 15, 22, 22);
    }
    else if ([UIScreen mainScreen].applicationFrame.size.height <= 736)
    {
        cell.btn_delete.frame=CGRectMake([UIScreen mainScreen].applicationFrame.size.width-140, 15, 22, 22);
    }
    
    [cell.btn_delete addTarget:self action:@selector(touch_on_delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(IBAction)touch_on_delete:(UIButton*)sender
{
    // btn_tag=(UIButton*)sender;
    
    btnIndex = (int)sender.tag;
    
    if (DELEGATE.isEdit&&!DELEGATE.isgroup)
    {
        UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to delete this follower?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert_msg.tag=1011;
        [alert_msg show];
        
    }
    else{
        UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to delete this participant?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert_msg.tag=1011;
        [alert_msg show];
        
    }
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma Address contact get


-(IBAction)touch_help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *got_help=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [self.navigationController pushViewController:got_help animated:YES];
}


-(IBAction)btncheck:(id)sender
{
    if (ischeck) {
        ischeck=NO;
        DELEGATE.isOwnerP=NO;
       // btnCheck.frame=CGRectMake(view_invite.frame.size.width-31, 101, 21, 22);
        
        [btnCheck setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
        
    }
    else{
        ischeck=YES;
        DELEGATE.isOwnerP=YES;
       // btnCheck.frame=CGRectMake(view_invite.frame.size.width-31, 101, 28, 22);
        [btnCheck setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
        
    }
    
}




@end
