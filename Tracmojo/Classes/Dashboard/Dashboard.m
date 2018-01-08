//
//  Dashboard.m
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "SBJson.h"
#import "SBJsonUTF8Stream.h"
#import "SBJsonParser.h"
#import "UIView+Toast.h"
#import "Dashboard.h"
#import "PopupView.h"

#import "Validate.h"
#import "SKSTableView.h"
#import "FacebookInstance.h"
#import <GooglePlus/GooglePlus.h>
#import "SKSTableViewCell.h"
#import "tracrate.h"
#import "HelpViewController.h"
#import "tracreview.h"
#import "SettingsViewController.h"
#import <sqlite3.h>

@interface Dashboard ()
{////float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
   
   NSMutableArray *aa,*my_array,*followed_array,*group_array;
   int currentindex;
   NSString *strcount;
   int section_int,index_int;
   int start;
   BOOL ischeckLoadData;
   BOOL isComefromAnnothore ;
   DarckWaitView *drk;
   
   
}
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation Dashboard
{
   //   NSIndexPath *currentindex;
   NSString *islast_personla,*islast_group,*islast_follow;
   
}

- (void)viewDidLoad
{
   isComefromAnnothore = false;

   self.array_personal=[[NSMutableArray alloc] init];
   self.array_followed=[[NSMutableArray alloc] init];
   self.array_group=[[NSMutableArray alloc] init];
   
   if(DELEGATE.Islast==YES)
   {
      DELEGATE.Islast=NO;
      //[[[UIAlertView alloc]initWithTitle:nil message:@"How to use this app? please tap on help icon." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show ];
   }
   
   NSString *currentAppVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
   
   
   if([currentAppVersion  isEqual: @"1.02"]){
      if ([[NSUserDefaults standardUserDefaults]boolForKey:@"IsUpdated"] == FALSE) {
         
         if ([[NSUserDefaults standardUserDefaults]boolForKey:@"IsAlreadyLoggedIn"] == TRUE) {

            GPPSignIn *signOut= [GPPSignIn sharedInstance];
            [signOut signOut];
            
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"time_stemp"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //[self deleteAllData];
            [FacebookInstance logOut];
            [DELEGATE hidePopup];
            //[mc logoutapi:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] selector:@selector(logoutapi:)];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"callInvitation"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IsUpdated"];
            
            
            UserLoginForm *loginform=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
            loginform.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginform animated:FALSE];
         }
      }
      
      
   }
   
   
   //  [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IsUpdated"];
   
   
   
   my_array=[[NSMutableArray alloc]init];
   followed_array=[[NSMutableArray alloc]init];
   group_array=[[NSMutableArray alloc]init];
   
   
   
   mc=[[ModelClass alloc] init];
   mc.delegate=self;
   
   mc1=[[ModelClass alloc] init];
   mc1.delegate=self;
   
   
   self.array_section=[[NSMutableArray alloc] init];
   aa=[[NSMutableArray alloc]init];
   
   _tableView.scrollEnabled = YES;
   [_tableView setBounces:YES];
   
   self.tableView.dataSource = self;
   self.tableView.SKSTableViewDelegate = self;
   
   
   self.navigationItem.title = @"SKSTableView";
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Collapse"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(collapseSubrows)];
   
   [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
   _strID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
   
   
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(IssponseredTracAdded:)
                                                name:@"FireSponseredTrac"
                                              object:nil];
   
   
}

- (void) IssponseredTracAdded:(NSNotification *) notification
{
   
   [self viewWillAppear:true];
   
   //   [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
   
}




-(void)logoutapi:(NSDictionary *)result
{
   
   
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated
{
   ischeckLoadData =  false;
   isComefromAnnothore = true;

   //      [aa removeAllObjects];
}



-(void)viewWillAppear:(BOOL)animated
{
   DELEGATE.isFromReview = FALSE;
      if ([Validate isConnectedToNetwork2]&&DELEGATE.isfinal1==NO)
      {
         drk=[[DarckWaitView alloc]init];
         [drk showWithMessage:nil];
      }
   start_personal = 0;
   start_group = 0;
   start_follow = 0;
   
   //////NSLog(@"%d",DELEGATE.seletedIndex);
   
   
#pragma 15/4
   
   [DELEGATE setKey:@"dash"];
   
   if (DELEGATE.isNewTrackSelected)
   {
      DELEGATE.isNewTrackSelected = NO;
      return;
   }
   my_array=[[NSMutableArray alloc]init];
   
   followed_array=[[NSMutableArray alloc]init];
   group_array=[[NSMutableArray alloc]init];
   self.array_section=[[NSMutableArray alloc] init];
   aa=[[NSMutableArray alloc]init];
   [self performSelectorOnMainThread:@selector(ReloadTable) withObject:nil waitUntilDone:YES];
   
   if (DELEGATE.isAvaiable) {
      
   }
   
   
}
- (IBAction)btnClickSettings:(id)sender {
   
   SettingsViewController *vc = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
   [self.navigationController pushViewController:vc animated:true];
}
    

-(void)ReloadTable
{
   if ([Validate isConnectedToNetwork])
   {
      start=0;
      DELEGATE.isCheckNetWork=NO;
      [mc1 dataSync:_strID timestamp:[[NSUserDefaults standardUserDefaults] valueForKey:@"time_stemp"] selector:@selector(respondstoDataSync:)];
      ischeckLoadData = true;
      isComefromAnnothore = false;
   }
   else
   {
      [drk hide];
      [DELEGATE openDatabase];
      sqlite3_stmt *selectStatement;
      
      
      [self.array_followed removeAllObjects];
      [self.array_group removeAllObjects];
      [self.array_personal removeAllObjects];
      
      
      self.array_ratecolor=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ratecolor"]];
      //////NSLog(@"%@",self.array_ratecolor);
      NSMutableArray *array_followed=[[NSMutableArray alloc] init];
      NSMutableArray *array_group=[[NSMutableArray alloc] init];
      NSMutableArray *array_personal=[[NSMutableArray alloc] init];
      
      
      NSString* sql = [NSString stringWithFormat:@"SELECT * FROM tracmojo"];
      if (sqlite3_prepare_v2(DELEGATE.database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
         while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            
            
            if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"f"])
            {
               NSString *str_follow=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
               [array_followed addObject:[str_follow JSONValue]];
            }
            else if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"p"])
            {
               NSString *str_follow1=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
               [array_personal addObject:[str_follow1 JSONValue]];
               
            }
            else if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"g"])
            {
               NSString *str_follow=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
               [array_group addObject:[str_follow JSONValue]];
               
            }
         }
         
         [self.array_followed addObject:@"followed tracs"];
         
         for (int f=0; f<[array_followed count]; f++) {
            
            //////NSLog(@"%@",[[array_followed objectAtIndex:f] objectForKey:@"Trac"] );
            [self.array_followed addObject:[NSString stringWithFormat:@"%@",[[[array_followed objectAtIndex:f] objectForKey:@"Trac"] objectForKey:@"goal"]]];
            
         }
         [self.array_personal addObject:@"my tracs"];
         for (int f=0; f<[array_personal count]; f++) {
            [self.array_personal addObject:[[[array_personal objectAtIndex:f] objectForKey:@"Trac"] objectForKey:@"goal"]];
            //////NSLog(@"%@",[[[array_personal objectAtIndex:f] objectForKey:@"Trac"] objectForKey:@"goal"]);
            
         }
         [self.array_group addObject:@"group tracs"];
         for (int f=0; f<[array_group count]; f++) {
            [self.array_group addObject:[[[array_group objectAtIndex:f] objectForKey:@"Trac"] objectForKey:@"goal"]];
            
         }
         
         [self.array_section addObject:self.array_personal];
         [self.array_section addObject:self.array_group];
         [self.array_section addObject:self.array_followed];
         
         NSMutableArray *temp=[[NSMutableArray alloc]initWithArray:self.array_section];
         [aa addObject:temp];
         
         self.dic_maintrac=[[NSMutableDictionary alloc]init];
         
         [group_array addObjectsFromArray:array_group];
         [followed_array addObjectsFromArray:array_followed];
         
         [my_array addObjectsFromArray:array_personal];
         
         [self.dic_maintrac setObject:array_personal forKey:@"my tracs"];
         [self.dic_maintrac setObject:array_group forKey:@"group tracs"];
         [self.dic_maintrac setObject:array_followed forKey:@"followed tracs"];
         //////NSLog(@"%@",self.dic_maintrac);
         if([aa count]>0)
         {
            [_tableView reloadData];
            [self reloadTableViewWithData:aa];
         }
         
         
      }
      else
      {
         
      }
      sqlite3_finalize(selectStatement);
      
      [drk hide];
   }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
}

