//this module is managed by Krishna

#import "SBJson.h"
#import "Validate.h"
#import "HelpViewController.h"
#import "tracreview.h"
#import "ModelClass.h"
#import "CommentsViewController.h"
#import "HelpViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SelectedEmailFromContact.h"
#import "tracmojo-Swift.h"

#import "ModelClass.h"
#import <MessageUI/MessageUI.h>
#import "InvitedParticipated.h"
#import "UIView+Toast.h"
#import "InvitedFollowers.h"

#import <Social/Social.h>
#import <ACCOUNTS/ACAccount.h>

@interface tracreview ()<ChartViewDelegate,IChartAxisValueFormatter>
{
    BOOL is_checkInvite;
    NSString *strType;
    int month_staring_timestamp;
    BOOL isTheForthmont;
    NSMutableArray *dataSets;
    NSMutableArray *arrMonth;
    NSMutableArray *arrIndexPercent;
    NSMutableArray *arrIndexDash;
    NSString *Mobilenumber;
    __weak IBOutlet CombinedChartView *chartView;//mon's library

    NSMutableArray *xVals;

}
@end

@implementation tracreview
{
    
    NSMutableArray * arraydatas,*displayarray,*patricipantsArray,*percentagerates;//needed array
    NSMutableArray *patriDisplayArray;
    NSMutableArray *arrTheForthMont;
    NSMutableArray *dataSource;
    NSDictionary *resultDict;
    
    int ITEM_COUNT;//x values
    NSString *type;
    UIToolbar *mytoolbar2;
    UIImageView *dot;//graph image
}


- (void)slideToRightWithGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    float y=0;
    float height=0.0;
    
    for(UIView *element in graph_view.subviews)
    {
        if ([element isKindOfClass:[UIImageView class]]) //check if the object is a UIImageView
        {
            if (element.tag==888) {
                
                y=element.superview.frame.origin.y;
                height=element.frame.size.height;
            }
        }
    }
    
    CGPoint p = [gesture locationInView:scroll];
    //this is for: from graph swipe is hidden other than graph swipe need to work,so i find point and check if it in graph or not !
    
    if (CGRectContainsPoint(CGRectMake(0,y+50,[UIScreen mainScreen].bounds.size.width,height+5), p)) {
        //// //// //// ////NSLog(@"%@",temp );(@"it's inside");
    } else {
        [UIView animateWithDuration:0.9
                              delay:0.9
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self.navigationController popViewControllerAnimated:YES];                     }
                         completion:^(BOOL finished){}];
        
    }
    
}

//database query for offiledata
-(void)selectSelectedTrac
{
    [DELEGATE openDatabase];
    sqlite3_stmt *selectStatement;
    NSString* sql;
    
    
    NSLog(@"Value of track. = %@", DELEGATE.isTrac);

    if ([DELEGATE.isTrac isEqualToString:@"P"])
    {
        sql = [NSString stringWithFormat:@"select trac_id,trac_type,trac_data from tracmojo where trac_id=%@ and trac_type='%@'",self.trac_id,@"p"];
    }
    
    else if ([DELEGATE.isTrac isEqualToString:@"F"])
    {
        sql = [NSString stringWithFormat:@"select trac_id,trac_type,trac_data from tracmojo where trac_id=%@ and trac_type='%@'",self.trac_id,@"f"];
    }
    else
    {
        sql = [NSString stringWithFormat:@"select trac_id,trac_type,trac_data from tracmojo where trac_id=%@ and trac_type='%@'",self.trac_id,@"g"];
    }
    
    if (sqlite3_prepare_v2(DELEGATE.database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(selectStatement)==SQLITE_ROW)
        {
            NSString *get_filename = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)];
            
            self.trac_offline_dic=[get_filename JSONValue];
            sqlite3_finalize(selectStatement);
        }
    }
}
    NSString *get_btnText;

