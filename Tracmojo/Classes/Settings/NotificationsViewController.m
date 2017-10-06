//
//  NotificationsViewController.m
//  Tracmojo
//  krishna
//  Created by Peerbits Solution on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "NotificationsViewController.h"
#import "ModelClass.h"
#import "UIView+Toast.h"
@interface NotificationsViewController ()

@end

@implementation NotificationsViewController
{
    
    UIPickerView *pickerView;
    NSMutableArray *array;
    ModelClass *mc;
    
    
    UIToolbar *mytoolbar1;
    BOOL itstime,areminder,lastchance,everytime,aweekly,everytime1,everytime2;
    
}

- (void)viewDidLoad {
    
    
    _txtfld_time.text=@"0";
    
    
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    
    
    if ([DELEGATE connectedToNetwork]) {
        
        [mc getsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] selector:@selector(getsettins:)];
        
    }
    else{
        
        
        [self.view makeToast:@"Please check your internet connection!"];
        
        
        
    }
    
    
    _tbl_obj.scrollEnabled=NO;
    _tbl_obj.frame=CGRectMake(0, 148, self.view.frame.size.width, 63*11);
  
    
    _scrl_obj.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,  _tbl_obj.frame.size.height+_tbl_obj.frame.origin.y-70);
    
    
    _txtfld_time.textColor=[UIColor lightGrayColor];
    _txtfld_time.font=Font_Roboto(16);
    _txtfld_time.tintColor=[UIColor clearColor];
    
    mytoolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    mytoolbar1.barStyle = UIBarStyleBlack;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self action:@selector(donePressed1)];
    
    
    
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    mytoolbar1.items = [NSArray arrayWithObjects:flexibleSpace,done, nil];
    self.txtfld_time.inputAccessoryView = mytoolbar1;
    
    array=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.backgroundColor=[UIColor whiteColor];
    [pickerView selectRow:12   inComponent:0 animated:YES];
    
    self.txtfld_time.inputView = pickerView;
    
}

-(void)getsettins:(NSDictionary *)result

{
    
    
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
    {
        
        
        if ([[NSString stringWithFormat:@"%@",[result valueForKey:@"notification_preferred_time"]]isEqualToString:@""]) {
            _txtfld_time.text=@"0";
            
        }
        else{
            _txtfld_time.text=[NSString stringWithFormat:@"%@",[result valueForKey:@"notification_preferred_time"]];
            
        }
        
        
        
        [pickerView selectRow:[_txtfld_time.text integerValue]   inComponent:0 animated:YES];
        
        
        if ([[result valueForKey:@"noti_trac_due"]isEqualToString:@"y"]) {
            
            itstime=YES;
            
            
            
        }
        if ([[result valueForKey:@"noti_trac_after_hour"]isEqualToString:@"y"]) {
            areminder=YES;
            
            
        }
        if ([[result valueForKey:@"noti_trac_before_hour"]isEqualToString:@"y"]) {
            lastchance=YES;
            
        }
        
        if ([[result valueForKey:@"noti_followed_trac_rate_done"]isEqualToString:@"y"]) {
            everytime=YES;
            
        }
        
        if ([[result valueForKey:@"noti_followed_trac_weekly_reminder"]isEqualToString:@"y"]) {
            aweekly=YES;
            
        }
        
        
        
        ///
        
        
        
        
        if ([[result valueForKey:@"noti_partcipant_join_leave"]isEqualToString:@"y"]) {
            everytime1=YES;
            
        }
        
        if ([[result valueForKey:@"noti_follower_join_leave"]isEqualToString:@"y"]) {
            everytime2=YES;
            
        }
        
        
        [_tbl_obj reloadData];
        
        
        
        
    }
    else
    {
        
        _txtfld_time.text=@"12";
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [myalert show];
    }
    
    
    
}
-(void)donePressed1
{
    
    if ([DELEGATE connectedToNetwork])
    {
        [mc setsettingsfortime:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_preferred_time:@"notification_preferred_time" value:_txtfld_time.text selector:@selector(settingresult:)];
        
        
    }
    else{
        
        
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Please check your internet connection!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [myalert show];
        
    }
    
    
    
    [self.view endEditing:YES];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [array objectAtIndex:row];
    
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [array count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _txtfld_time.text = [array objectAtIndex:row];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 0;
    }
    
    return 62;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    view.backgroundColor=[UIColor clearColor];
    
    UIImageView *temp_imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"trac_bg"]];
    temp_imageview.frame = CGRectMake(temp_imageview.frame.origin.x,temp_imageview.frame.origin.y,self.view.frame.size.width, temp_imageview.frame.size.height);
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, [UIScreen mainScreen].bounds.size.width-20, 20)];
    
    [headerTitle setTextColor:[UIColor colorWithRed:0.0/255.0 green:103.0/255.0 blue:172.0/255.0 alpha:1.0]];
    [headerTitle setFont:Font_Roboto(16)];
    if (section==0) {
        headerTitle.text = @"Participating trac notifications";
    }
    if (section==1) {
       // headerTitle.text = @"Following trac notifications";
    }
    
    if (section==2) {
        headerTitle.text = @"Trac owner management notifications";
    }
    headerTitle.backgroundColor=[UIColor clearColor];
    //  view.backgroundColor=[UIColor redColor];
    [view addSubview:temp_imageview];
    [view addSubview:headerTitle];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 3;
    }else if (section == 1)
        return 0;
    else{
        return 3;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }
    
    
    if (indexPath.section==1) {
        UIView* separatorLineView;
        
        if (indexPath.row==1) {
            separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 0.5)];
        }
        else{
            separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 0.5)];
        }
        separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
        [cell.contentView addSubview:separatorLineView];
        
        
    }
    else{
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 61, [UIScreen mainScreen].bounds.size.width, 0.5)];
        separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
        [cell.contentView addSubview:separatorLineView];
        
        
        
    }
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"It's time to tracmojo";
            
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"A reminder to tracmojo";
            
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"Last chance to tracmojo";
            
        }
        //cell.detailTextLabel.text=@"change look and feel,turn features on/off,\nconfigure sharing";
        
    }
    
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"Every time a participant rates a trac";
            //cell.textLabel.text=@"Every time a followed trac rate is\ncompleted";
          //  cell.detailTextLabel.text=@"Sent once on a day at the preffered time of\nday";
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"Trac owner management notifications";
            //cell.textLabel.text=@"A weekly reminder to review followed\ntracs";
          //  cell.detailTextLabel.text=@"Sent on a Wednesday(?)";
        }
        cell.textLabel.numberOfLines=2;
        
    }
    
    if (indexPath.section==2) {
        
        if(indexPath.row ==0){
            cell.textLabel.text=@"Every time a participant rates a trac";

        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"Every time a participant joins\nor leaves a trac";
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"Every time a follower joins\nor leaves a trac";
        }
        cell.textLabel.numberOfLines=2;
    }
    
    
    UISwitch *switch_obj=[[UISwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 15, 49, 31)];
    [switch_obj addTarget:self action:@selector(btnSwtichClicked:) forControlEvents:UIControlEventValueChanged];
    switch_obj.tag=indexPath.row+100*indexPath.section;
    
    
    if (itstime&&switch_obj.tag==0) {
        switch_obj.on=YES;
    }
    if (areminder&&switch_obj.tag==1) {
        switch_obj.on=YES;
    }
    if (lastchance&&switch_obj.tag==2) {
        switch_obj.on=YES;
    }
    if (everytime&&switch_obj.tag==100) {
        switch_obj.on=YES;
    }
    if (aweekly&&switch_obj.tag==101) {
        switch_obj.on=YES;
    }
    
    ///
    
    
    
    
    if (everytime1&& switch_obj.tag==200) {
        switch_obj.on=YES;
        
    }
    
    if (everytime2&&switch_obj.tag==201) {
        switch_obj.on=YES;
        
    }
    
    
    
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font = Font_Roboto(14);
    cell.detailTextLabel.font = Font_Roboto(11);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.numberOfLines=2;
    
    [cell addSubview:switch_obj];
    //switch
    
    
    return cell;
    
}