-(void)respondstoDataSync:(NSDictionary*)dic
{
   [mc DashboardfollowedTrac_Useid:_strID Loadmore:@"0" PageIndex:[NSString stringWithFormat:@"%d",start] ishome:YES selector:@selector(didgetResonseAlltracs:)];
   
   if ([[dic objectForKey:@"status"]isEqualToString:@"Success"])
   {
      NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
      
      [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",seconds] forKey:@"time_stemp"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      
      if ([[dic objectForKey:@"following_trac"] count] !=0)
      {
         for (int j=0; j<[[dic objectForKey:@"following_trac"] count]; j++)
         {
            //////NSLog(@"%@",[[dic objectForKey:@"following_trac"] objectAtIndex:j]);
            
            if ([[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"is_deleted"] isEqualToString:@"y"])
            {
               [DELEGATE deletetrac_id:[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"f"];
            }
            else if(![DELEGATE selecttrac_id:[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"f"])
            {
               [DELEGATE updatetrac_id:[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"f"];
            }
            else
            {
               
               [DELEGATE inserttrac_id:[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"following_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"f"];
            }
         }
         
      }
      if ([[dic objectForKey:@"group_trac"] count] !=0)
      {
         
         for (int j=0; j<[[dic objectForKey:@"group_trac"] count]; j++)
         {
            //////NSLog(@"%@",[[dic objectForKey:@"group_trac"] objectAtIndex:j]);
            //////NSLog(@"%@",[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"id"]);
            if ([[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"is_deleted"] isEqualToString:@"y"]) {
               
               [DELEGATE deletetrac_id:[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"g"];
               
            }
            else if(![DELEGATE selecttrac_id:[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"g"])
            {
               [DELEGATE updatetrac_id:[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"g"];
            }
            else
            {
               [DELEGATE inserttrac_id:[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"group_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"g"];
            }
         }
         
      }
      if ([[dic objectForKey:@"personal_trac"] count] !=0)
      {
         for (int j=0; j<[[dic objectForKey:@"personal_trac"] count]; j++)
         {
            //////NSLog(@"%@",[[dic objectForKey:@"personal_trac"] objectAtIndex:j]);
            
            if ([[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"is_deleted"] isEqualToString:@"y"])
            {
               [DELEGATE deletetrac_id:[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"p"];
            }
            else if(![DELEGATE selecttrac_id:[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:@"" trac_type:@"p"])
            {
               [DELEGATE updatetrac_id:[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"p"];
            }
            else
            {
               [DELEGATE inserttrac_id:[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"id"] trac_data:[[[[dic objectForKey:@"personal_trac"] objectAtIndex:j] objectForKey:@"data"] JSONRepresentation] trac_type:@"p"];
            }
         }
         
      }
   }
   //  [DELEGATE inserttrac_id:<#(NSString *)#> trac_data:<#(NSString *)#> trac_type:<#(NSString *)#>];
}

#pragma Touchup
-(IBAction)touch_ratingbutton:(id)sender
{
   
   
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
   [textField resignFirstResponder];
   return  true;
   
}


#pragma Response

-(void)didgetResonseAlltracs:(NSDictionary*)dic
{
   
   
   CGRect frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-45, 0.0, 22, 22);
   UILabel *headingLabel = [[UILabel alloc] initWithFrame:frame];
   headingLabel.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"pending_request_count"]];
   
   headingLabel.textColor = [UIColor whiteColor];
   headingLabel.textAlignment = UITextAlignmentCenter;
   headingLabel.textAlignment = NSTextAlignmentCenter;
   headingLabel.tag = 10;
   headingLabel.backgroundColor = [UIColor clearColor];
   headingLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:12.0];
   headingLabel.hidden = NO;
   headingLabel.lineBreakMode = YES;
   headingLabel.numberOfLines = 0;
   
   UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
   headingLabel.tag=666;
   
   if( [headingLabel.text isEqualToString:@"0"])
      v.image=[UIImage imageNamed:@"badgeGray"];
   else
      v.image=[UIImage imageNamed:@"badge"];
   
   
   v.layer.cornerRadius =v.frame.size.height /2;
   v.layer.masksToBounds = YES;
   v.layer.borderWidth = 0;
   [v setBackgroundColor:[UIColor redColor]];
   [v setAlpha:1.0];
   [DELEGATE.tabBarController.tabBar addSubview:v];
   [DELEGATE.tabBarController.tabBar addSubview:headingLabel];
   
   
   
   
   
   
   
   
   ////////NSLog(@"%@",dic);
   
   
   
   //[self.array_ratecolor removeAllObjects];
   [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"ratecolor"];
   [[NSUserDefaults standardUserDefaults] synchronize];
   
   if ([[dic objectForKey:@"status"]isEqualToString:@"Success"])
   {
      self.array_ratecolor=[[NSMutableArray alloc] init];
      self.array_followed=[[NSMutableArray alloc] init];
      self.array_group=[[NSMutableArray alloc] init];
      self.array_personal=[[NSMutableArray alloc] init];
      //////NSLog(@"%@",[dic objectForKey:@"group_trac"]);
      islast_personla=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"personal_trac"] valueForKey:@"is_last"]];
      
      islast_group=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"group_trac"] valueForKey:@"is_last"]];
      
      islast_follow=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"following_trac"] valueForKey:@"is_last"]];
      
      
      
      [group_array addObjectsFromArray:[[dic objectForKey:@"group_trac"] valueForKey:@"trac"]];
      
      
      [followed_array addObjectsFromArray:[[dic objectForKey:@"following_trac"]valueForKey:@"trac"]];
      
      [my_array addObjectsFromArray:[[dic objectForKey:@"personal_trac"]valueForKey:@"trac"]];
      
      
      self.dic_personltrac=[dic objectForKey:@"following_trac"];
      self.dic_grouptrac=[dic objectForKey:@"group_trac"];
      self.dic_followtrac=[dic objectForKey:@"personal_trac"];
      [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"rate_color"] forKey:@"ratecolor"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      [self.array_ratecolor addObjectsFromArray:[dic objectForKey:@"rate_color"]];
      [self.array_followed addObject:@"followed tracs"];
      for (int f=0; f<[[[dic objectForKey:@"following_trac"] objectForKey:@"trac"] count]; f++) {
         [self.array_followed addObject:[[[[dic objectForKey:@"following_trac"] objectForKey:@"trac"] objectAtIndex:f] objectForKey:@"goal"]];
         
      }
      [self.array_personal addObject:@"my tracs"];
      for (int p=0; p<[[[dic objectForKey:@"personal_trac"] objectForKey:@"trac"] count]; p++) {
         [self.array_personal addObject:[[[[dic objectForKey:@"personal_trac"] objectForKey:@"trac"] objectAtIndex:p] objectForKey:@"goal"]];
         
      }
      [self.array_group addObject:@"group tracs"];
      for (int g=0; g<[[[dic objectForKey:@"group_trac"] objectForKey:@"trac"] count]; g++) {
         [self.array_group addObject:[[[[dic objectForKey:@"group_trac"] objectForKey:@"trac"] objectAtIndex:g] objectForKey:@"goal"]];
         
      }
      [self.array_section addObject:self.array_personal];
      [self.array_section addObject:self.array_group];
      [self.array_section addObject:self.array_followed];
      
      NSMutableArray *temp=[[NSMutableArray alloc]initWithArray:self.array_section];
      [aa addObject:temp];
      
      self.dic_maintrac=[[NSMutableDictionary alloc]init];
      
      [self.dic_maintrac setObject:[[dic objectForKey:@"personal_trac"] objectForKey:@"trac"] forKey:@"my tracs"];
      //////NSLog(@"%@",self.dic_maintrac);
      [self.dic_maintrac setObject:[[dic objectForKey:@"group_trac"] objectForKey:@"trac"] forKey:@"group tracs"];
      [self.dic_maintrac setObject:[[dic objectForKey:@"following_trac"] objectForKey:@"trac"] forKey:@"followed tracs"];
      
      if([aa count]>0)
      {
         [_tableView reloadData];
         [self reloadTableViewWithData:aa];
      }
      if ([Validate isConnectedToNetwork])
      {
         
         if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"callInvitation"]] isEqualToString:@"n"])
         {
            
         }
         else
         {
            [mc Invitation_User_id:_strID selector:@selector(Invitation_Userid:)];
         }
      }
      else{
         [drk hide];
         
      }
   }
   else
   {
      if (dic==nil||![dic objectForKey:@"message"]) {
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
      }
      else
      {
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
      }
      
      
   }
   
   self.view.userInteractionEnabled=YES;
   //    [tablepersonalTrac reloadData];
}