- (void)viewDidLoad {
    
    lbl_badge.frame=CGRectMake(lblViewAddcomments.frame.origin.x+lblViewAddcomments.frame.size.width + 10, lbl_badge.frame.origin.y, lbl_badge.frame.size.width, lbl_badge.frame.size.height);
    
    badgeimag.frame=CGRectMake(lbl_badge.frame.origin.x-1, badgeimag.frame.origin.y, badgeimag.frame.size.width, badgeimag.frame.size.height);
    

    DELEGATE.contact_followers=[[NSMutableArray alloc] init];
    
    DELEGATE.contact_participants=[[NSMutableArray alloc] init];
    
    addF.hidden=YES;
    addP.hidden=YES;
    

    

    //corner radius for buttons in alert
    btn_Message.layer.masksToBounds=YES;
    btn_Message.layer.cornerRadius=3.0;
    
    btn_cancel.layer.masksToBounds=YES;
    btn_cancel.layer.cornerRadius=3.0;
    
    scroll.tag=10;
    scroll_popup.tag=90;
    
    arrMonth = [[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    patriDisplayArray=[[NSMutableArray alloc]init];
    lbl_dates.text=[[NSString stringWithFormat:@"%@",[NSDate date]]substringToIndex:10];
    
    lbl_type.text=@"";
   
    UISwipeGestureRecognizer *swipeRightBlack = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightBlack.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightBlack];
    
    //  graph_view.backgroundColor=[UIColor grayColor];
    
    dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,5,[UIScreen mainScreen].bounds.size.width,212 )];
    dot.tag=888;
    dot.image=[UIImage imageNamed:@"graph.png"];
    [graph_view addSubview:dot];
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:TWITTER_CONSUMER_KEY   andSecret:TWITTER_SECRET_KEY];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    
    if (DELEGATE.isAvaiable) {
        if ([Validate isConnectedToNetwork]) {
            [mc GettracDetail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:self.trac_id selector:@selector(didgetResponserSelectedTrac:)];
        }
    }
    else
    {
        
        self.view.hidden=NO;
        
        [self selectSelectedTrac];

        if([DELEGATE.isTrac isEqualToString:@"F"]) {
            
            lbl_trac_to_date.hidden=YES;
            lbltractodate.hidden=YES;
            lbl_next.hidden=YES;
            
            lblnext.hidden=YES;
            lbl_communicate.frame=CGRectMake(lbl_communicate.frame.origin.x, lbl_communicate.frame.origin.y-62, lbl_communicate.frame.size.width,  lbl_communicate.frame.size.height);
            btn_notification.frame=CGRectMake(btn_notification.frame.origin.x, btn_notification.frame.origin.y-62, btn_notification.frame.size.width,  btn_notification.frame.size.height);
            btnmcal.frame=CGRectMake(btnmcal.frame.origin.x, btn_notification.frame.origin.y-62, btnmcal.frame.size.width,  btnmcal.frame.size.height);
            
            btn_email.frame=CGRectMake(btn_email.frame.origin.x, btn_email.frame.origin.y-62, btn_email.frame.size.width,  btn_email.frame.size.height);
            
            
            scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, scroll.contentSize.height-70);
            
            
          

            
        }
        
        
        if ([DELEGATE.isTrac isEqualToString:@"P"]||[DELEGATE.isTrac isEqualToString:@"F"])
        {
            view_gole_p.hidden=NO;
            view_gole_g.hidden=YES;
            // btn_comment.hidden=YES;
            // //// //// ////NSLog(@"%@",temp );(@"%@",self.trac_offline_dic);

            if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"] isEqualToString:@""]) {
                //// //// //// ////NSLog(@"%@",temp );(@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"idea_id_name"]);
                
                
                 NSString *value = [NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"idea_id_name"]];
                
                lbl_gole_p.text= [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
            }
            else
            {
                
                
                float height =  ceilf([self getSize:[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"]]]);
                if(btnBusinessName.hidden)
                {
                    btnBusnessNameHightConst.constant =  2;
                    self.view.needsUpdateConstraints;
                   // lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, lbl_gole_p.frame.origin.y + 2, [UIScreen mainScreen].bounds.size.width-8, height);

                }
                else
                {
                    //lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, lbl_gole_p.frame.origin.y + 10, [UIScreen mainScreen].bounds.size.width-8, height);

                }
                //previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height);
                
                
                
            }
            
            if ( [UIScreen mainScreen].bounds.size.width==375) {
                
                int temp2;
                temp2=57;
                float height =  ceilf([self getSize:[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"]]]);
                if(btnBusinessName.hidden)
                {
                    btnBusnessNameHightConst.constant =  0 ;
                    self.view.needsUpdateConstraints;
                    
                 //lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, lbl_gole_p.frame.origin.y + 2, [UIScreen mainScreen].bounds.size.width-8-temp2, height);
                }
                else
                {
                  //  lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, lbl_gole_p.frame.origin.y + 10, [UIScreen mainScreen].bounds.size.width-8-temp2, height);
 
                }
              //  previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height);
                
              //  view_gole_p.frame=CGRectMake(view_gole_p.frame.origin.x, view_gole_p.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8-temp2,  lbl_gole_p.frame.origin.y+ lbl_gole_p.frame.size.height);
//                graph_view.frame=CGRectMake(graph_view.frame.origin.x, view_gole_p.frame.origin.y +  view_gole_p.frame.size.height, [UIScreen mainScreen].bounds.size.width-temp2, 230);
                
                //sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y +10+  graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width-temp2,  sub_view.frame.origin.y+ sub_view.frame.size.height);
            }
            else{
                
               // view_gole_p.frame=CGRectMake(view_gole_p.frame.origin.x, view_gole_p.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8,  lbl_gole_p.frame.origin.y+ lbl_gole_p.frame.size.height);
                
               // graph_view.frame=CGRectMake(graph_view.frame.origin.x, view_gole_p.frame.origin.y +  view_gole_p.frame.size.height, [UIScreen mainScreen].bounds.size.width,  230);
                
               // sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y +10+  graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width,  sub_view.frame.origin.y+ sub_view.frame.size.height);
            }
            
            [self.view bringSubviewToFront:sub_view];

            if ([DELEGATE.isTrac isEqualToString:@"F"]) {
                lbl_gole_p.text=@"";
            }
            else{
                
                NSString *value = [NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"]];
                
                lbl_gole_p.text = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            
             Mobilenumber=[NSString stringWithFormat:@"%@",[[_trac_offline_dic valueForKey:@"Trac"] valueForKey:@"phone"]];
            
            lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
            lbl_communicate.text=[NSString stringWithFormat:@"Communicate with followers"];
            lbl_tractype.text=[NSString stringWithFormat:@"Personal trac - %@",[[self.trac_offline_dic valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
            lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
            lbl_finish_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"finish_date"]];
            lbl_trac_to_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"trac_to_date"]];
            if ([DELEGATE.isTrac isEqualToString:@"F"]) {
                lbl_next.text=@"";
                lbl_next.hidden=YES;
            }
            else{
                lbl_next.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"next_rate_date"]];
            }
            
            lbl_owner.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"rating_frequency"]];
            
            //  btn_ccomment.enabled=NO;
            
            
            
            if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]isEqualToString:@"1"]) {
                  lbl_owner.text=[NSString stringWithFormat:@"%@ follower",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]];
            }
            else{
                  lbl_owner.text=[NSString stringWithFormat:@"%@ followers",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]];
            }

            if ([UIScreen mainScreen].bounds.size.height <= 480) {
                if ([Validate isConnectedToNetwork])
                {
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0, sub_view.frame.origin.y+ sub_view.frame.size.height-216);
                    
                }
                else{
                    
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0, sub_view.frame.origin.y+ sub_view.frame.size.height-340);
                }
                
                
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+45);
            }
            else if([UIScreen mainScreen].bounds.size.height <= 568)
            {
                if ([Validate isConnectedToNetwork])
                {   scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-305);
                }
                else{
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-340);
                }
                
                
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+45);
            }
            else
            {
                
                
                if ([Validate isConnectedToNetwork])
                {    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-448);
                }
                else{
                    
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-360);
                }
                
                
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
            }
            
        }
        else if ([DELEGATE.isTrac isEqualToString:@"G"])
        {
            btn_comment.hidden=NO;
            view_gole_p.hidden=YES;
            view_gole_g.hidden=NO;
            //  btn_comment.enabled=YES;
            
            float height =  ceilf([self getSize:[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"]]]);
            
            
            if ( [UIScreen mainScreen].bounds.size.width==375) {
                
                int temp2;
                temp2=57;
                
                

                
                lbl_detail_g.frame=CGRectMake(lbl_detail_g.frame.origin.x, lbl_gole_g.frame.origin.y+lbl_gole_g.frame.size.height, [UIScreen mainScreen].bounds.size.width-8, height);
                //previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height+lbl_gole_g.frame.size.height+lbl_gole_g.frame.size.height);
              //  view_gole_g.frame=CGRectMake(view_gole_g.frame.origin.x, view_gole_g.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8-temp2,  lbl_detail_g.frame.origin.y+ lbl_detail_g.frame.size.height);
               // graph_view.frame=CGRectMake(graph_view.frame.origin.x, view_gole_g.frame.origin.y +  view_gole_g.frame.size.height, [UIScreen mainScreen].bounds.size.width-temp2,  230);
                //sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y + 10+ graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width-temp2,  sub_view.frame.origin.y+ sub_view.frame.size.height);
            }
            else{
                lbl_detail_g.frame=CGRectMake(lbl_detail_g.frame.origin.x, lbl_gole_g.frame.origin.y+lbl_gole_g.frame.size.height, [UIScreen mainScreen].bounds.size.width-8, height);
                
               //
                //previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height+lbl_gole_g.frame.size.height+lbl_gole_g.frame.size.height);
                
                //view_gole_g.frame=CGRectMake(view_gole_g.frame.origin.x, view_gole_g.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8,  lbl_detail_g.frame.origin.y+ lbl_detail_g.frame.size.height);
               // graph_view.frame=CGRectMake(graph_view.frame.origin.x, view_gole_g.frame.origin.y +  view_gole_g.frame.size.height, [UIScreen mainScreen].bounds.size.width, 230);
               // sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y + 10+ graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width,  sub_view.frame.origin.y+ sub_view.frame.size.height);
            }
            
            NSString *string = [NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"goal"]];
            
            NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            lbl_gole_g.text=trimmedString;
            
            NSString *string_detail =[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"group_name"]];
            NSString *trimmedString_detials = [string_detail stringByTrimmingCharactersInSet:
                                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            lbl_detail_g.text= trimmedString_detials;

            lbl_tractype.text=[NSString stringWithFormat:@"Group trac - %@",[[self.trac_offline_dic valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
            lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
            lbl_finish_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"finish_date"]];
            lbl_trac_to_date.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"trac_to_date"]];
            if ([DELEGATE.isTrac isEqualToString:@"F"]) {
                lbl_next.text=@"";
                lbl_next.hidden=YES;
            }
            else{
                lbl_next.text=[NSString stringWithFormat:@"%@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"next_rate_date"]];
            }
            //  lbl_owner.text=[NSString stringWithFormat:@"Owner Me"];

            if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
                lbl_communicate.text=[NSString stringWithFormat:@"Communicate with followers"];
            }
            else
            {
                lbl_communicate.text=[NSString stringWithFormat:@"Communicate with owner "];
            }
            
            lbl_owner.text= [NSString stringWithFormat:@"Owner : %@",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"]];
            
            
            if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]isEqualToString:@"1"]) {
                  lbl_participated.text=[NSString stringWithFormat:@"%@ participant",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]];
            }
            else{
                  lbl_participated.text=[NSString stringWithFormat:@"%@ participants",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]];
            }
          
            
            if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]isEqualToString:@"1"]) {
                  lbl_group_followers.text=[NSString stringWithFormat:@"%@ follower",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]]   ;
            }
            else{
                  lbl_group_followers.text=[NSString stringWithFormat:@"%@ followers",[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]]   ;
            }
          
            if ([UIScreen mainScreen].bounds.size.height <= 480) {
                scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0, sub_view.frame.origin.y+ sub_view.frame.size.height-340);
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+45);
            }
            else if([UIScreen mainScreen].bounds.size.height <= 568)
            {
                scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-340);
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+45);
            }
            else
            {
                scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
                scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-370);
            }
        }
    }
    
    //krishna
    _textview.tintColor=[UIColor clearColor];
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    if ([Validate isConnectedToNetwork])
    {
        
         // [mc detailstrac:@"3" tracid:@"173" selector:@selector(details:)];
        
     //  [mc detailstrac:@"173" tracid:@"31" selector:@selector(details:)];
        
         //[mc detailstrac:@"3" tracid:@"31" selector:@selector(details:)];
        // [mc detailstrac:@"3" tracid:@"13" selector:@selector(details:)];
        //   [mc detailstrac:@"173" tracid:@"669" selector:@selector(details:)];
        
        //   [mc detailstrac:@"3" tracid:@"15" selector:@selector(details:)];

        [mc detailstrac:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id selector:@selector(details:)];
    }
    else{
        
        
        
        mytoolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
        mytoolbar2.barStyle = UIBarStyleBlackOpaque;
        UIBarButtonItem *done2 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self action:@selector(donePressed3)];
        UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        mytoolbar2.items = [NSArray arrayWithObjects:flexibleSpace1,done2, nil];
        self.textview.inputAccessoryView = mytoolbar2;
        self.datePicker1 = [[UIDatePicker alloc] init];
        _datePicker1.timeZone = [NSTimeZone localTimeZone];
        
        _datePicker1.maximumDate=[NSDate date];
        
        self.datePicker1.datePickerMode = UIDatePickerModeDate;
        [self.datePicker1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.textview.inputView =_datePicker1;
        
        
        NSMutableDictionary *temp;
        
        [DELEGATE openDatabase];
        sqlite3_stmt *selectStatement;
        
        
        NSString* sql = [NSString stringWithFormat:@"SELECT * FROM tracmojo where trac_id=%@",self.trac_id];
        if (sqlite3_prepare_v2(DELEGATE.database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectStatement)==SQLITE_ROW){
                
                NSString *totaldata=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
                temp=[[NSMutableDictionary alloc]initWithDictionary:[totaldata JSONValue]];
                
            }
            [self details:temp];
            
        }
        else
        {
            
        }
        sqlite3_finalize(selectStatement);
    }
    
    
    mytoolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    mytoolbar2.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *done2 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self action:@selector(donePressed3)];
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    mytoolbar2.items = [NSArray arrayWithObjects:flexibleSpace1,done2, nil];
    self.textview.inputAccessoryView = mytoolbar2;
    self.datePicker1 = [[UIDatePicker alloc] init];
    _datePicker1.timeZone = [NSTimeZone localTimeZone];
    _datePicker1.maximumDate=[NSDate date];
    self.datePicker1.datePickerMode = UIDatePickerModeDate;
    [self.datePicker1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.textview.inputView =_datePicker1;


    [self.view bringSubviewToFront:sub_view];

    // Do any additional setup after loading the view from its nib.
}

-(void)monthlyfrompicker
{
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
    
    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];
    ITEM_COUNT = [displayarray count];
    
}

-(void)weeklyfrompicker
{
    
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];

    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];
    ITEM_COUNT = [displayarray count];
    
}

-(void)fornightgraphfrompicker
{
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];

    ITEM_COUNT = displayarray.count;
}


-(void)dailygraphfrompicker
{
    //daily graph after click on done button
 if (([DELEGATE.isTrac isEqualToString:@"G"])) {
        // //// //// ////NSLog(@"%@",temp );(@"%d",days.length );
        ITEM_COUNT = [patricipantsArray count] ;
        DELEGATE.xranges=[patricipantsArray count];
        DELEGATE.str_xvalue=[patricipantsArray count];
    }
    else{
        displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
        // //// //// ////NSLog(@"%@",temp );(@"%d",days.length );
        ITEM_COUNT = [displayarray count] ;
        DELEGATE.xranges=[displayarray count];
        DELEGATE.str_xvalue=[displayarray count];
    }
}


-(NSString *)getDate1:(NSString *)str
{
    NSTimeInterval _interval=[str doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    //// //// ////NSLog(@"%@",temp );(@"%@", date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    // To parse the Date "Sun Jul 17 07:48:34 +0000 2011", you'd need a Format like so:
    
    //9 fer 2015
    //EEE MMM dd HH:mm:ss ZZZ yyyy
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    //// //// ////NSLog(@"%@",temp );(@"%@",formattedDate);
    return [NSString stringWithFormat:@"%@",formattedDate];
}


-(void)weeklygraph
{
    
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
    
    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];
}

-(void)monthlygraph
{
    //1427846400 start apr
    //1427846400+30*86400
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];
}

