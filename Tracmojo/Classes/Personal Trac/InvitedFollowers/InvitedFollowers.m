    //
//  InvitedParticipated.m
//  Tracmojo
//
//  Created by macmini3 on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//
#import "Validate.h"
#import "InvitedFollowers.h"
#import "InvitedCell.h"
#import <AddressBook/AddressBook.h>
#import "SelectedEmailFromContact.h"
#import "ModelClass.h"
#import "HelpViewController.h"


@interface InvitedFollowers ()
{
    UIButton *btn_tag;
    int btnIndex;
    int inviteFollowerCount;
    int Intstrparticipetedcount;

}
@end

@implementation InvitedFollowers

- (void)viewDidLoad {
 scroll_invite.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,460);
    DELEGATE.isnavigateBack = false;
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
        if (DELEGATE.ischkFollowers)
        {

            
            
            NSString  *strparticipetedcount = [DELEGATE.dic_edittrac objectForKey:@"participant_count"];
            
            inviteFollowerCount = [[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];
            Intstrparticipetedcount= [strparticipetedcount intValue];
            int totalcount =  inviteFollowerCount - Intstrparticipetedcount;
            NSString* myNewString = [NSString stringWithFormat:@"%d", totalcount];
            lbl_invitecount.text = myNewString;
            
            

        }
        else
        {

            NSString  *strparticipetedcount = [DELEGATE.dic_edittrac objectForKey:@"follower_count"];
            inviteFollowerCount = [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
            Intstrparticipetedcount= [strparticipetedcount intValue];
            int totalcount =  inviteFollowerCount - Intstrparticipetedcount;
            NSString* myNewString = [NSString stringWithFormat:@"%d", totalcount];
            lbl_invitecount.text = myNewString;
        }
    }
    else{
        NSString  *strparticipetedcount = [DELEGATE.dic_edittrac objectForKey:@"follower_count"];
        inviteFollowerCount = [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
        Intstrparticipetedcount= [strparticipetedcount intValue];
        int totalcount =  inviteFollowerCount - Intstrparticipetedcount;
        NSString* myNewString = [NSString stringWithFormat:@"%d", totalcount];
        lbl_invitecount.text = myNewString;
    }
    
    
    table_invitelist.hidden=YES;
    _mailview.frame=CGRectMake(0, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height,self.view.frame.size.width, 108);
    
    
    lbl_Add.text=@"";
    if (DELEGATE.isgroup)
    {
        lbl_personal.hidden=YES;
        lbl_Add.text=_str_add;
        txt_showtitel.text=_str_title;
//        lbl_invitefollower.text=@"participants invited";
//        lbl_mostfollower.text=@"invite most participants";
        lbl_title.text=@"add or change followers of a trac";
    }
    
//    NSLog(@"%@",DELEGATE.p_emailArray);
//    if (DELEGATE.isFromReview) {
//        
//        int countMail=0;
//        for (int i=0; i<[DELEGATE.p_emailArray count]; i++) {
//            
//            if ([[[DELEGATE.p_emailArray objectAtIndex:i]valueForKey:@"isChecked"] isEqualToString:@"Y"])
//            {
//                countMail++;
//            }
//        }
//        lbl_invitecount.text=[NSString stringWithFormat:@"%d",countMail];
//        
//    }
    
    
    if (!([DELEGATE.contact_followers count]==0))
    {
        int countMail=0;
        for (int i=0; i<[DELEGATE.f_emailArray count]; i++) {

            if ([[[DELEGATE.f_emailArray objectAtIndex:i]valueForKey:@"isChecked"] isEqualToString:@"Y"])
            {
                countMail++;
            }
        }
        

        
        if (DELEGATE.isnavigateBack == true)
        {
            int totalCount = (inviteFollowerCount + countMail) - Intstrparticipetedcount;
            lbl_invitecount.text=[NSString stringWithFormat:@"%d",totalCount];
            countMail= 0;
        }
    }
    if (DELEGATE.isEdit)
    {
        ////NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Followers"]);
        
        
        if(DELEGATE.isgroup)
        {
            if ([[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count] == 0)
            {
                table_invitelist.hidden=YES;
                lbl_nofollower.hidden=NO;
            }
            else
            {
                lbl_nofollower.hidden=YES;
                _mailview.frame=CGRectMake(_mailview.frame.origin.x, table_invitelist.frame.origin.y+table_invitelist.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, _mailview.frame.size.height);
                [scroll_invite addSubview:_mailview];
                table_invitelist.hidden=NO;
                [table_invitelist reloadData];
                
               // ////NSLog(@"%f",table_invitelist.frame.size.width);
            }

        }
        else
        {
//            if ([[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count] == 0)
//            {
//                table_invitelist.hidden=YES;
//                lbl_nofollower.hidden=NO;
//            }
//            else
//            {
//                lbl_nofollower.hidden=YES;
//                _mailview.frame=CGRectMake(_mailview.frame.origin.x, table_invitelist.frame.origin.y+table_invitelist.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, _mailview.frame.size.height);
//                [scroll_invite addSubview:_mailview];
//                table_invitelist.hidden=NO;
//                [table_invitelist reloadData];
//                
//                ////NSLog(@"%f",table_invitelist.frame.size.width);
//            }

        }
        
        
    }
    
    ////NSLog(@"%@",DELEGATE.dic_edittrac);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)touchBack:(id)sender
{
    
     DELEGATE.ischkFollowers=YES;
       [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)touchNext:(id)sender
{
    NSString *str_msg=@"Done";

    if([str_msg isEqualToString:@"Done"])
    {
        
        if (DELEGATE.isEdit)
        {
            if (DELEGATE.isgroup)
            {
                DELEGATE.ischkFollowers=NO;//changed
                
                 [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_showtitel.text] forKey:@"trac_detail"];
                ModelClass *mc=[[ModelClass alloc] init];
                mc.delegate=self;
                
                NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
          
                
                NSString *str_ideaid,*str_ideaDeatil;
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                {
                    str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                }
                else
                {
                    str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                }
                
                NSMutableArray * arra_email_p=[[NSMutableArray alloc] init];
                NSMutableArray * arra_email_f=[[NSMutableArray alloc] init];
                
                NSMutableArray * arra_email_pName=[[NSMutableArray alloc] init];
                NSMutableArray * arra_email_fName=[[NSMutableArray alloc] init];
                
                
                
                for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                {
                    [arra_email_p addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                    
                    [arra_email_pName addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"name"]];
                    
                }
                
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                {
                    
                    
                       [arra_email_pName addObject:@""];
                    
                    [arra_email_p addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                }
                
                
                
                for (int k=0; k<[DELEGATE.f_emailArray count]; k++)
                {
                    
                    
                     [arra_email_fName addObject:[[DELEGATE.f_emailArray objectAtIndex:k] objectForKey:@"name"]];
                    
                    [arra_email_f addObject:[[DELEGATE.f_emailArray objectAtIndex:k] objectForKey:@"email"]];
                }
                
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Followers"]count]; k++)
                {
                    [arra_email_fName addObject:@""];
                    [arra_email_f addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Followers"] objectAtIndex:k] objectForKey:@"email_id"]];
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
                    
                    if (DELEGATE.isFromReview) {
                        
                        
                     //   [mc AddParticipants:str_userid trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] emails:arra_email_p names:arra_email_pName selector:@selector(addparti:)];
                        
                        
                        
                    }
                    else{

                        
                    [mc Updategroup:str_userid name:[DELEGATE.groupdic valueForKey:@"groupreference"] gole:[DELEGATE.groupdic valueForKey:@"details"] idea_id:[DELEGATE.groupdic valueForKey:@"type"] rate_word_id:[DELEGATE.groupdic valueForKey:@"rateword"] cust_rate_word1:[DELEGATE.groupdic valueForKey:@"rate1"] cust_rate_word2:[DELEGATE.groupdic valueForKey:@"rate2"] cust_rate_word3:[DELEGATE.groupdic valueForKey:@"rate3"] cust_rate_word4:[DELEGATE.groupdic valueForKey:@"rate4"] cust_rate_word5:[DELEGATE.groupdic valueForKey:@"rate5"] rating_frequency:[DELEGATE.groupdic valueForKey:@"as"] rating_day:[DELEGATE.groupdic valueForKey:@"on"] finish_date:[DELEGATE.groupdic valueForKey:@"finisheddate"] invited_emails_participants:arra_email_p invited_emails_followers:arra_email_f trac_id:[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"id"]] selector:@selector(responseFromUpdatetracDetail:)];
                        
                    }
                    
                 
                }
                
                
            }
        }
        else
        {
            if (DELEGATE.isgroup)
            {
                
                ModelClass *mc=[[ModelClass alloc] init];
                mc.delegate=self;
                
                NSString *str_userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];

                
                NSString *str_ideaid,*str_ideaDeatil;
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]] isEqualToString:@"N"])
                {
                    str_ideaid=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_id"]];
                }
                else
                {
                    str_ideaDeatil=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                }
                
                
                
                
                
                NSMutableArray * arra_email_pName=[[NSMutableArray alloc] init];
                NSMutableArray * arra_email_fName=[[NSMutableArray alloc] init];
                
                NSMutableArray * arra_email_p=[[NSMutableArray alloc] init];
                NSMutableArray * arra_email_f=[[NSMutableArray alloc] init];
                
                for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                {
                    [arra_email_pName addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"name"]];

                    
                    [arra_email_p addObject:[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"]];
                }
                
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Participants"]count]; k++)
                {
                    
                    
                     [arra_email_pName addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"name"]];
                    
                    [arra_email_p addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Participants"] objectAtIndex:k] objectForKey:@"email_id"]];
                }
                
                
                
                for (int k=0; k<[DELEGATE.f_emailArray count]; k++)
                {
                    
                    
                    [arra_email_fName addObject:[[DELEGATE.f_emailArray objectAtIndex:k] objectForKey:@"name"]];

                    
                    [arra_email_f addObject:[[DELEGATE.f_emailArray objectAtIndex:k] objectForKey:@"email"]];
                }
                
                for (int k=0; k<[[DELEGATE.dic_edittrac objectForKey:@"Followers"]count]; k++)
                {
                    
                    
                    [arra_email_fName addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Followers"] objectAtIndex:k] objectForKey:@"name"]];
                    
                    [arra_email_f addObject:[[[DELEGATE.dic_edittrac objectForKey:@"Followers"] objectAtIndex:k] objectForKey:@"email_id"]];
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
                    [mc addgroup:str_userid name:[DELEGATE.groupdic valueForKey:@"groupreference"] gole:[DELEGATE.groupdic valueForKey:@"details"] idea_id:[DELEGATE.groupdic valueForKey:@"type"] rate_word_id:[DELEGATE.groupdic valueForKey:@"rateword"] cust_rate_word1:[DELEGATE.groupdic valueForKey:@"rate1"] cust_rate_word2:[DELEGATE.groupdic valueForKey:@"rate2"] cust_rate_word3:[DELEGATE.groupdic valueForKey:@"rate3"] cust_rate_word4:[DELEGATE.groupdic valueForKey:@"rate4"] cust_rate_word5:[DELEGATE.groupdic valueForKey:@"rate5"] rating_frequency:[DELEGATE.groupdic valueForKey:@"as"] rating_day:[DELEGATE.groupdic valueForKey:@"on"] finish_date:[DELEGATE.groupdic valueForKey:@"finisheddate"] invited_emails_participants:arra_email_p invited_emails_followers:arra_email_f invited_namesf:arra_email_fName invited_namesp:arra_email_pName selector:@selector(responseFromAddtracDetail:)];
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
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
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
        [DELEGATE.f_emailArray removeAllObjects];

        DELEGATE.dic_edittrac=nil;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
        DELEGATE.tabBarController.selectedIndex = 3;

    }
    else if (alertView.tag == 108)
    {
        DELEGATE.dic_addPersonaltrac=nil;
        DELEGATE.isNewTrackSelected=NO;
        [DELEGATE.f_emailArray removeAllObjects];
        DELEGATE.dic_edittrac=nil;
        DELEGATE.tabBarController.selectedIndex=0;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];

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
                
                temp_array = [[temp_dict objectForKey:@"Followers"] mutableCopy];
                
                [temp_array removeObjectAtIndex:btnIndex];
                
                
                
                [temp_dict setObject:temp_array forKey:@"Followers"];
                
                
                DELEGATE.dic_edittrac = temp_dict;
                
                if ([[DELEGATE.dic_edittrac objectForKey:@"Followers"] count] == 0 )
                {
                    lbl_nofollower.hidden=NO;
                    table_invitelist.hidden=YES;
                    _mailview.frame=CGRectMake(_mailview.frame.origin.x, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, _mailview.frame.size.height);
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
                
                if ([[DELEGATE.dic_edittrac objectForKey:@"Followers"] count] == 0 )
                {
                    lbl_nofollower.hidden=NO;
                    table_invitelist.hidden=YES;
                    _mailview.frame=CGRectMake(_mailview.frame.origin.x, lbl_nofollower.frame.origin.y + lbl_nofollower.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, _mailview.frame.size.height);
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
    
    
    if (!DELEGATE.isFromReview) {
         DELEGATE.ischkFollowers=NO;
    }
    
    [self.navigationController pushViewController:got_email animated:YES];
}

#pragma  tableview method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // ////NSLog(@"%@",DELEGATE.dic_edittrac);
    //NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Followers"] );
     if (DELEGATE.isgroup)
     {
         if (DELEGATE.ischkFollowers)
         {
             return [[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];
         }
         else
         {
             return [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
         }
     }
     else{
         ////NSLog(@"%@",[DELEGATE.dic_edittrac objectForKey:@"Followers"] );
         return [[DELEGATE.dic_edittrac  objectForKey:@"Followers"] count];
     }

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
        
        
        ///
        
        
        
        
        if (DELEGATE.ischkFollowers)
        {
            
            
            //NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Followers"]);
            
            if ([[DELEGATE.dic_edittrac  objectForKey:@"Participants"]count]>0) {
                if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"d"])
                {
                    cell.img_responde.image=[UIImage imageNamed:@"decline.png"];
                    cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Declined"];
                    cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"request_status"]] isEqualToString:@"a"])
                {
                    
                    
                    cell.img_responde.image=[UIImage imageNamed:@"accpet.png"];
                    cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"Accepted"];
                    cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
                }
                else
                {
                    cell.img_responde.image=[UIImage imageNamed:@"noresponse.png"];
                    cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]objectAtIndex:indexPath.row] objectForKey:@"email_id"]];
                    cell.lbl_resonsedtype.text=[NSString stringWithFormat:@"No response"];
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
                
                
                
            }
            
            else{
                //NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Followers"]);
                
                if ([[DELEGATE.dic_edittrac  objectForKey:@"Followers"]count]>0) {
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
                    
                    
                }
                
                
            }
            
            
        }
        else{
            if ([[DELEGATE.dic_edittrac  objectForKey:@"Followers"]count]>0) {
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
                
                
            }
        }
        
        
        //////
        
        //NSLog(@"%@",[DELEGATE.dic_edittrac  objectForKey:@"Followers"]);
        


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


    }
    
       return cell;
}

-(IBAction)touch_on_delete:(UIButton*)sender
{
   // btn_tag=(UIButton*)sender;
    
    btnIndex = (int)sender.tag;
    
    UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to delete this Follower?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    alert_msg.tag=1011;
    [alert_msg show];
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

@end