-(void)Invitation_Userid:(NSDictionary *)result
{
   // //////NSLog(@"%@",result);
}

- (void)undoData
{
   [self reloadTableViewWithData:nil];
   
   [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

- (void)reloadTableViewWithData:(NSArray *)array
{
   aa = [[NSMutableArray alloc]initWithArray: array];
   
   // Refresh data not scrolling
   [self.tableView refreshData];
   [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (void)reloadTableViewWithData2:(NSArray *)array item:(int)item section:(int)section
{
   aa = array;
   
   // Refresh data not scrolling
   [self.tableView refreshData];
   
   [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
}


#pragma mark - Helpers

- (void)setDataManipulationButton:(UIBarButtonSystemItem)item
{
   switch (item) {
      case UIBarButtonSystemItemUndo:
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                                                               target:self
                                                                                               action:@selector(undoData)];
         break;
         
      default:
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                               target:self
                                                                                               action:@selector(refreshData)];
         break;
   }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return [aa count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //   if ([aa[section]  count]>3) {
   //
   //      for (int g=4; g<[aa[section]  count]; g++) {
   //         [aa[section]  removeObjectAtIndex:g];
   //
   //      }
   //
   //
   //   }
   
   return [aa[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
   
   if ([aa count]>0) {
      if (indexPath.row==0) {
         //return [my_array count];
         return [aa[indexPath.section][indexPath.row] count] - 1;
      }
      else  if (indexPath.row==1) {
         //return [group_array count];
         return [aa[indexPath.section][indexPath.row] count] - 1;
      }
      else  if (indexPath.row==2) {
         return [aa[indexPath.section][indexPath.row] count] - 1;
         // return [followed_array count];
         
      }
      return 0;
   }
   
   return 0;
   
   
   //
   //    //////NSLog(@"%@",aa[indexPath.section][indexPath.row]);
   //    return [aa[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section == 1 && indexPath.row == 0)
   {
      return YES;
   }
   else if (indexPath.row == currentindex-1)
   {
      return YES;
   }
   
   return NO;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"SKSTableViewCell";
   
   SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
   if (!cell)
      cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   cell.textLabel.font=Font_Roboto_Medium(14);
   cell.textLabel.textColor=[UIColor colorWithRed:0/255.0 green:119/255.0 blue:181/255.0 alpha:1.0];
   
   if ([aa count]>0) {
      cell.textLabel.text = aa[indexPath.section][indexPath.row][0];
      
   }
   cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"trac_bg"]];
   cell.expandable = YES;
   return cell;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
   if (cell == nil) {
      cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
      cell.rightUtilityButtons = [self rightButtons];
      cell.delegate = self;
   }
   
   
   for (UIView *V in cell.subviews)
   {
      if ([V isKindOfClass:[UILabel class]]) {
         [V removeFromSuperview];
      }
      else  if ([V isKindOfClass:[UISwitch class]]) {
         [V removeFromSuperview];
      }
      else  if ([V isKindOfClass:[UIImageView class]]) {
         [V removeFromSuperview];
      }
   }
   
   
   NSString *rate;
   NSString *last_rate;
   BOOL isblink;
   BOOL isURL = NO;
   isblink=NO;
   
   cell.tag=indexPath.subRow;
   if (indexPath.row==0)
   {
      if (DELEGATE.isCheckNetWork)
      {
         last_rate=[NSString stringWithFormat:@"%@",[[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"last_rate"]];
         rate=[NSString stringWithFormat:@"%@",[[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"rate"]];
      }
      else
      {
         if([my_array count]>0)
         {
            last_rate=[NSString stringWithFormat:@"%@",[[my_array objectAtIndex:indexPath.subRow-1] objectForKey:@"last_rate"]];
            rate=[NSString stringWithFormat:@"%@",[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"rate"]];
         }
      }
      //added conditions
      
      if ([rate isEqualToString:@"-1"]&&![last_rate isEqualToString:@""]) {
         rate=last_rate;
         isblink=YES;
      }
      
      
      UILabel *headingLabel;
      
      // change by ritesh
      
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.frame = CGRectMake(15, 5,[UIScreen mainScreen].applicationFrame.size.width-95, 20);
      headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, button.frame.origin.y + button.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85, 0)];
      
      
      if ([[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
      {
         
         [button addTarget:self action:@selector(btnurlClicked:) forControlEvents:UIControlEventTouchUpInside];
         button.tag = indexPath.subRow-1;
         
         button.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13];
         [button setTitle:[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] forState:UIControlStateNormal];
         
         button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         
         NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"]];
         
         [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] range:NSMakeRange(0, titleString.length)];
         
         [button setAttributedTitle: titleString forState:UIControlStateNormal];
         
         [cell addSubview:button];
         
         headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15,[UIScreen mainScreen].applicationFrame.size.width-90, 50)];
         
         //         [cell addSubview:headingLabel];
      }
      else
      {
         headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13.5,[UIScreen mainScreen].applicationFrame.size.width-90, 43)];
      }
      //      UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13.5,[UIScreen mainScreen].applicationFrame.size.width-90, 43)];
      
      if (DELEGATE.isCheckNetWork)
      {
         
         if ([[[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]isEqualToString:@""])
         {
            headingLabel.text =[NSString stringWithFormat:@"%@",[[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"idea_id_name"]];
         }
         else
         {
            headingLabel.text =[NSString stringWithFormat:@"%@",[[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
         }
      }
      else
      {
         if([my_array count]>0)
         {
            headingLabel.text =[NSString stringWithFormat:@"%@",[[my_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
         }
         
      }
      
      //      int g= [self lineCountForLabel:headingLabel];
      //
      //      if (g>1)
      //      {
      //         headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, button.frame.origin.y + button.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-90, 42)];
      //      }
      //      else
      //      {
      //         headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, button.frame.origin.y + button.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-90, 21)];
      //      }
      
      headingLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
      headingLabel.textAlignment = NSTextAlignmentLeft;
      //      headingLabel.backgroundColor = [UIColor redColor];
      headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0];
      headingLabel.hidden = NO;
      
      //        headingLabel.lineBreakMode = YES;
      headingLabel.numberOfLines = 2;
      [cell addSubview:headingLabel];
      UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15,73, [UIScreen mainScreen].applicationFrame.size.width, 1)];
      separator.backgroundColor=[UIColor lightGrayColor];
      [cell addSubview:separator];
      cell.detailTextLabel.textColor=[UIColor clearColor];
   }
   else if (indexPath.row==1)
   {
      if (DELEGATE.isCheckNetWork)
      {
         rate=[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"rate"]];
         
         last_rate=[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"last_rate"]];
      }
      else
         
      {
         if ([group_array count]>0) {
            rate=[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"rate"]];
            last_rate=[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"last_rate"]];
            
         }
         
         
      }
      
      if ([rate isEqualToString:@"-1"]&&![last_rate isEqualToString:@""]) {
         
         isblink=YES;
         rate=last_rate;
      }
      
      UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,[UIScreen mainScreen].applicationFrame.size.width-95, 20)];
      
      
      if (DELEGATE.isCheckNetWork)
      {
         
         if ([[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"group_type"] isEqualToString:@""]) {
            headingLabel.text =[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"group_name"]];
         }
         else
         {
            headingLabel.text =[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"group_name"]];
         }
      }
      else
      {
         if ([group_array count]>0) {
            if ([[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"group_type"] isEqualToString:@""]) {
               headingLabel.text =[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"name"]];
            }
            else
            {
               headingLabel.text =[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"name"]];
            }
            
         }
         
      }
      
      headingLabel.textColor = [UIColor grayColor];
      headingLabel.textAlignment = NSTextAlignmentLeft;
      headingLabel.tag = 10;
      headingLabel.backgroundColor = [UIColor clearColor];
      headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0];
      headingLabel.hidden = NO;
       headingLabel.numberOfLines = 2;
      [cell addSubview:headingLabel];
      
      
      
      UILabel *Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85,0)];
      
      if (DELEGATE.isCheckNetWork)
      {
         Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
      }
      else
      {
         
         
         if ([group_array count]>0) {
            Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
         }
         
      }
      
      
      int g= [self lineCountForLabel:Sub_headingLabel];
      
      
      
      if (g>1) {
         Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85,35)];
      }
      else{
         Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85,30)];
      }
      
      if (DELEGATE.isCheckNetWork)
      {
         Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
      }
      else
      {
         
         if ([group_array count]>0) {
            Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[group_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
         }
         
      }
      Sub_headingLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
      Sub_headingLabel.textAlignment = NSTextAlignmentLeft;
      Sub_headingLabel.tag = 10;
      Sub_headingLabel.backgroundColor = [UIColor clearColor];
      Sub_headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
      Sub_headingLabel.hidden = NO;
      
      Sub_headingLabel.numberOfLines =2;
      [cell addSubview:Sub_headingLabel];
      UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15, 73, [UIScreen mainScreen].applicationFrame.size.width, 1)];
      separator.backgroundColor=[UIColor lightGrayColor];
      [cell addSubview:separator];
      
      
   }
   else if (indexPath.row==2)
   {
      if (DELEGATE.isCheckNetWork)
      {
         
         last_rate=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"last_rate"]];
         rate=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"rate"]];
         
      }
      else
      {
         
         if ([followed_array count]>0) {
            last_rate=[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"last_rate"]];
            
            rate=[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"rate"]];
         }
         
      }
      
      if ([rate isEqualToString:@"-1"]&&![last_rate isEqualToString:@""]) {
         
         isblink=YES;
         rate=last_rate;
         
      }
      
      UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,[UIScreen mainScreen].applicationFrame.size.width-95, 20)];
      UILabel *Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85,0)];
      
      
      Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
      
      int g= [self lineCountForLabel:Sub_headingLabel];
      
      
      if (g>1) {
         Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height ,[UIScreen mainScreen].applicationFrame.size.width-85,35)];
      }
      else{
         Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headingLabel.frame.origin.y+headingLabel.frame.size.height,[UIScreen mainScreen].applicationFrame.size.width-85,30)];
      }
      
      
      Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
      
      
      Sub_headingLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
      Sub_headingLabel.textAlignment = NSTextAlignmentLeft;
      Sub_headingLabel.tag = 10;
      Sub_headingLabel.backgroundColor = [UIColor clearColor];
      Sub_headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
      Sub_headingLabel.hidden = NO;
      
      Sub_headingLabel.numberOfLines = 2;
      
      
      if (DELEGATE.isCheckNetWork)
      {
         if ([[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"type"] isEqualToString:@"g"])
         {
            if ([[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"group_type"] isEqualToString:@""])
            {
               // headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"]];
               
               
               //c change
               headingLabel.text =[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
               //c change finish
               
               
               Sub_headingLabel.text=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
               headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
               
               
            }
            else
            {
               //c change
               
               headingLabel.text =[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
               //c change finish
               
               
               
               Sub_headingLabel.text=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
               
               
               headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
               
            }
            
         }
         
         
         else if(([[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"type"]isEqualToString:@"p"]))
         {
            
            Sub_headingLabel.text=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15, 5,100, 20);
            
            
            if ([[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
            {
               NSString *strBussinessname =[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"];
               
               [button addTarget:self action:@selector(btnurlClicked:) forControlEvents:UIControlEventTouchUpInside];
               button.tag = indexPath.subRow-1;
               button.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13];
               
               [button setTitle:strBussinessname forState:UIControlStateNormal];
               
               button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
               NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:strBussinessname];
               [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] range:NSMakeRange(0, titleString.length)];
               [button setAttributedTitle: titleString forState:UIControlStateNormal];
               [cell addSubview:button];
               
               
               CGSize stringsize = [strBussinessname sizeWithFont:[UIFont systemFontOfSize:14]];
               [button setFrame:CGRectMake(15,5,stringsize.width, stringsize.height)];
               
               headingLabel.frame = CGRectMake(button.frame.origin.x + button.frame.size.width, 3,200, 20);
               headingLabel.text =[NSString stringWithFormat:@"%@%@",@"-   ",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
               
               
            }
            else{
               headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
            }
            
            
            
            
            
         }
      }
      else
      {
         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
         button.frame = CGRectMake(15, 5,100, 20);
         
         if ([[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"group_type"] isEqualToString:@""])
         {
            Sub_headingLabel.text=[NSString stringWithFormat:@"%@",[[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"Trac"] objectForKey:@"goal"]];
            
            
            
            if ([[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
            {
               NSString *strBussinessname =[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"];
               
               [button addTarget:self action:@selector(btnurlClicked:) forControlEvents:UIControlEventTouchUpInside];
               button.tag = indexPath.subRow-1;
               button.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13];
               
               [button setTitle:strBussinessname forState:UIControlStateNormal];
               
               button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
               NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:strBussinessname];
               [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] range:NSMakeRange(0, titleString.length)];
               [button setAttributedTitle: titleString forState:UIControlStateNormal];
               [cell addSubview:button];
               
               
               CGSize stringsize = [strBussinessname sizeWithFont:[UIFont systemFontOfSize:14]];
               [button setFrame:CGRectMake(15,5,stringsize.width, stringsize.height)];
               
               headingLabel.frame = CGRectMake(button.frame.origin.x + button.frame.size.width, 3,200, 20);
               headingLabel.text =[NSString stringWithFormat:@"%@%@",@"-   ",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
               
               
            }
            else{
               headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
            }
            
            
            
            
         }
         else
         {
            //headingLabel.text=[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]objectForKey:@"owner_name"]];
            
            //c change
            
            headingLabel.text = [NSString stringWithFormat:@"%@ - %@",[[followed_array objectAtIndex:indexPath.subRow-1] valueForKey:@"group_name"],[[followed_array objectAtIndex:indexPath.subRow-1] valueForKey:@"owner_name"]];
            
            
            //c change finish
            
            Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
         }
         
      }
      
      headingLabel.textColor = [UIColor grayColor];
      headingLabel.textAlignment = NSTextAlignmentLeft;
      headingLabel.tag = 10;
      headingLabel.backgroundColor = [UIColor clearColor];
      headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0];
      headingLabel.hidden = NO;
      headingLabel.lineBreakMode = YES;
      headingLabel.numberOfLines = 2;
      
      
      
      Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followed_array objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"] ];
      
      [cell addSubview:headingLabel];
      [cell addSubview:Sub_headingLabel];
      
      UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15, 73, [UIScreen mainScreen].applicationFrame.size.width, 1)];
      separator.backgroundColor=[UIColor lightGrayColor];
      [cell addSubview:separator];
      
      
   }
   
   UIButton *ratebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   ratebutton.tag=indexPath.subRow-1;
   
   [ratebutton setFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-52,20, 55, 35)];
   
   
   [ratebutton addTarget:self action:@selector(touchcolorrate:) forControlEvents:UIControlEventTouchUpInside];
   
   ratebutton.layer.cornerRadius=ratebutton.frame.size.height /2;
   ratebutton.layer.masksToBounds=YES;
   cell.accessoryView = ratebutton;
   
   
   