-(void)fotunightly
{
    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];
    DELEGATE.xranges=[displayarray count];
    DELEGATE.str_xvalue=[displayarray count];
    ITEM_COUNT = displayarray.count;
}


-(void)details:(NSDictionary *)result
{
    isdetailcall = true;
    self->resultDict = result;
    
    arraydatas=[[NSMutableArray alloc]init];
    arrIndexPercent = [[NSMutableArray alloc] init];
    strType=[NSString stringWithFormat:@"%@",[[result valueForKey:@"Trac"]valueForKey:@"type"]];
    type=[NSString stringWithFormat:@"%@",[[result valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
    lbl_type.text=type;

    if ([[[result valueForKey:@"Trac"]valueForKey:@"type"]isEqualToString:@"g"]) {
        
        patricipantsArray=[[NSMutableArray alloc]initWithArray:[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"]];
        
        arraydatas=[[NSMutableArray alloc]initWithArray:[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"owner_rates"]];



        percentagerates=[[NSMutableArray alloc]init];
        
        
        for (int g=0; g<[[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"]count]; g++) {

            NSString *str=[NSString stringWithFormat:@"%@",[[[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"] objectAtIndex:g]valueForKey:@"user_count"]];

            int val = [str intValue];
            // int val = 48;
            int mainTemp;
//
            if (val==0) {
                mainTemp =0;
            }

            else

                if  (val > 0 && val <= 25)
                {
                    mainTemp =1;
                }
                else if (val <= 50)
                {
                    mainTemp = 2;
                }
                else if (val <= 75)
                {
                    mainTemp = 3;
                }
                else if (val <= 100)
                {
                    mainTemp = 4;
                }

            ///  float temp= mainTemp +mainTemp- 25val*(mainTemp-1)
            float temp1 =val-25*(mainTemp-1);
            float temp2=temp1/25;

            float temp= mainTemp + temp2;
            // float temp= mainTemp + val*0.004;
            [percentagerates addObject:[NSString stringWithFormat:@"%f",temp]];
            NSString *strIndex = [NSString stringWithFormat:@"%@",[[[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"] objectAtIndex:g]valueForKey:@"date"]];
            NSString *passedstring;


            if ([strIndex rangeOfString:@"-12-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-12",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-11-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-11",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-10-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-10",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-09-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-09",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-08-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-08",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-07-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-07",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-06-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-06",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-05-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-05",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-04-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-04",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-03-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-03",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-02-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-02",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-01-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-01",[strIndex substringFromIndex:8]];
            }
            [arrIndexPercent addObject:passedstring];
        }
    }
    else{
        
        arraydatas=[[NSMutableArray alloc]initWithArray:[[[result valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"owner_rates"]];
        
        NSDate *date =[NSDate date];
        NSDateFormatter *date11 =[[NSDateFormatter alloc] init];
        [date11 setDateFormat:@"yyyy-MM-dd"];
        
        NSString *str =[date11 stringFromDate:date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 1;
        NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
        
        if([arraydatas count]>0){
        
            NSString *str1 = [[arraydatas objectAtIndex:0] valueForKey:@"date"];
            if([str1 isEqualToString:str]){
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                NSString *newstring = [date11 stringFromDate:newDate];
                [dict setObject:newstring forKey:@"date"];
                [dict setObject:@"0" forKey:@"rate"];
                [arraydatas addObject:dict];

            }
            else{
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:str forKey:@"date"];
                [dict setObject:@"0" forKey:@"rate"];
                [arraydatas addObject:dict];
            }
        }
    }
    dataSource = [NSMutableArray array];
    if ([type isEqualToString:@"Daily"]||[type isEqualToString:@"All Weekdays"])
    {
        [self dailygraph:[NSDate date]];
    }
    if ([type isEqualToString:@"Weekly"])
    {
        [self weeklygraph];
    }
    if ([type isEqualToString:@"Monthly"])
    {
        [self monthlygraph];
    }
    if ([type isEqualToString:@"Fortnightly"])
    {
        [self fotunightly];
    }
   [self loadViewCharst];

}

//////////////////************////////////////////////////////////////////
- (void)datePickerValueChanged:(id)sender
{
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    //  lbl_dates.text=[[NSString stringWithFormat:@"%@",_datePicker1.date]substringToIndex:10];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    DELEGATE.p_emailArray.removeAllObjects;
    
    
        if (![DELEGATE.contact_participants count]==0)
        {
            int countMail=0;
            //NSLog(@"%@",DELEGATE.p_emailArray);
            for (int i=0; i<[DELEGATE.p_emailArray count]; i++) {
                
                if ([[[DELEGATE.p_emailArray objectAtIndex:i]valueForKey:@"isChecked"] isEqualToString:@"Y"])
                {
                    countMail++;
                }
            }
            
            
            
            if (DELEGATE.done) {
                [DELEGATE.contact_participants removeAllObjects];
            }
            
            if (DELEGATE.ischkFollowers) {
                if (countMail==1) {
                    lbl_group_followers.text=[NSString stringWithFormat:@"%d follower",countMail];
                }
                else{
                    lbl_group_followers.text=[NSString stringWithFormat:@"%d followers",countMail];
                }
            }
            
            else{
                if ([[[self.trac_offline_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]isEqualToString:@"1"]) {
                    lbl_participated.text=[NSString stringWithFormat:@"%d participant",countMail];
                }
                else{
                    lbl_participated.text=[NSString stringWithFormat:@"%d participants",countMail];
                }

            }
            
         
           
        }
    
    previewImage.clipsToBounds = YES;
    
    previewImage.layer.cornerRadius = 7;
    
    
    if (DELEGATE.isAvaiable) {
        if ([Validate isConnectedToNetwork]) {
            
            if ( DELEGATE.isFromReview) {
                [mc GettracDetail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:self.trac_id selector:@selector(didgetResponserSelectedTrac:)];
            }
            
        }
    }
    
}

-(float)getSize:(NSString *)message
{
    CGSize boundingSize ;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.width == 320)
        {
            boundingSize = CGSizeMake(300, 10000000);
        }
        else  if ([[UIScreen mainScreen] bounds].size.width == 375)
        {
            boundingSize = CGSizeMake(360, 10000000);
        }
        else{
            boundingSize = CGSizeMake(370, 10000000);
        }
    }
    else
    {
        
    }
    NSString *trimmedString_name = [message stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    CGSize itemTextSize = [trimmedString_name sizeWithFont:[UIFont systemFontOfSize:16.0]
                                         constrainedToSize:boundingSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
    float cellHeight = itemTextSize.height;
    return cellHeight;
}
-(void)didgetResponserSelectedTrac:(NSDictionary*)dic
{

    NSLog(@"Value of track. = %@", DELEGATE.isTrac);

    if ([DELEGATE.isTrac isEqualToString:@"F"]) {
        [btn_comment setTitle:@"View/Add Comments" forState:normal];
        
            lbl_badge.frame=CGRectMake(lbl_badge.frame.origin.x, lbl_badge.frame.origin.y, lbl_badge.frame.size.width, lbl_badge.frame.size.height);
            
            badgeimag.frame=CGRectMake(badgeimag.frame.origin.x-1, badgeimag.frame.origin.y, badgeimag.frame.size.width, badgeimag.frame.size.height);
    }
    
    if ([[[dic valueForKey:@"Trac"] valueForKey:@"is_owner_participant"]isEqualToString:@"y"]) {
        
         DELEGATE.istemp9=YES;
        
         lbl_trac_to_date.hidden=YES;
       
        
    }
    else{
         DELEGATE.istemp9=NO;
    }
    
    if ([[NSString stringWithFormat:@"%@",[[dic valueForKey:@"Trac"] valueForKey:@"next_rate_date"]]isEqualToString:@"-1"]) {
        lbl_next.hidden=YES;
    }
    
    if ([[[dic objectForKey:@"Trac"] objectForKey:@"type"] isEqualToString:@"g"]) {
        //C chnage
        
    }
    
    
    if ([DELEGATE.isTrac isEqualToString:@"F"]) {
        lblnext.hidden=YES;
        lbl_next.hidden=YES;
        addF.hidden=YES;
        addP.hidden=YES;
    }
    
    self.view.hidden=NO;
    Mobilenumber=[NSString stringWithFormat:@"%@",[[dic valueForKey:@"Trac"] valueForKey:@"phone"]];
    lbl_badge.text=[NSString stringWithFormat:@"%@",[[dic valueForKey:@"Trac"] valueForKey:@"comment_count"]];
    
    if ([lbl_badge.text isEqualToString:@"0"]) {
        
        [badgeimag setImage:[UIImage imageNamed:@"badgeGray"]];
        
        
    }
    else{
        [badgeimag setImage:[UIImage imageNamed:@"badge"]];
        
    }
    
    
    {
        self.trac_detail_dic=dic;
        
        if ([[dic objectForKey:@"Trac"] objectForKey:@"business_name"] != nil)
        {
            [btnBusinessName setTitle: [[dic objectForKey:@"Trac"] objectForKey:@"business_name"] forState:UIControlStateNormal];
            btnBusinessName.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
            get_btnText = [[dic objectForKey:@"Trac"] objectForKey:@"business_name"];
            [btnBusinessName setTitleColor:[UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
        else
        {
            get_btnText = [[dic objectForKey:@"Trac"] objectForKey:@"business_name"];
            [btnBusinessName setHidden: true];
        }
        
        if ([[dic objectForKey:@"status"]isEqualToString:@"Success"])
        {
            if ([DELEGATE.isTrac isEqualToString:@"P"]||[DELEGATE.isTrac isEqualToString:@"F"])
            {
                
                
                if ([DELEGATE.isTrac isEqualToString:@"F"]) {
                    lbl_group_followers.frame=CGRectMake(lbl_participated.frame.origin.x+30, lbl_participated.frame.origin.y, lbl_participated.frame.size.width, lbl_participated.frame.size.height);
                }
                else{
                    lbl_group_followers.frame=CGRectMake(lbl_participated.frame.origin.x, lbl_participated.frame.origin.y, lbl_participated.frame.size.width, lbl_participated.frame.size.height);
                }
                
                
                
                addF.frame=CGRectMake(addP.frame.origin.x, addP.frame.origin.y, addP.frame.size.width, addP.frame.size.height);
                
                if (![[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
                    btn_facebook.hidden=YES;
                    btn_twitter.hidden=YES;
                    btn_send_mail.hidden=YES;
                    lbl_sharethis.hidden=YES;
                    
                    
                }
                else{
                    btnmcal.hidden=YES;
                }
                
                
                view_gole_p.hidden=NO;
                view_gole_g.hidden=YES;
                //    btn_comment.hidden=YES;
                
                
                
                
               
                //            else
                //            {
                float height =  ceilf([self getSize:[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"goal"]]]);
                
                if(btnBusinessName.hidden)
                {
                    
                    btnBusnessNameHightConst.constant =  0 ;
                    self.view.needsUpdateConstraints;
                    //lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, view_gole_p.frame.origin.y , [UIScreen mainScreen].bounds.size.width-8, height+22);

                }
                else
                {
                     // lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, view_gole_p.frame.origin.y + 10 , [UIScreen mainScreen].bounds.size.width-8, height+22);
                    
                    // changes by me
                      //lbl_gole_p.frame=CGRectMake(lbl_gole_p.frame.origin.x, view_gole_p.frame.origin.y + 10, [UIScreen mainScreen].bounds.size.width-8, height+22);
                }
               
                
              //  previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height+20);

                

              //  view_gole_p.frame=CGRectMake(view_gole_p.frame.origin.x, view_gole_p.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8,  lbl_gole_p.frame.origin.y+ lbl_gole_p.frame.size.height);
              
               // graph_view.frame=CGRectMake(graph_view.frame.origin.x, viewHeader.frame.origin.y + viewHeader.frame.size.height , [UIScreen mainScreen].bounds.size.width,  230);
                
                
                graph_view.backgroundColor = [UIColor whiteColor];
                
                
               // sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y+10 +  graph_view.frame.size.height+10 , [UIScreen mainScreen].bounds.size.width, sub_view.frame.size.height);
                
                
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"goal"] isEqualToString:@""]) {
                    
                    NSString *value =   [NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"idea_id_name"]];
                    
                    lbl_gole_p.text= [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                }
                else{
                    
                    
                    NSString *value =  [NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"goal"]];                    lbl_gole_p.text= [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    

                }
              //
                // }
                
                lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
                
                if ([DELEGATE.isTrac isEqualToString:@"P"])
                {
                    addF.hidden=NO;
                    lbl_communicate.text=[NSString stringWithFormat:@"Communicate with followers"];
                }
                else if([DELEGATE.isTrac isEqualToString:@"F"]){
                    lbl_communicate.text=[NSString stringWithFormat:@"Communicate with owner"];
                }

                if ([[[_trac_detail_dic valueForKey:@"Trac"]valueForKey:@"type"]isEqualToString:@"g"]) {
                     lbl_tractype.text=[NSString stringWithFormat:@"Group trac - %@",[[self.trac_detail_dic valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
                }
                else{
                    lbl_tractype.text=[NSString stringWithFormat:@"Personal trac - %@",[[self.trac_detail_dic valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
                }

                lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
                lbl_finish_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"finish_date"]];
                lbl_trac_to_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"trac_to_date"]];
                lbl_next.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"next_rate_date"]];

                lbl_owner.text=[NSString stringWithFormat:@"Owner %@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"]];

                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]isEqualToString:@"1"]) {
                     lbl_group_followers.text=[NSString stringWithFormat:@"%@ follower",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]];
                }
                else
                {
                     lbl_group_followers.text=[NSString stringWithFormat:@"%@ followers",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]];
                }

                //chnage
               if ([UIScreen mainScreen].bounds.size.height <= 480) {
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,sub_view.frame.origin.y+ sub_view.frame.size.height-50);
                    
                }
                else if([UIScreen mainScreen].bounds.size.height <= 568)
                    //                {
                {
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,sub_view.frame.origin.y+ sub_view.frame.size.height-130);
                }
                else
                {
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,sub_view.frame.origin.y+ sub_view.frame.size.height-220);
                }
                
                
                //c chnage

                
                
                // }
                
            }
            else if ([DELEGATE.isTrac isEqualToString:@"G"])
            {
                
                
//                   sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y +10+  graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width, );
                
                
                
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {

                addF.hidden=NO;
                addP.hidden=NO;
                    
                    
                }
                else{
                    addF.hidden=YES;
                    addP.hidden=YES;
                    lbl_group_followers.frame=CGRectMake(lbl_group_followers.frame.origin.x+30, lbl_group_followers.frame.origin.y, lbl_group_followers.frame.size.width, lbl_group_followers.frame.size.height);
                    lbl_participated.frame=CGRectMake(lbl_participated.frame.origin.x+30, lbl_participated.frame.origin.y, lbl_participated.frame.size.width,lbl_participated.frame.size.height);


                }

                btn_comment.hidden=NO;
                view_gole_p.hidden=YES;
                view_gole_g.hidden=NO;
                //  btn_comment.enabled=YES;
                
                float height =  ceilf([self getSize:[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"goal"]]]);
                
                if (height > 25)
                {
                    headerViewMinHightConst.constant = 72;
                    //lbl_detail_g.frame=CGRectMake(lbl_detail_g.frame.origin.x, (lbl_gole_g.frame.origin.y+lbl_gole_g.frame.size.height) - 20 , [UIScreen mainScreen].bounds.size.width-8, height);
                 //   graph_view.frame = CGRectMake(graph_view.frame.origin.x,viewHeader.frame.origin.y +viewHeader.frame.size.height, graph_view.frame.size.width, 230);
                    
                }
                else
                {
//               lbl_detail_g.frame=CGRectMake(lbl_detail_g.frame.origin.x, lbl_gole_g.frame.origin.y+lbl_gole_g.frame.size.height , [UIScreen mainScreen].bounds.size.width-8, height);
                }
                
                
                
                //previewImage.frame=CGRectMake(previewImage.frame.origin.x, previewImage.frame.origin.y, previewImage.frame.size.width, height+lbl_gole_g.frame.size.height+9);
                
                
                //view_gole_p.frame=CGRectMake(view_gole_p.frame.origin.x, view_gole_p.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8,  lbl_gole_p.frame.origin.y+ lbl_gole_p.frame.size.height);
                
                // view_gole_g.frame=CGRectMake(view_gole_g.frame.origin.x, lbl_detail_g.frame.origin.y+lbl_detail_g.frame.size.height, [UIScreen mainScreen].bounds.size.width-8,  lbl_detail_g.frame.origin.y+ lbl_detail_g.frame.size.height);
                
                
                //abrez
                
                //view_gole_g.frame=CGRectMake(view_gole_g.frame.origin.x, view_gole_g.frame.origin.y, [UIScreen mainScreen].bounds.size.width-8,  lbl_detail_g.frame.origin.y+ lbl_detail_g.frame.size.height+7);
                
                
                //graph_view.frame=CGRectMake(graph_vƒiew.frame.origin.x, view_gole_g.frame.origin.y +  view_gole_g.frame.size.height, [UIScreen mainScreen].bounds.size.width,  230);
                graph_view.backgroundColor = [UIColor whiteColor];
                
                
                
             //     sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y +10+  graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width,  338);
                
                if (   DELEGATE. isyPlus==NO) {
                       DELEGATE. isyPlus=YES;
                    
                  //  sub_view.frame=CGRectMake(sub_view.frame.origin.x, graph_view.frame.origin.y +10+  graph_view.frame.size.height, [UIScreen mainScreen].bounds.size.width,  sub_view.frame.origin.y+ sub_view.frame.size.height);
                }
                
                NSString *string = [NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"group_name"]];

                NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];

                
                lbl_gole_g.text=trimmedString;
                
                NSString *string_detail =[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"goal"]];
                NSString *trimmedString_detials = [string_detail stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];

                lbl_detail_g.text= trimmedString_detials;
                
                
                lbl_tractype.text=[NSString stringWithFormat:@"Group trac - %@",[[self.trac_detail_dic valueForKey:@"Trac"] valueForKey:@"rating_frequency"]];
                lbl_start_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"start_date"]];
                lbl_finish_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"finish_date"]];
                lbl_trac_to_date.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"trac_to_date"]];
                lbl_next.text=[NSString stringWithFormat:@"%@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"next_rate_date"]];
 
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
                    lbl_communicate.text=[NSString stringWithFormat:@"Communicate to participants & followers"];
                    btnmcal.hidden=YES;
                }
                else
                {
                    
                    btn_facebook.hidden=YES;
                    btn_twitter.hidden=YES;
                    btn_send_mail.hidden=YES;
                    lbl_sharethis.hidden=YES;
                    
                    
                    lbl_communicate.text=[NSString stringWithFormat:@"Communicate with owner"];
                }
                lbl_owner.text= [NSString stringWithFormat:@"Owner %@",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"]];
                
                
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]isEqualToString:@"1"]) {
                      lbl_participated.text=[NSString stringWithFormat:@"%@ participant",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]];
                }
                else{
                      lbl_participated.text=[NSString stringWithFormat:@"%@ participants",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"participant_count"]];
                }
              
                
                
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]isEqualToString:@"1"]) {
                     lbl_group_followers.text=[NSString stringWithFormat:@"%@ follower",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]]   ;
                }
                else{
                     lbl_group_followers.text=[NSString stringWithFormat:@"%@ followers",[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"follower_count"]]   ;
                }
                
                
                if ([UIScreen mainScreen].bounds.size.height <= 480) {
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0, sub_view.frame.origin.y+ sub_view.frame.size.height-192);
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+45);
                }
                else if([UIScreen mainScreen].bounds.size.height <= 568)
                {
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-279);
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height+35);
                }
                else
                {
                    scroll.frame=CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height);
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+0,sub_view.frame.origin.y+ sub_view.frame.size.height-422);
                }
                
            }
            
            
            //if trac is not made by me then this is the condition to hide share buttons & imageview
            
            if (![[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
                if ([DELEGATE.isTrac isEqualToString:@"F"]) {
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, scroll.contentSize.height-150);
                }
                else{
                    scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, scroll.contentSize.height-50);
                }
                imgLine.hidden=YES;
            }
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)touch_Facebook:(id)sender
{
    UIImage  *image;

    UIGraphicsBeginImageContext(scroll.contentSize);
    {
        CGPoint savedContentOffset = scroll.contentOffset;
        CGRect savedFrame = scroll.frame;

        scroll.contentOffset = CGPointZero;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(scroll.frame.size.width, graph_view.frame.size.height+graph_view.frame.origin.y+10), NO, 0.0);
        
        scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y+30);
       // scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y);
        [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();

        scroll.contentOffset = savedContentOffset;
        scroll.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
//    NSData * data =[[NSData alloc]initWithData:UIImagePNGRepresentation(image)];
//    UIImage *img=[UIImage imageWithData:data];

    
    if (DELEGATE.isAvaiable) {
//        FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
//        [params setName:@"tracmojo"];
//
//        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
//                                                                              initialText:@""
//                                                                                    image:img
//                                                                                      url:[NSURL URLWithString:@"www.tracmojo.com" ]
//                                                                                  handler:nil];
//
//        if (!displayedNativeDialog) {
//            [FBRequestConnection startForPostStatusUpdate:@"fdsfdsf"
//                                        completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                                        }];
//
//
//
//        }
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [slComposerSheet setInitialText:@""];
            [slComposerSheet addImage:image];
//            [slComposerSheet addURL:[NSURL URLWithString:@"www.tracmojo.com"]];
            [self presentViewController:slComposerSheet animated:YES completion:nil];
            
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Facebook"
                                         message:@"Please add Facebook account in setting"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                     
                  [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"App-Prefs:root=General"]];
//                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                        }];
            
            [alert addAction:yesButton];
            
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];

    }
    else
    {

        [self.view makeToast:@"Please check your internet connection"];

    }

}

