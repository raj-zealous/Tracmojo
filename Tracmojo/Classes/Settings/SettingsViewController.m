//
//  SettingsViewController.m
//  Tracmojo
// Krishna
//  Created by Peerbits Solution on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "SettingsViewController.h"
#import "NotificationsViewController.h"
#import "AccountViewController.h"
#import "ServiceViewController.h"
#import "HelpViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
   

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    

    
    
    [DELEGATE setKey:@"setting"];
    
    if (DELEGATE.isNewTrackSelected)
    {
        DELEGATE.isNewTrackSelected = NO;
        return;
    }
    
      [self.popup setHidden:NO];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }

    UIImageView *img_arrow=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-40, 11,25, 25)];
    
    img_arrow.image=[UIImage imageNamed:@"ex_arrow.png"];
    [cell.contentView addSubview:img_arrow];
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
    [cell.contentView addSubview:separatorLineView];
    
    if (indexPath.row==0) {
        cell.textLabel.text=@"Notifications & Prompts";
        cell.detailTextLabel.text=@"Control when and what prompts you want to receive";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"Account";
        cell.detailTextLabel.text=@"Review or update your account details";
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"Service";
        cell.detailTextLabel.text=@"Update which service you are subscribed to";
    }
    
    
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font = Font_Roboto(14);
    cell.detailTextLabel.font = Font_Roboto(11);
 
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
   
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        NotificationsViewController *notification_obj=[[NotificationsViewController alloc]init];
        [self.navigationController pushViewController:notification_obj animated:YES];
    }
    
    if (indexPath.row==1) {
        AccountViewController *account_obj=[[AccountViewController alloc]init];
        [self.navigationController pushViewController:account_obj animated:YES];
    }
    if (indexPath.row==2) {
        ServiceViewController *account_obj=[[ServiceViewController alloc]init];
        [self.navigationController pushViewController:account_obj animated:YES];
    }
    
}
-(IBAction)personaltrack:(id)sender
{
    [self.popup setHidden:YES];
}
-(IBAction)grouptrack:(id)sender
{
     [self.popup setHidden:YES];
}
-(IBAction)help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *help_obj=[[HelpViewController alloc]init];
    [self.navigationController pushViewController:help_obj animated:YES];
    
}

@end