#pragma 15/4
   
   
   
   
   for (int h=0; h<[_array_ratecolor count]; h++)
   {
      
      [ratebutton setBackgroundColor:[UIColor clearColor]];
      if ([last_rate isEqualToString:@"5"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate1.png"] forState:UIControlStateNormal];
      }
      else if ([last_rate isEqualToString:@"4"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate2"] forState:UIControlStateNormal];
      }
      else if ([last_rate isEqualToString:@"3"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate3.png"] forState:UIControlStateNormal];
      }
      else if ([last_rate isEqualToString:@"2"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate4.png"] forState:UIControlStateNormal];
      }
      else if ([last_rate isEqualToString:@"1"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate5.png"] forState:UIControlStateNormal];
      }
      else if ([last_rate isEqualToString:@"0"])
      {
         [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate.png"] forState:UIControlStateNormal];
      }
      
      
      if ([rate isEqualToString:@"-1"]||isblink==YES) {
         
         ratebutton.alpha=0.0;
         
         
         if (indexPath.row != 2) {
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                NSString *str1 = [NSString stringWithFormat:@"%@",[[self.array_ratecolor  objectAtIndex:h] objectForKey:@"rgb"]];
                                NSMutableArray *myArray=[[NSMutableArray alloc] init];
                                [myArray addObject:[str1 componentsSeparatedByString:@","][0]];
                                [myArray addObject:[str1 componentsSeparatedByString:@","][1]];
                                [myArray addObject:[str1 componentsSeparatedByString:@","][2]];
                                
                                if (isblink) {
                                   
                                   
                                   if ([last_rate isEqualToString:@"5"])
                                   {
                                      [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate1.png"] forState:UIControlStateNormal];
                                   }
                                   else if ([last_rate isEqualToString:@"4"])
                                   {
                                      [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate2"] forState:UIControlStateNormal];
                                   }
                                   else if ([last_rate isEqualToString:@"3"])
                                   {
                                      [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate3.png"] forState:UIControlStateNormal];
                                   }
                                   else if ([last_rate isEqualToString:@"2"])
                                   {
                                      [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate4.png"] forState:UIControlStateNormal];
                                   }
                                   else if ([last_rate isEqualToString:@"1"])
                                   {
                                      [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate5.png"] forState:UIControlStateNormal];
                                   }}
                                else{
                                   [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate.png"] forState:UIControlStateNormal];
                                }
                                
                                
                                ratebutton.alpha=1.0;
                                
                             }
                             completion:^(BOOL finished){
                             }];
            
         }
         else
            
         {
            [ratebutton setBackgroundImage:[UIImage imageNamed:@"s_rate.png"] forState:UIControlStateNormal];
         }
         
      }
      
      
   }
   
   
   
   if (indexPath.row==0) {
      //  cell.tag=0;
      currentindex=1;
      
   }
   else if (indexPath.row==1)
   {
      //  cell.tag=1;
      currentindex=2;
   }
   else{
      //  cell.tag=2;
      currentindex=3;
   }
   
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
   return cell;
}
//


-(IBAction)btnurlClicked:(id)sender
{
   
   UIButton *btn = (UIButton *)sender;
   NSString *strLink = [[my_array objectAtIndex:btn.tag]valueForKey:@"website_link"];
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLink]];
   
}

-(IBAction)touchcolorrate:(id)sender
{
   
   DELEGATE.isyPlus=NO;
   UIButton *btn_tag=(UIButton*)sender;
   
   if (currentindex == 1)
   {
      if([my_array count] == 0)
      {
         return;
      }
      if (DELEGATE.isAvaiable)
      {
         if ([[[my_array objectAtIndex:btn_tag.tag] objectForKey:@"rate"] isEqualToString:@"-1"])
         {
            tracrate *trac=[[tracrate alloc] initWithNibName:@"tracrate" bundle:nil];
            trac.dic_rate=[my_array objectAtIndex:btn_tag.tag];
            DELEGATE.isgroup=NO;
            [self.navigationController pushViewController:trac animated:YES];
            
         }
         else
         {
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            DELEGATE.isTrac=@"P";
            got_tracreview.trac_id=[[my_array objectAtIndex:btn_tag.tag] objectForKey:@"id"];
            [self.navigationController pushViewController:got_tracreview animated:YES];
         }
      }
      else
      {
         if ([[[[my_array objectAtIndex:btn_tag.tag] objectForKey:@"Trac"] objectForKey:@"rate"] isEqualToString:@"-1"])
         {
            
            [self.view makeToast:@"Please check your internet"];
         }
         else
         {
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            DELEGATE.isTrac=@"P";
            got_tracreview.trac_id=[[[my_array objectAtIndex:btn_tag.tag] objectForKey:@"Trac"] objectForKey:@"id"];
            [self.navigationController pushViewController:got_tracreview animated:YES];
            
         }
      }
   }
   
   
   else if (currentindex == 2)
   {
      
      if (DELEGATE.isAvaiable)
      {
         
         if([group_array count] == 0)
         {
            return;
         }
         if([[ NSString stringWithFormat:@"%@",[[group_array objectAtIndex:btn_tag.tag] objectForKey:@"rate"]] isEqualToString:@"-1"])
         {
            tracrate *trac=[[tracrate alloc] initWithNibName:@"tracrate" bundle:nil];
            trac.dic_rate=[group_array objectAtIndex:btn_tag.tag];
            DELEGATE.isgroup=YES;
            [self.navigationController pushViewController:trac animated:YES];
            
         }
         else
         {
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            DELEGATE.isTrac=@"G";
            got_tracreview.trac_id=[[group_array objectAtIndex:btn_tag.tag] objectForKey:@"id"];
            [self.navigationController pushViewController:got_tracreview animated:YES];
         }
         
      }
      else
      {
         if([[[[group_array objectAtIndex:btn_tag.tag] objectForKey:@"Trac"] objectForKey:@"rate"] isEqualToString:@"-1"])
         {
            [self.view makeToast:@"Please check your internet"];
         }
         else
         {
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            DELEGATE.isTrac=@"G";
            got_tracreview.trac_id=[[[group_array objectAtIndex:btn_tag.tag] objectForKey:@"Trac"] objectForKey:@"id"];
            [self.navigationController pushViewController:got_tracreview animated:YES];
         }
         
      }
      
   }
   
   else{
      {
         if (DELEGATE.isAvaiable)
         {
            
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            if ([followed_array count]>0)
            {
               NSString *str_type = [[followed_array objectAtIndex:btn_tag.tag] objectForKey:@"group_type"];
               if([str_type isEqualToString:@""]){
                  DELEGATE.isTrac=@"F";
               }
               else{
                  DELEGATE.isTrac=@"F";
                  
               }
            }
            
            
            if ([followed_array count]>0) {
               got_tracreview.trac_id=[[followed_array objectAtIndex: btn_tag.tag] objectForKey:@"id"];
            }
            DELEGATE.isgroup=YES;
            [self.navigationController pushViewController:got_tracreview animated:YES];
         }
         else
         {
            
            tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
            DELEGATE.isTrac=@"F";
            got_tracreview.trac_id=[[[followed_array objectAtIndex: btn_tag.tag] objectForKey:@"Trac"] objectForKey:@"id"];
            [self.navigationController pushViewController:got_tracreview animated:YES];
         }
      }
   }
}

-(CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 50.0f;
   
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row==0)
   {
      return 70.0f;
   }
   
   else{
      return 75.0f;
   }
   
}

#pragma mark - Actions

- (void)collapseSubrows
{
   [self.tableView collapseCurrentlyExpandedIndexPaths];
}

- (void)refreshData
{
   NSArray *array = @[
                      @[
                         @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                         @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                         @[@"Section0_Row2"]
                         ]
                      ];
   [self reloadTableViewWithData:array];
   [self setDataManipulationButton:UIBarButtonSystemItemUndo];
   
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
   
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
   NSInteger currentOffset = scrollView.contentOffset.y;
   NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
   
   // Change 10.0 to adjust the distance from bottom
   if (maximumOffset - currentOffset <= 10.0  ) {
      [self loadmoredata];
      
   }
}


-(void)loadmoredata
{
   if(currentindex>0) {
      
      section_int=currentindex;
      if (currentindex==1 && [islast_personla isEqualToString:@"n"]) {
         index_int=start_personal;
         
         start_personal++;
         
         if ([Validate isConnectedToNetwork])
         {
            
            [mc DashboardfollowedTrac_Useid:_strID Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_personal] ishome:YES selector:@selector(loadmoredata:)];
         }
         else{
            [drk hide];
            
         }
      }
      
      
      else  if (currentindex==2 && [islast_group isEqualToString:@"n"]) {
         
         start_group++;
         index_int=start_group;
         
         if ([Validate isConnectedToNetwork])
         {
            [mc DashboardfollowedTrac_Useid:_strID Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_group] ishome:YES selector:@selector(loadmoredata:)];
         }
         else{
            [drk hide];
            
         }
      }
      
      else  if (currentindex==3 && [islast_follow isEqualToString:@"n"]) {
         
         
         start_follow++;
         index_int=start_follow;
         
         if ([Validate isConnectedToNetwork])
         {
            [mc DashboardfollowedTrac_Useid:_strID Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_follow] ishome:YES selector:@selector(loadmoredata:)];
         }
         else{
            [drk hide];
            
         }
      }
   }
}


-(void)loadmoredata:(NSDictionary *)dic
{
   ////////NSLog(@"%@",dic);
   
   self.array_followed=[[NSMutableArray alloc] init];
   self.array_group=[[NSMutableArray alloc] init];
   self.array_personal=[[NSMutableArray alloc] init];
   
   if([[dic objectForKey:@"status"]isEqualToString:@"Success"])
   {
      if ([dic objectForKey:@"personal_trac"]) {
         islast_personla=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"personal_trac"] valueForKey:@"is_last"]];
         self.dic_followtrac=[[dic objectForKey:@"personal_trac"] valueForKey:@"trac"];
         
         [my_array addObjectsFromArray:[[dic objectForKey:@"personal_trac"] valueForKey:@"trac"]];
         [[[aa objectAtIndex:0] objectAtIndex:0]addObjectsFromArray:[[[dic objectForKey:@"personal_trac"] valueForKey:@"trac"] valueForKey:@"goal"]];
         
      }
      
      if ([dic objectForKey:@"group_trac"]) {
         
         islast_group=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"group_trac"] valueForKey:@"is_last"]];
         
         self.dic_followtrac=[[dic objectForKey:@"group_trac"] valueForKey:@"trac"];
         
         [group_array addObjectsFromArray:[[dic objectForKey:@"group_trac"] valueForKey:@"trac"]];
         
         
         
         
         
         if ([aa count]>0) {
            
            [[[aa objectAtIndex:0] objectAtIndex:1]addObjectsFromArray:[[[dic objectForKey:@"group_trac"] valueForKey:@"trac"] valueForKey:@"goal"]];
         }
      }
      
      
      if ([dic objectForKey:@"following_trac"]) {
         
         islast_follow=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"following_trac"] valueForKey:@"is_last"]];
         self.dic_followtrac=[[dic objectForKey:@"following_trac"] valueForKey:@"trac"];
         [followed_array addObjectsFromArray:[[dic objectForKey:@"following_trac"] valueForKey:@"trac"]];
         [[[aa objectAtIndex:0] objectAtIndex:2]addObjectsFromArray:[[[dic objectForKey:@"following_trac"] valueForKey:@"trac"] valueForKey:@"goal"]];
      }
      
      if([aa count]>0)
      {
         
         [self reloadTableViewWithData2:aa item:index_int section:section_int];
         
         
      }
      
   }
   else
   {
      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
      [alert show];
   }
   //    [tablepersonalTrac reloadData];
}