-(IBAction)touch_Twitter:(id)sender
{
    
    if (DELEGATE.isAvaiable) {
        
        UIImage  *image;
        
        UIGraphicsBeginImageContext(scroll.contentSize);
        {
            CGPoint savedContentOffset = scroll.contentOffset;
            CGRect savedFrame = scroll.frame;
            scroll.contentOffset = CGPointZero;

            UIGraphicsBeginImageContextWithOptions(CGSizeMake(scroll.frame.size.width, graph_view.frame.size.height+graph_view.frame.origin.y+10), NO, 0.0);
            
            scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y+30);
            //scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y);
            
            [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            scroll.contentOffset = savedContentOffset;
            scroll.frame = savedFrame;
        }
        UIGraphicsEndImageContext();
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [slComposerSheet setInitialText:@""];
            [slComposerSheet addImage:image];
            [slComposerSheet addURL:[NSURL URLWithString:@"www.tracmojo.com"]];
            [self presentViewController:slComposerSheet animated:YES completion:nil];
            
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Twitter"
                                         message:@"Please add twitter account in setting"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                        
                                            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"App-Prefs:root=General"]];
                                            
//                                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                                          
     


                                            
                                        }];
            //
            //            UIAlertAction* noButton = [UIAlertAction
            //                                       actionWithTitle:@"No"
            //                                       style:UIAlertActionStyleDefault
            //                                       handler:^(UIAlertAction * action) {
            //                                           //Handle no, thanks button
            //                                       }];
            
            [alert addAction:yesButton];
            //            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }

        
