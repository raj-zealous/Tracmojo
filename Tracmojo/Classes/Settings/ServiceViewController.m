//
//  ServiceViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()
{
    int selectindex;
}
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    selectindex=0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor=[UIColor clearColor];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(13, 0,[UIScreen mainScreen].bounds.size.width-20, 62)];
    headerTitle.numberOfLines=2;

    [headerTitle setFont:Font_Roboto(14)];
    if (section==0) {
        headerTitle.text = @"Shown below is the service you currently subscribe to.\nsimply tap on any service to upgrade.";
    }

  
    
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 61, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
    [view addSubview:separatorLineView];
    
    
    headerTitle.backgroundColor=[UIColor clearColor];
     view.backgroundColor=[UIColor whiteColor];

       [view addSubview:headerTitle];
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
    [cell.contentView addSubview:separatorLineView];
    
    if (indexPath.row==0) {
        cell.textLabel.text=@"Basic";
        cell.detailTextLabel.text=@"FREE:create 3 personal tracs & 1 group trac\nwith upto 10 participants;invite followers;join\nor follow unlimited tracs";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"Active";
        cell.detailTextLabel.text=@"$6/year: create unlimited personal tracs & 1\ngroup trac with upto 100 participants; join or\nfollow unlimited tracs";
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"Group - 1";
        cell.detailTextLabel.text=@"$6/month: create unlimited personal tracs & 5\ngroup trac with upto 100 participants; join\nor follow unlimited tracs";
    }
    
    if (indexPath.row==3) {
        cell.textLabel.text=@"Business - 1";
        cell.detailTextLabel.text=@"$20/month: create unlimited personal tracs &\n20 group trac with upto 100 participants;\njoin or follow unlimited tracs";
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == selectindex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }


    
    cell.detailTextLabel.numberOfLines=3;
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font = Font_Roboto(14);
    cell.detailTextLabel.font = Font_Roboto(11);
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        selectindex=0;
    }
    
    else if (indexPath.row==1)
    {
        selectindex=1;
        
    }
    else if (indexPath.row==2)
    {
        selectindex=2;
    }
    else if (indexPath.row==3)
    {
        selectindex=3;
    }
    [tableView reloadData];
    
}



- (void)btnSwtichClicked:(id)sender {
    
 
    
    
}
-(IBAction) btnback:(id)sender
{
    [DELEGATE hidePopup];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