-(IBAction) btnback:(id)sender
{
    [DELEGATE hidePopup];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)settingresult:(NSDictionary *)result

{
    
    [self.view makeToast:[result valueForKey:@"message"]];
    
    
}

- (void)btnSwtichClicked:(id)sender {
    
    UISwitch *switch1=(UISwitch *)sender;
    if ([DELEGATE connectedToNetwork]) {
        
        if(switch1.on){
            
            if (switch1.tag==0) {
                itstime=YES;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_due" value:@"y" selector:@selector(settingresult:)];
                
                
                
            }
            else if (switch1.tag==1) {
                areminder=YES;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_after_hour" value:@"y" selector:@selector(settingresult:)];
                
            }
            else if (switch1.tag==2) {
                lastchance=YES;
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_before_hour" value:@"y" selector:@selector(settingresult:)];
            }
            
            
            else if (switch1.tag==100) {
                everytime=YES;
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_followed_trac_rate_done" value:@"y" selector:@selector(settingresult:)];
                
            }
            
            else if (switch1.tag==101) {
                aweekly=YES;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_followed_trac_weekly_reminder" value:@"y" selector:@selector(settingresult:)];
                
            }
    
            else if (switch1.tag==200) {
                everytime1=YES;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_partcipant_join_leave" value:@"y" selector:@selector(settingresult:)];

            }
            else if (switch1.tag==201) {
                everytime1=YES;
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_follower_join_leave" value:@"y" selector:@selector(settingresult:)];
            }
        }
        else{
            
            if (switch1.tag==0) {
                itstime=NO;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_due" value:@"n" selector:@selector(settingresult:)];
            }
            else if (switch1.tag==1) {
                areminder=NO;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_after_hour" value:@"n" selector:@selector(settingresult:)];
            }
            else if (switch1.tag==2) {
                lastchance=NO;
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_trac_before_hour" value:@"n" selector:@selector(settingresult:)];
            }
            else if (switch1.tag==100) {
                everytime=NO;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_followed_trac_rate_done" value:@"n" selector:@selector(settingresult:)];
            }
            
                else if (switch1.tag==101) {
                aweekly=NO;
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_followed_trac_weekly_reminder" value:@"n" selector:@selector(settingresult:)];
            }
            
            else if (switch1.tag==200) {
                everytime1=NO;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_partcipant_join_leave" value:@"n" selector:@selector(settingresult:)];
                
                
                
            }
            
            else if (switch1.tag==201) {
                everytime1=NO;
                
                [mc setsettings:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] notification_type:@"noti_follower_join_leave" value:@"n" selector:@selector(settingresult:)];
            }
            
            
        }
        
    }
   
    
    
    
    
}
@end