//        if ([[FHSTwitterEngine sharedEngine]isAuthorized]) {
//            
//        
//            if ([[FHSTwitterEngine sharedEngine]isAuthorized])
//            {
//               
//                
//                //by this code we can make screen shot by selecting frame.use this simple method for that
//                
//                ///// abrez /////
//                
//                UIImage  *image;
//                
//                UIGraphicsBeginImageContext(scroll.contentSize);
//                {
//                    CGPoint savedContentOffset = scroll.contentOffset;
//                    CGRect savedFrame = scroll.frame;
//                    
//                    scroll.contentOffset = CGPointZero;
//                    scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y);
//                    
//                    [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
//                    image = UIGraphicsGetImageFromCurrentImageContext();
//                    
//                    scroll.contentOffset = savedContentOffset;
//                    scroll.frame = savedFrame;
//                }
//                UIGraphicsEndImageContext();
//                NSData * data = UIImagePNGRepresentation(image);
//                
//                UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
//                    //// //// //// ////NSLog(@"%@",temp );(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
//                    if (success) {
//                         [[FHSTwitterEngine sharedEngine]postTweet:@"www.tracmojo.com" withImageData:data];
//                        //  [[FHSTwitterEngine sharedEngine]postTweet:strtwitter];
//                        [btn_twitter setSelected:YES];
//                        // [imgtwiter setHidden:NO];
//                        UIAlertView *aler_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Sharing successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                        aler_msg.tag=101;
//                       // [aler_msg show];
//                    }
//                    
//                }];
//                [self presentViewController:loginController animated:YES completion:nil];
//            }
//        }
//        else
//        {
//            //sender.selected =YES;
//            UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
//                //// //// //// ////NSLog(@"%@",temp );(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
//                if (success) {
//                    // [[FHSTwitterEngine sharedEngine]postTweet:str withImageData:imgdata];
//                    //  [[FHSTwitterEngine sharedEngine]postTweet:strtwitter];
//                    [btn_twitter setSelected:YES];
//                    // [imgtwiter setHidden:NO];
//                    
//                }
//                
//            }];
//            [self presentViewController:loginController animated:YES completion:nil];
//        }
    }
    else
    {
        
        [self.view makeToast:@"Please check your internet connection"];
    }
    
}
-(IBAction)touch_Email:(id)sender
{
    if (DELEGATE.isAvaiable) {
        
        /// abrez
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
            [composeViewController setMailComposeDelegate:self];
            UIImage  *image;
            
            UIGraphicsBeginImageContext(scroll.contentSize);
            {
                CGPoint savedContentOffset = scroll.contentOffset;
                CGRect savedFrame = scroll.frame;
                
                scroll.contentOffset = CGPointZero;
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(scroll.frame.size.width, graph_view.frame.size.height+graph_view.frame.origin.y+10), NO, 0.0);
                
                scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y+30);
                //scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, graph_view.frame.size.height+graph_view.frame.origin.y);
                
                [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
                image = UIGraphicsGetImageFromCurrentImageContext();
                
                scroll.contentOffset = savedContentOffset;
                scroll.frame = savedFrame;
            }
            UIGraphicsEndImageContext();
            
            NSData * data = UIImagePNGRepresentation(image);
            [composeViewController addAttachmentData:data mimeType:@"image/png"   fileName:@"personaltracs"];
            [composeViewController setMessageBody:@"http://tracmojo.com/" isHTML:NO];
            [composeViewController setSubject:@"Shared tracmojo trac"];
            [self presentViewController:composeViewController animated:YES completion:nil];
            
        }
        
    }
    else
    {
        
        [self.view makeToast:@"Please check your internet connection"];
        
        
        //        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Please check your internet connection" d∂†elegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alt show];
    }
}

-(IBAction)touch_emailinvited:(id)sender
{
    
    if (DELEGATE.isAvaiable)
    {
        
        if ([lbl_group_followers.text isEqualToString:@"0 followers"] && [lbl_participated.text isEqualToString:@"0 participants"] ) {
            [self.view makeToast:@"No participants or follower found!"];
            
            
        }
        else{
            if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"])
            {
                is_checkInvite=YES;
                txt_message.text=@"";
                lbl_msg.text=@"Send mail";
                scroll_popup.hidden=NO;
            }
            else
            {
                //            UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"You are not owner of this trac. You can not send email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                //            [alt show];
                is_checkInvite=YES;
                txt_message.text=@"";
                lbl_msg.text=@"Send mail";
                scroll_popup.hidden=NO;
            }
        }
    }
    else
    {
        
        [self.view makeToast:@"Please check your internet connection"];
        
        //        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alt show];
    }
 }

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    if (result == MFMailComposeResultSent) {
        UIAlertView *aler_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Sharing successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        aler_msg.tag=101;
        [aler_msg show];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (alertView.tag==999)
    {
        if (buttonIndex==0) {
            //// ////NSLog(@"%@",temp );(@"0");
            
        }
        if (buttonIndex==2) {
            
           
                NSString*str=[Mobilenumber stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
                
                
                
                NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                
                NSString *phoneNumber = [@"telprompt://" stringByAppendingString:newString];
                UIWebView *callWebview = [[UIWebView alloc] init];
                NSURL *telURL = [NSURL URLWithString:phoneNumber];
                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
                if ([[UIApplication sharedApplication]canOpenURL:[[NSURL alloc] initWithString:phoneNumber]])
                {
                    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:phoneNumber]];
                }
                else{
                    UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"In this device there is no call functionality" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alt show];
                }
        }
        if (buttonIndex==1) {
            //// ////NSLog(@"%@",temp );(@"2");
            
            NSString*str=Mobilenumber;
            
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            if([MFMessageComposeViewController canSendText])
            {
                controller.body = @"";
                controller.recipients = [NSArray arrayWithObjects:str, nil];
                controller.messageComposeDelegate = self;
                [self presentModalViewController:controller animated:YES];
            }
        }
    }
}