- (IBAction)btnLogoutClicked:(id)sender
{
   
   UIAlertView *alert_logout=[[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
   alert_logout.tag=102;
   [alert_logout show];
   
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
         [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"login"];
         [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"callInvitation"];
         [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userID"];
         [[NSUserDefaults standardUserDefaults]synchronize];
         UserLoginForm *loginform=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
         loginform.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:loginform animated:YES];
      }
   }
   
}

-(IBAction)help:(id)sender
{
   
   if ([Validate isConnectedToNetwork])
   {
      [DELEGATE hidePopup];
      HelpViewController *help_obj=[[HelpViewController alloc]init];
      [self.navigationController pushViewController:help_obj animated:YES];
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

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
   switch (state) {
      case 0:
         NSLog(@"utility buttons closed");
         break;
      case 1:
         NSLog(@"left utility buttons open");
         break;
      case 2:
         NSLog(@"right utility buttons open");
         break;
      default:
         break;
   }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
   switch (index) {
      case 0:
         //////NSLog(@"left button 0 was pressed");
         break;
      case 1:
         //////NSLog(@"left button 1 was pressed");
         break;
      case 2:
         //////NSLog(@"left button 2 was pressed");
         break;
      case 3:
         //////NSLog(@"left btton 3 was pressed");
      default:
         break;
   }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
   
}



- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
   // allow just one cell's utility button to be open at once
   return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
   
   DELEGATE.isyPlus=NO;
   switch (state) {
      case 1:
         return NO;
         break;
      case 2:
         if (currentindex == 1)
         {
            if (DELEGATE.isAvaiable)
            {
               
               if ([my_array count]>0) {
                  if ([[[my_array objectAtIndex: cell.tag-1] objectForKey:@"rate"] isEqualToString:@"-1"])
                  {
                     tracrate *trac=[[tracrate alloc] initWithNibName:@"tracrate" bundle:nil];
                     
                     //////NSLog(@"%d",cell.tag);
                     
                     trac.dic_rate=[my_array objectAtIndex: cell.tag-1];
                     DELEGATE.isgroup=NO;
                     [self.navigationController pushViewController:trac animated:YES];
                  }
                  else
                  {
                     tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                     DELEGATE.isTrac=@"P";
                     got_tracreview.trac_id=[[my_array objectAtIndex: cell.tag-1] objectForKey:@"id"];
                     [self.navigationController pushViewController:got_tracreview animated:YES];
                  }
                  
               }
               
            }
            else
            {
               if ([[[[my_array objectAtIndex: cell.tag] objectForKey:@"Trac"] objectForKey:@"rate"] isEqualToString:@"-1"])
               {
                  [self.view makeToast:@"Please check your internet"];
               }
               else
               {
                  tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                  DELEGATE.isTrac=@"P";
                  got_tracreview.trac_id=[[[my_array objectAtIndex: cell.tag-1] objectForKey:@"Trac"] objectForKey:@"id"];
                  [self.navigationController pushViewController:got_tracreview animated:YES];
               }
               
            }
            return YES;
         }
         else if (currentindex == 2)
         {
            
            if (DELEGATE.isAvaiable)
            {
               if ([[[group_array objectAtIndex: cell.tag-1] objectForKey:@"rate"] isKindOfClass:[NSString class]]) {
                  if([[[group_array objectAtIndex: cell.tag-1] objectForKey:@"rate"] isEqualToString:@"-1"])
                  {
                     tracrate *trac=[[tracrate alloc] initWithNibName:@"tracrate" bundle:nil];
                     trac.dic_rate=[group_array objectAtIndex: cell.tag-1];
                     DELEGATE.isgroup=YES;
                     [self.navigationController pushViewController:trac animated:YES];
                     
                  }
                  else
                  {
                     tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                     //////NSLog(@"%@",[group_array objectAtIndex: cell.tag-1] );
                     DELEGATE.isTrac=@"G";
                     got_tracreview.trac_id=[[group_array objectAtIndex: cell.tag-1] objectForKey:@"id"];
                     [self.navigationController pushViewController:got_tracreview animated:YES];
                  }
               }
               else{
                  tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                  //////NSLog(@"%@",[group_array objectAtIndex: cell.tag-1] );
                  DELEGATE.isTrac=@"G";
                  got_tracreview.trac_id=[[group_array objectAtIndex: cell.tag-1] objectForKey:@"id"];
                  [self.navigationController pushViewController:got_tracreview animated:YES];
                  
               }
               
            }
            else
            {
               if([[[[group_array objectAtIndex: cell.tag-1] objectForKey:@"Trac"] objectForKey:@"rate"] isEqualToString:@"-1"])
               {
                  [self.view makeToast:@"Please check your internet"];
                  
               }
               else
               {
                  tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                  
                  DELEGATE.isTrac=@"G";
                  got_tracreview.trac_id=[[[group_array objectAtIndex: cell.tag-1] objectForKey:@"Trac"] objectForKey:@"id"];
                  [self.navigationController pushViewController:got_tracreview animated:YES];
               }
               
            }
            return YES;
         }
         
         
         else{
            {
               if (DELEGATE.isAvaiable)
               {
                  
                  tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                  DELEGATE.isTrac=@"F";
                  got_tracreview.trac_id=[[followed_array objectAtIndex: cell.tag-1] objectForKey:@"id"];
                  [self.navigationController pushViewController:got_tracreview animated:YES];
               }
               else
               {
                  tracreview *got_tracreview=[[tracreview alloc] initWithNibName:@"tracreview" bundle:nil];
                  DELEGATE.isTrac=@"F";
                  got_tracreview.trac_id=[[[followed_array objectAtIndex: cell.tag-1] objectForKey:@"Trac"] objectForKey:@"id"];
                  [self.navigationController pushViewController:got_tracreview animated:YES];
               }
               
               return YES;
            }
         }
         
         return NO;
         break;
      default:
         break;
         
   }
   
   return YES;
}


- (int)lineCountForLabel:(UILabel *)label {
   CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
   CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
   
   return ceil(size.height / label.font.lineHeight);
}


- (NSArray *)rightButtons
{
   NSMutableArray *rightUtilityButtons = [NSMutableArray new];
   [rightUtilityButtons sw_addUtilityButtonWithColor:
    [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                               title:@"edited"];
   [rightUtilityButtons sw_addUtilityButtonWithColor:
    [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                               title:@"deleted"];
   
   return rightUtilityButtons;
}



@end