-(IBAction)touch_Comment:(id)sender
{
    NSLog(@"Value of track. = %@", DELEGATE.isTrac);

    if ([lbl_badge.text isEqualToString:@"0"]) {
        
        CommentsViewController *comment=[[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
        if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
            comment.isOwner=YES;
        }
        comment.trac_id=[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"id"];
        [self.navigationController pushViewController:comment animated:YES];
        //[self.view makeToast:@"No comments found"];
        return;
    }
    
    
    if (DELEGATE.isAvaiable)
    {
        
        if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"])
        {
            CommentsViewController *comment=[[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
            comment.trac_id=[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"id"];
            comment.isOwner=YES;
            
            [self.navigationController pushViewController:comment animated:YES];
            
        }
        else
        {
            
            CommentsViewController *comment=[[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
            comment.trac_id=[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"id"];
            comment.isOwner=false;
        
            [self.navigationController pushViewController:comment animated:YES];
            
            
//            UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"You are not owner of this trac. You can not view comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alt show];
        }
        
    }
    else
    {
        [self.view makeToast:@"Please check your internet connection"];
        //
        //        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alt show];
    }
}
-(IBAction)touch_help:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)touch_notification:(id)sender
{
    if ([lbl_group_followers.text isEqualToString:@"0 followers"] && [lbl_participated.text isEqualToString:@"0 participants"] ) {
        [self.view makeToast:@"No participants or follower found!"];
    }
    else{
        if (DELEGATE.isAvaiable) {
            
            if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"])
            {
                lbl_msg.text=@"Send notification";
                txt_message.text=@"";
                is_checkInvite=NO;
                scroll_popup.hidden=NO;
            }
            else
            {
                //            UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"You are not owner of this trac. You can not send notification" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                //            [alt show];
                lbl_msg.text=@"Send notification";
                txt_message.text=@"";
                is_checkInvite=NO;
                scroll_popup.hidden=NO;
            }
        }
        else
        {
            
            [self.view makeToast:@"Please check your internet connection"];
            
            //        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alt showsawas/aSaSas;
        }
    }
}

-(IBAction)touch_cancel:(id)sender
{
    scroll_popup.hidden=YES;
    [txt_message resignFirstResponder];
}
-(IBAction)touch_Message:(id)sender
{
    scroll_popup.hidden=NO;
    
    NSLog(@"Value of track. = %@", DELEGATE.isTrac);

    if ([Validate isEmpty:txt_message.text]) {
        UIAlertView *aler_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Please enter message" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [aler_msg show];
        [txt_message becomeFirstResponder];
    }
    else
    {
        [txt_message resignFirstResponder];
        mc=[[ModelClass alloc]init];
        mc.delegate=self;
        if ([Validate isConnectedToNetwork])
        {
            //  [mc GettracDetail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:self.trac_id selector:@selector(didgetResponserSelectedTrac:)];
            if (is_checkInvite)
            {
                
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"])
                {
                    
                    if ([DELEGATE.isTrac isEqualToString:@"P"]||[DELEGATE.isTrac isEqualToString:@"F"])
                    {
                        
                        [mc sendEmail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"followers" selector:@selector(respondsToFollowers:)];
                    }
                    else{
                        
                        if ([DELEGATE.isTrac isEqualToString:@"G"])
                        {
                            [mc sendEmail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"all" selector:@selector(respondsToFollowers:)];
                        }
                        
                        else{
                            [mc sendEmail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"participants" selector:@selector(respondsToFollowers:)];
                        }
                    }
                }
                else
                {
                    [mc sendEmail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"owner" selector:@selector(respondsToFollowers:)];
                }
            }
            else
            {
                if ([[[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"])
                {
                    
                    
                    
                    if ([DELEGATE.isTrac isEqualToString:@"P"]||[DELEGATE.isTrac isEqualToString:@"F"])
                    {
                        
                        [mc sendPushnotification_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"followers" selector:@selector(respondsToFollowers:)];
                        
                    }
                    else{
                        [mc sendPushnotification_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"all" selector:@selector(respondsToFollowers:)];
                    }
                    
                }
                else
                {
                    [mc sendPushnotification_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:self.trac_id message:txt_message.text send_to:@"owner" selector:@selector(respondsToFollowers:)];
                }
                
            }
        }
    }
}

-(void)respondsToFollowers:(NSDictionary*)dic
{
    
    if ([[dic objectForKey:@"status"]isEqualToString:@"success"]) {
        UIAlertView *alt_msg=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt_msg show];
    }
    else
    {
        UIAlertView *alt_msg=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt_msg show];
    }
    
    scroll_popup.hidden=YES;
    [txt_message resignFirstResponder];
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //// //// //// ////NSLog(@"%@",temp );(@"%d",scrollView.tag);
    
    if (scrollView.tag==10&&[scrollView.panGestureRecognizer translationInView:scrollView.superview].x > 0) {
        scrollView.scrollEnabled = YES;
    }
    
    else if (scrollView.tag==10&&[scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        
        // scrollView.scrollEnabled = NO;
    }
    
    else{
        //  scrollView.scrollEnabled = YES;
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.scrollEnabled = YES;
}

//tin tin code

- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)selected
{
    NSDate* enddate = selected;
    NSDate* currentdate = [NSDate date];
    
    NSDateFormatter *format =[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM"];
    
    int selectedMonth = [[format stringFromDate:enddate] intValue];
    int currrentMonth = [[format stringFromDate:currentdate] intValue];
    
    if(selectedMonth > currrentMonth)
        return YES;
    else
        return NO;
    
}

#pragma mark ChartView
#pragma mark ChartView

#pragma mark - IAxisValueFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
//    return xVals[(int)value % xVals.count];
    if (xVals.count>0){
        return xVals[(int)value % xVals.count] ; // this calculation base on you want to display.
    }
    return nil;
}

-(void)loadViewCharst
{
    //  lbl_dates.text=[[NSString stringWithFormat:@"%@",_datePicker1.date]substringToIndex:10];
    //create  new charts
    
    CGRect rect = CGRectMake(0, -5, [UIScreen mainScreen].bounds.size.width  ,  259+5);
    chartView.frame = rect;
    [graph_view bringSubviewToFront:chartView];
    
    graph_view.clipsToBounds = NO;

        chartView.delegate = self;
        //    chartView.descriptionText = @"";
        //chartView.noDataTextDescription = @"You need to provide data for the chart.";
        chartView.noDataText = @"\t   No chart data Available.\nYou need to provide data for the chart."; //for new version on chart 3.0
        chartView.noDataTextColor =  [UIColor colorWithRed:255.0/255.0 green:0.0 blue:0.0 alpha:0.25];
        chartView.backgroundColor = [UIColor clearColor];
        chartView.chartDescription.enabled = NO;
        chartView.drawValueAboveBarEnabled = NO;
        chartView.drawBordersEnabled = NO;
        chartView.descriptionTextAlign = NSTextAlignmentCenter;
        chartView.drawGridBackgroundEnabled = NO;
        chartView.drawBarShadowEnabled = NO;
//        chartView.highlightPerTapEnabled = false; // tap karva thi line of x and y axis ni dekhade aa band karva mate
//        chartView.highlightPerDragEnabled = false;// drag karva thi line of x and y axis ni dekhade aa band karva mate

        //extra thing as per before added here
        chartView.drawValueAboveBarEnabled = NO;
        chartView.drawBordersEnabled = NO;
        chartView.drawMarkers = NO;
        [chartView setScaleEnabled:YES];

        chartView.scaleYEnabled = NO; // scroll band karva mate aa no used thay che
        chartView.drawOrder = @[
                                @(CombinedChartDrawOrderBar),
                                @(CombinedChartDrawOrderLine),

                                ];

//            ChartLegend *l = chartView.legend;
//            l.wordWrapEnabled = YES;
//            l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
//            l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
//            l.orientation = ChartLegendOrientationHorizontal;
//            l.drawInside = NO;

        ChartYAxis *rightAxis = chartView.rightAxis;
        rightAxis.drawGridLinesEnabled = NO;
//        rightAxis._customAxisMax = 5.00;
//        rightAxis._customAxisMin = 1.00;
//        rightAxis.axisRa nge = 1;
        rightAxis.enabled = NO; // graph ma display na thay atle rightside bar

        ChartYAxis *leftAxis = chartView.leftAxis;
        leftAxis.drawGridLinesEnabled = NO;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        leftAxis.enabled = NO; // graph ma display na thay atle

        ChartXAxis *xAxis = chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
//       xAxis.labelPosition
//        xAxis.axisMinimum = 0.0;
        xAxis.drawAxisLineEnabled = NO;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.drawLimitLinesBehindDataEnabled = NO;
        [xAxis setGranularityEnabled:YES];
        [xAxis setGranularity:1.0];
        xAxis.valueFormatter = self;



    ////  calculate ITEM_COUNT
    if ([type isEqualToString:@"Daily"]||[type isEqualToString:@"All Weekdays"])
    {
        [self dailygraphfrompicker];
    }
    if ([type isEqualToString:@"Fortnightly"])
    {
        [self fornightgraphfrompicker];
    }

    /////this is for weekly graph////
    if ([type isEqualToString:@"Weekly"])
    {
        [self weeklyfrompicker];
    }
    if ([type isEqualToString:@"Monthly"])
    {
        [self monthlyfrompicker];
    }

    ///end config ITEM_COUNT
    [chartView clear];

    //load day of month
    xVals = [[NSMutableArray alloc] init];
    if ([DELEGATE.isTrac isEqualToString:@"G"])
    {
        for(int i = 0; i< [patricipantsArray count] ;i++)
        {
            NSString *passedstring;
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-12-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-12",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-11-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-11",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-10-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-10",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-09-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-09",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-08-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-08",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-07-"].location != NSNotFound) {

                passedstring=[NSString stringWithFormat:@"%@-07",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-06-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-06",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-05-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-05",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-04-"].location != NSNotFound){
                passedstring=[NSString stringWithFormat:@"%@-04",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-03-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-03",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-02-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-02",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-01-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-01",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            [xVals addObject:passedstring];
        }
    }
    else
    {
        for(int i = 0; i< [displayarray count] ;i++)
        {
            NSString *passedstring;
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-12-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-12",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-11-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-11",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-10-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-10",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-09-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-09",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
                
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-08-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-08",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-07-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-07",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
                
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-06-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-06",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-05-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-05",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-04-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-04",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-03-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-03",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-02-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-02",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-01-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-01",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
            [xVals addObject:passedstring];
        }
    }
    
    
    ///check time picked smaller time now, but now not nesscessary because i limited pickerview
    if (![self isEndDateIsSmallerThanCurrent:_datePicker1.date])
    {

        CombinedChartData *data = [[CombinedChartData alloc] init];
        if ([DELEGATE.isTrac isEqualToString:@"P"]||[DELEGATE.isTrac isEqualToString:@"F"])
        {
            data.lineData = [self generateLineDataFORPERSONAL];
        }else {
            [self processDataBarChart];

            if(patricipantsArray.count > 0)
                data.lineData = [self generateLineData];
            if(percentagerates.count > 0)
                data.barData = [self generateBarData];

            //display center ma karva mate aa use kari yu che bar chart ma point niche na center ma dekhay che ne  ee
            chartView.xAxis.axisMaximum = data.xMax + 0.5;
            chartView.xAxis.axisMinimum = data.xMin - 0.5;
        }
//        chartView.leftAxis.startAtZeroEnabled = NO;
//        chartView.rightAxis.startAtZeroEnabled = NO;
//        chartView.rightAxis._customAxisMax = 5;
//        chartView.rightAxis._customAxisMin = 0.0; // this replaces startAtZero = YES
//        chartView.rightAxis.axisMinValue = 0.0;
//        chartView.rightAxis.axisMaxValue = 5.0;
        chartView.data = data;
        [chartView setHidden:NO];
        
    }                                                      
    else
    {
        //hide charst when empty data
        [chartView clear];
        [chartView setHidden:YES];
        
    }
    
    graph_view.clipsToBounds = YES;
}


- (LineChartData *)generateLineData1
{
    LineChartData *d = [[LineChartData alloc] init];

    NSMutableArray *entries = [[NSMutableArray alloc] init];

    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(15) + 5)]];
    }

    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Line DataSet"];
    [set setColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];

    set.axisDependency = AxisDependencyLeft;

    [d addDataSet:set];

    return d;
}

- (BarChartData *)generateBarData12
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];

    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:(arc4random_uniform(25) + 25)]];

        // stacked
        [entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }

    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Bar 1"];
    [set1 setColor:[UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f]];
   // set1.valueTextColor = [UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f];
    set1.valueFont = [UIFont systemFontOfSize:10.f];
    set1.axisDependency = AxisDependencyLeft;

    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:entries2 label:@""];
    set2.stackLabels = @[@"Stack 1", @"Stack 2"];
    set2.colors = @[
                    [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f],
                    [UIColor colorWithRed:23/255.f green:197/255.f blue:255/255.f alpha:1.f]
                    ];
    set2.valueTextColor = [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f];
    set2.valueFont = [UIFont systemFontOfSize:10.f];
    set2.axisDependency = AxisDependencyLeft;

    float groupSpace = 0.06f;
    float barSpace = 0.02f; // x2 dataset
    float barWidth = 0.45f; // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"

    BarChartData *d = [[BarChartData alloc] initWithDataSets:@[set1, set2]];
    d.barWidth = barWidth;

    // make this BarData object grouped
    [d groupBarsFromX:0.0 groupSpace:groupSpace barSpace:barSpace]; // start at x = 0

    return d;
}


-(NSInteger)getWeekOfMonth:(NSString *)strTime{
    if ([strTime intValue]<month_staring_timestamp+7*86400) {
        return 1;
    }
    else if ([strTime intValue]<month_staring_timestamp+04*86400) {
        return 2;
       }
    
    else if ([strTime intValue]<month_staring_timestamp+21*86400) {
        return 3;
    }
    else if ([strTime intValue]<month_staring_timestamp+28*86400) {
         return 4;
    }
    else if ([strTime intValue]<month_staring_timestamp+35*86400) {
         return 5;
    }
    else
        return 0;
}

- (LineChartData *)generateLineData
{

    /// create  xValue
    xVals = [[NSMutableArray alloc] init];

    ///datasets like datasours of table but is charts
    dataSets = [[NSMutableArray alloc] init];

    ///line and dot line here : 2
    for (int i = 0; i < ITEM_COUNT ; i++)
    {
        NSString *passedstring;
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-12-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-12",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-11-"].location != NSNotFound) {

            passedstring=[NSString stringWithFormat:@"%@-11",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
        
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-10-"].location != NSNotFound) {
                        passedstring=[NSString stringWithFormat:@"%@-10",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-09-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-09",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-08-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-08",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-07-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-07",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-06-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-06",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-05-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-05",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
                    }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-04-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-04",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-03-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-03",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-02-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-02",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            }
        
        if ([[[patricipantsArray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-01-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-01",[[[patricipantsArray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
          }
        [xVals addObject:passedstring];
    }
    
    
    
    for (int z = 0; z < 2; z++)
    {
        if (z==1) {
        } else{
            //code for dashed lines
            if(patricipantsArray.count>0)
            {
                NSMutableArray *values = [[NSMutableArray alloc] init];
                for (int i = 0; i < patricipantsArray.count; i++)
                {
                    //// //// ////NSLog(@"%@",temp );(@"%@",patriDisplayArray);
                    float val = [[[patricipantsArray objectAtIndex:i] valueForKey:@"rate"]floatValue] ;
                    NSLog(@"valu is :%2.2f",val);

                    NSString *index;
                    index= [NSString stringWithFormat:@"%d",i+1];

                    NSInteger numberIndex = [self addValuetoIndex:index]-1;
                    NSLog(@"numberIndex is  genrarrrrrrr:%ld",(long)numberIndex);

                    if (val!= 0)
                        if (numberIndex >= 0)
                        {
                            [values addObject:[[ChartDataEntry alloc] initWithX: numberIndex y:val]];
                        }

                }

                if (values.count >0)
                {
                    LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:Nil];
                    d.lineWidth = 1.0f;
                    d.circleRadius = 2.5f;
                    d.drawValuesEnabled = NO;
                    d.drawCircleHoleEnabled = NO;
                    UIColor *color = [UIColor blackColor];
                    [d setColor:color];
                    [d setCircleColor:[UIColor blueColor]];
                    d.fillColor  =[UIColor blueColor];
                    d.fillAlpha  =66/225.f;
                   // d.axisDependency = AxisDependencyLeft;
                    [dataSets addObject:d];

                    [values removeAllObjects];
                }
            }
        }
        
    }
    
    if (dataSets.count > 1 )
    {
        
        ((LineChartDataSet *)dataSets[1]).lineDashLengths = @[@15.f, @5.f];
        [((LineChartDataSet *)dataSets[1]) setCircleColor:[UIColor blueColor]];
        ((LineChartDataSet *)dataSets[1]).circleRadius = 1.5f;
    }
    
    
   // LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    LineChartData *data =[[LineChartData alloc] init];
    [data setDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:3.f]];

    return data;
}

- (LineChartData *)generateLineDataFORPERSONAL
{
    xVals = [[NSMutableArray alloc] init];
    
    dataSets = [[NSMutableArray alloc] init];
    for (int i = 0; i < ITEM_COUNT; i++)
    {
        
        NSString *passedstring;
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-12-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-12",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-11-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-11",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-10-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-10",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-09-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-09",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-08-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-08",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-07-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-07",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-06-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-06",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-05-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-05",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-04-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-04",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-03-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-03",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-02-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-02",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-01-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-01",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        
        [xVals addObject:passedstring];
    }
    
    ///set simulate data
//    NSMutableArray *arrSimulate = [[NSMutableArray alloc] init];
//    for (int i = 0; i < [displayarray count]; i++){
//        [arrSimulate addObject:@"0"];
//    }

    
    //code for solid lines
    if(displayarray.count>0)
    {
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MMM"];
        
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        int previous = -1;
        int previousIndex = -1;
        int drawing = 0; //0: dash - 1:solid
        
        ///we loop displayarray to draw the chart
        for (int i = 0; i < displayarray.count; i++)
        {
            int val = [[[displayarray objectAtIndex:i] valueForKey:@"rate"] intValue]  ;
            NSLog(@"val is :%d ", val);

            
            ////we get the index on xVal
            NSString *index;
            index= [NSString stringWithFormat:@"%d",i+1];

            if(val != 0)
            {

                //   arrIndexPercent = [[NSMutableArray alloc]init];
                //check we change the status as: 0 0 0 ...2: we draw the dash
                if(drawing == 0 && previous!=-1)
                {
                    [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];

                    LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:Nil
                                           ];

                    d.lineWidth = 1.0f;
                    d.circleRadius = 0.0f;
                    d.drawValuesEnabled = NO;
                    d.drawCircleHoleEnabled = NO;
                    UIColor *color = [UIColor blackColor];
                    [d setColor:color];
                    [d setCircleColor:[UIColor blueColor]];
                    d.fillColor  =[UIColor blueColor];
                    d.fillAlpha  =66/225.f;
                   // d.lineDashLengths = @[@5.f, @1.f];
                    [dataSets addObject:d];
                    
                    [values removeAllObjects];
                }
                //change status draw to 1 , it mean we are drawing the solid line
                drawing = 1;


                [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];

//                ChartDataEntry *objChartDataEntry =[[ChartDataEntry alloc] init];
//                objChartDataEntry.x = [self addValuetoIndex:index] - 1;
//                //                            [objChartDataEntry setva]
//
//                [values addObject:objChartDataEntry];
//                [values addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:[self addValuetoIndex:index]-1]];

                previous = val; //[[[displayarray objectAtIndex:i] valueForKey:@"rate"] intValue] ;
                previousIndex = [self addValuetoIndex:index] - 1;
                
                
            }
            else
            {
                if(previous!= -1)///check the first draw
                {
                    //check change the status draw as : 2 3 5 2... 0
                    if (drawing == 1)
                    {
//                        LineChartDataSet *d = [[LineChartDataSet alloc] initWithYVals:values label:[NSString stringWithFormat:@"DataSet %d", 1 + 1]];
                        LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:Nil];

                        d.lineWidth = 1.0f;
                        d.circleRadius = 3.0f;

                        d.drawValuesEnabled = NO;
                        d.drawCircleHoleEnabled = NO;
                        UIColor *color = [UIColor blackColor];
                        [d setColor:color];
                        [d setCircleColor:[UIColor blueColor]];
                        d.fillColor  =[UIColor blueColor];
                        d.fillAlpha  =66/225.f;
                        [dataSets addObject:d];
                        
                        [values removeAllObjects];
                        
                        if(previous!=0)
                        {
//                            ChartDataEntry *objChartDataEntry =[[ChartDataEntry alloc] init];
//                            objChartDataEntry.x = previousIndex;
////                            [objChartDataEntry setva]
//
//                            [values addObject:objChartDataEntry];

//                            [values addObject:[[ChartDataEntry alloc] initWithValue:previous xIndex:previousIndex]];

                            [values addObject:[[ChartDataEntry alloc] initWithX:previousIndex y:previous]];

                            previous = 0;
                        }
                    }
                    drawing = 0;
                }
            }
            
            
            ///draw the last point
            if (i == displayarray.count-1)
            {
//                LineChartDataSet *d = [[LineChartDataSet alloc] initWithYVals:values label:[NSString stringWithFormat:@"DataSet %d", 1 + 1]];

                LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:Nil];

                d.lineWidth = 1.0f;
                d.circleRadius = 3.0f;
                
                d.drawValuesEnabled = NO;
                d.drawCircleHoleEnabled = NO;
                UIColor *color = [UIColor blackColor];
                [d setColor:color];
                [d setCircleColor:[UIColor blueColor]];
                d.fillColor  =[UIColor blueColor];
                d.fillAlpha  =66/225.f;
                [dataSets addObject:d];
                [values removeAllObjects];

                previous =-1;
                previousIndex = -1;
            }
        }
        //}
        
        
        
    }
    
//    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];


    LineChartData *data =[[LineChartData alloc] init];
    [data setDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:3.f]];
    
    
    return data;
    
}

///processs date time to index xVals
-(int)addValuetoIndex:(NSString*)strDate
{
    int index = -1;
    NSString *indexStr  = strDate;
    index = [indexStr intValue];
    return index;
}

- (BarChartData *)generateBarData
{
    BarChartData *d = [[BarChartData alloc] init];

    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    
    //give the value of % and it returns bar chart successfully
    // //// //// ////NSLog(@"%@",temp );(@"%@",percentagerates);
    for (int index = 0; index < percentagerates.count; index++)
    {
        float y=[[percentagerates objectAtIndex:index] floatValue];
        NSString *index2;
        index2= [NSString stringWithFormat:@"%d",index+1];
//        if (y == 0 ) {
//            y = 0;
//        }
//        else
//            y =y + 1;
//        //[entries addObject:[[BarChartDataEntry alloc] initWithValue:y xIndex:[self addValuetoIndex:index2]-1 ] ];
        [entries addObject:[[BarChartDataEntry alloc]initWithX: index   y:y+1]];

//        [chartView.xAxis setCenteredEntries:percentagerates];

    }


//    BarChartDataSet *set = [[BarChartDataSet alloc] initWithYVals:entries label:@"Bar DataSet"];
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithValues:entries label:@"Bar DataSet"];
    [set setColor:[UIColor lightTextColor]];
    set.valueTextColor = [UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f];
    set.valueFont = [UIFont systemFontOfSize:10.f];

    set.axisDependency = AxisDependencyLeft;
    set.drawValuesEnabled =NO;


    [d addDataSet:set];
    return d;
}

- (BubbleChartData *)generateBarData1
{
    
    BubbleChartData *d1 = [[BubbleChartData alloc] init];
    
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    NSMutableArray *datasets = [[NSMutableArray alloc] init];
    
    
    //give the value of % and it returns bar chart successfully
    // //// //// ////NSLog(@"%@",temp );(@"%@",percentagerates);
    for (int i = 0; i < displayarray.count; i++)
    {
        
        
        NSString *passedstring;
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-12-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-12",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-11-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-11",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-10-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-10",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-09-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-09",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-08-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-08",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-07-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-07",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-06-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-06",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-05-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-05",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-04-"].location != NSNotFound) {
            passedstring=[NSString stringWithFormat:@"%@-04",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-03-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-03",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-02-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-02",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
            
        }
        
        if ([[[displayarray objectAtIndex:i]valueForKey:@"date"] rangeOfString:@"-01-"].location != NSNotFound) {
            
            passedstring=[NSString stringWithFormat:@"%@-01",[[[displayarray objectAtIndex:i]valueForKey:@"date"]substringFromIndex:8]];
        }
        
        
        [entries addObject:[NSString stringWithFormat:@"%@",passedstring]];
        
        
    }
    
    
//    BubbleChartData *set = [[BubbleChartData alloc] initWithXVals:entries];
    BubbleChartData *setchart =[[BubbleChartData alloc] initWithDataSets:entries];
//    setchart.x-xVals = entries;
//    setchart.xAxis.valueFormatter = self;//x轴代理 (delegate)
    [datasets addObject:setchart];
    
    [setchart setHighlightCircleWidth:2.0];
    [d1 setDataSets:datasets];
    
    return d1;
}


#pragma mark - ChartViewDelegate


-(void)dailygraph:(NSDate*)passeddate
{
//    displayarray=[[NSMutableArray alloc]initWithArray:arraydatas];

    if ([DELEGATE.isTrac isEqualToString:@"G"])
    {
        DELEGATE.xranges=[patricipantsArray count];
        DELEGATE.str_xvalue=[patricipantsArray count];
        ITEM_COUNT= [patricipantsArray count];
    }
    else{
        DELEGATE.xranges=[displayarray count];
        DELEGATE.str_xvalue=[displayarray count];
        ITEM_COUNT= [displayarray count];
    }
}


-(void)donePressed3
{
    /*
     
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateStyle:NSDateFormatterShortStyle];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *formattedDate = [dateFormatter stringFromDate:_datePicker1.date];
     //  self.txtDob.text = [NSString stringWithFormat:@"%@",formattedDate];
     
     
     
     lbl_dates.text=[[NSString stringWithFormat:@"%@",formattedDate]substringToIndex:10];
     // [patriDisplayArray removeAllObjects];
     
     [self loadViewCharst];
     [self.view endEditing:YES];
     */
}

#pragma mark End Chatsview



-(void)processDataBarChart
{
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MMM"];
    
    
    if ([[[resultDict valueForKey:@"Trac"]valueForKey:@"type"]isEqualToString:@"g"]) {
        arrIndexPercent = [[NSMutableArray alloc]init];
        percentagerates=[[NSMutableArray alloc]init];
        //// //// ////NSLog(@"%@",temp );(@"paticipant rate %lu",(unsigned long)[[[[resultDict valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"]count]);
        for (int g=0; g<[[[[resultDict valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"]count]; g++) {
            
            
            NSString *str=[NSString stringWithFormat:@"%@",[[[[[resultDict valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"] objectAtIndex:g]valueForKey:@"user_count"]] ;
            
            int val = [str intValue];
            // int val = 48;
            int mainTemp;
            
            if (val==0) {
                mainTemp =0;
            }
            
            else
                
                if  (val > 0 && val <= 25)
                {
                    mainTemp =1;
                }
                else if (val <= 50)
                {
                    mainTemp = 2;
                }
                else if (val <= 75)
                {
                    mainTemp = 3;
                }
                else if (val <= 100)
                {
                    mainTemp = 4;
                }
            
            
            
            ///  float temp= mainTemp +mainTemp- 25val*(mainTemp-1)
//            float temp1 =val-25*(mainTemp-1); //change Dhaval here display https://bluewavevision.teamworkpm.net/#tasks/6415436?c=3822095

            float temp1 =val-25*(mainTemp);
            float temp2=temp1/25;
            float temp= mainTemp + temp2;
            
            
            NSString *strIndex = [NSString stringWithFormat:@"%@",[[[[[resultDict valueForKey:@"Trac"] valueForKey:@"graph_data"]valueForKey:@"participant_rates"] objectAtIndex:g]valueForKey:@"date"]];
            
            //            if([strIndex rangeOfString:strMonth].location != NSNotFound)
            //            {
            //Dhaval change here //change Dhaval here display https://bluewavevision.teamworkpm.net/#tasks/6415436?c=3822095

//            if (mainTemp == 0) {
//                temp = 0 ;
//            }
            [percentagerates addObject:[NSString stringWithFormat:@"%f",temp]];
            
            
            NSString *passedstring;
            
            if ([strIndex rangeOfString:@"-12-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-12",[strIndex substringFromIndex:8]];
            }
            
            if ([strIndex rangeOfString:@"-11-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-11",[strIndex substringFromIndex:8]];
            }
        
            if ([strIndex rangeOfString:@"-10-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-10",[strIndex substringFromIndex:8]];

            }
            
            if ([strIndex rangeOfString:@"-09-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-09",[strIndex substringFromIndex:8]];
             }
            
            if ([strIndex rangeOfString:@"-08-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-08",[strIndex substringFromIndex:8]];
             }
            
            if ([strIndex rangeOfString:@"-07-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-07",[strIndex substringFromIndex:8]];
             }
            
            if ([strIndex rangeOfString:@"-06-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-06",[strIndex substringFromIndex:8]];
            }
            
            if ([strIndex rangeOfString:@"-05-"].location != NSNotFound) {
               passedstring=[NSString stringWithFormat:@"%@-05",[strIndex substringFromIndex:8]];
            }
            
            if ([strIndex rangeOfString:@"-04-"].location != NSNotFound) {
               passedstring=[NSString stringWithFormat:@"%@-04",[strIndex substringFromIndex:8]];
            }
            
            if ([strIndex rangeOfString:@"-03-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-03",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-02-"].location != NSNotFound) {
                passedstring=[NSString stringWithFormat:@"%@-02",[strIndex substringFromIndex:8]];
            }
            if ([strIndex rangeOfString:@"-01-"].location != NSNotFound) {
               passedstring=[NSString stringWithFormat:@"%@-01",[strIndex substringFromIndex:8]];
            }
             [arrIndexPercent addObject:passedstring];
            //   }
           }
        // percentagerates
        
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)btncalmessage:(id)sender
{
    UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Please select call or message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Message",@"Call", nil];
    alt.tag=999;
    [alt show];
}

- (IBAction)urlClicked:(UIButton *)sender
{
 //   UIButton *btn = (UIButton *)sender;
    NSString *strLink = [[self.trac_detail_dic objectForKey:@"Trac"] objectForKey:@"website_link"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLink]];
}

-(IBAction)info:(id)sender
{
    if ([Validate isConnectedToNetwork])
    {
        [DELEGATE hidePopup];
        HelpViewController *help_obj=[[HelpViewController alloc]init];
        [self.navigationController pushViewController:help_obj animated:YES];
    }
    
    /*UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to m" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alt show];*/
    
    
}


-(IBAction)Addf:(id)sender
{
    DELEGATE.isFromReview=YES;
    DELEGATE.p_emailArray = [[NSMutableArray alloc]init];
    InvitedParticipated *got_frq=[[InvitedParticipated alloc] initWithNibName:@"InvitedParticipated" bundle:nil];
    DELEGATE.dic_edittrac=[[NSMutableDictionary alloc]initWithDictionary:[self.trac_detail_dic valueForKey:@"Trac"]];
    if ([DELEGATE.isTrac isEqualToString:@"G"])
    {
        DELEGATE.isgroup=NO;
        DELEGATE.ischkFollowers=NO;
    }
    else
    {
        DELEGATE.isgroup=NO;
        DELEGATE.ischkFollowers=YES;
    }
    DELEGATE.isEdit=YES;
    [self.navigationController pushViewController:got_frq animated:YES];
}

-(IBAction)Addp:(id)sender
{
    DELEGATE.isFromReview=YES;
    DELEGATE.isgroup=YES;
    DELEGATE.ischkFollowers=NO;
    DELEGATE.isEdit=YES;
    InvitedParticipated *got_frq=[[InvitedParticipated alloc] initWithNibName:@"InvitedParticipated" bundle:nil];
    DELEGATE.dic_edittrac=[[NSMutableDictionary alloc]initWithDictionary:[self.trac_detail_dic valueForKey:@"Trac"]];
    NSLog(@"%@",[self.trac_detail_dic valueForKey:@"Trac"]);
    [self.navigationController pushViewController:got_frq animated:YES];
}


@end
