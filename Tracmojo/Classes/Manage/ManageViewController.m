//
//  ManageViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 14/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "HelpViewController.h"
#import "Validate.h"
#import "ManageViewController.h"
#import "SKSTableViewCell.h"
#import "UMTableViewCell.h"
#import "PersonalTracs.h"
#import "GroupTrac.h"

@interface ManageViewController ()
@property (nonatomic, weak) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL useCustomCells;
@end

@implementation ManageViewController
{
    int temp;
    int delete_id;
    int cellindex;
    ModelClass *mc;
    UISwitch *switch1;
    
    NSMutableArray *myarray,*grouparray,*followarray;
    NSString *islast_personla,*islast_group,*islast_follow;
        int currentindex;
 int start_personal,start_group,start_follow;
    int lastSelelctedIndex,deleteindex;
    
    int section_int,index_int;
}

- (void)viewDidLoad {

     mc=[[ModelClass alloc]init];
    mc.delegate=self;
      currentindex=0;
    lastSelelctedIndex = -1;
    deleteindex = -1;
    self.useCustomCells = NO;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(toggleCells:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor blueColor];
    
    self.refreshControl = refreshControl;
    
    
    myarray=[[NSMutableArray alloc]init];
    grouparray=[[NSMutableArray alloc]init];
    followarray=[[NSMutableArray alloc]init];
    
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
}


-(void)viewDidDisappear:(BOOL)animated
{
    DELEGATE.isma=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    start_group=0;
    start_follow=0;
    start_personal=0;
    
    if (DELEGATE.isNewTrackSelected)
    {
        DELEGATE.isNewTrackSelected = NO;
        return;
    }
    int start=0;
    currentindex=0;
    lastSelelctedIndex = -1;
     [DELEGATE setKey:@"manage"];
   
    
    if ([Validate isConnectedToNetwork]) {
        if (DELEGATE.isma==NO) {
      
            myarray=[[NSMutableArray alloc]init];
            grouparray=[[NSMutableArray alloc]init];
            followarray=[[NSMutableArray alloc]init];
        
    [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:@"0" PageIndex:[NSString stringWithFormat:@"%d",start] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
        }
    }

}




-(void)didgetResonseAlltracs1:(NSDictionary*)dic
{
    
    if ([[dic objectForKey:@"status"]isEqualToString:@"Success"])
    {

        
        
        for(UIView *element in DELEGATE.tabBarController.tabBar.subviews)
        {
            if ([element isKindOfClass:[UILabel class]]) //check if the object is a UIImageView
            {
                
                
                if (element.tag==666) {
                    
                    [element removeFromSuperview];
                    

                }
                
            }
        }
        
        
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
        v.tag=666;
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
        
        
        
        
        

        
        
        
        if ([dic valueForKey:@"personal_trac"]) {
              islast_personla=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"personal_trac"] valueForKey:@"is_last"]];
            
              [myarray addObjectsFromArray:[[dic objectForKey:@"personal_trac"]valueForKey:@"trac"]];
        }
        
        if ([dic valueForKey:@"group_trac"])
        {
          islast_group=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"group_trac"] valueForKey:@"is_last"]];
            
            [grouparray addObjectsFromArray:[[dic objectForKey:@"group_trac"] valueForKey:@"trac"]];

        }
        

        if ([dic valueForKey:@"following_trac"]) {
            islast_follow=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"following_trac"] valueForKey:@"is_last"]];
            
            
            [followarray addObjectsFromArray:[[dic objectForKey:@"following_trac"]valueForKey:@"trac"]];
            
        }
    
        
        
        [self reloadTableViewWithData2:nil item:index_int section:section_int];
        self.view.userInteractionEnabled=YES;
        
    }
   
 

    
}


- (void)reloadTableViewWithData2:(NSArray *)array item:(int)item section:(int)section
{
  
    
    // Refresh data not scrolling
    [self.tableView refreshData];
    
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row==0&&[myarray count]>0) {
        
        return [myarray count];
    }
    else  if (indexPath.row==1&&[grouparray count]>0) {
        return [grouparray count];
    }
    else  if (indexPath.row==2&&[followarray count]>0) {
        return [followarray count];
    }
    return 0;
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
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil ];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.textColor=[UIColor colorWithRed:0/255.0 green:119/255.0 blue:181/255.0 alpha:1.0];

    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"trac_bg"]];
    
    for (UIView *V in cell.subviews)
    {
        if ([V isKindOfClass:[UIButton class]]) {
            
            if (V.tag==199) {
                 [V removeFromSuperview];
            }
        }
    }
    
    if (indexPath.row==0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        
   
        [button setImage:[UIImage imageNamed:@"add"] forState:normal];
        
        button.tag=199;
        button.accessibilityIdentifier=@"1";
      //  button.backgroundColor=[UIColor redColor];
        if([UIScreen mainScreen].applicationFrame.size.height <= 480){
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-200, 02, 60, 40.0);
        }
        else if ([UIScreen mainScreen].applicationFrame.size.height <= 568)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-200, 02, 60, 40.0);
        }
        else if([UIScreen mainScreen].applicationFrame.size.height <= 667)
        { button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-258, 02, 60, 40.0);
        }
        else if ([UIScreen mainScreen].applicationFrame.size.height <= 736)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-294, 02, 60, 40.0);
        }
        
       cell.textLabel.text=@"manage my tracs";
        
        [cell addSubview:button];
    }
    
    if (indexPath.row==1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.backgroundColor=[UIColor redColor];
        button.tag=199;
          button.accessibilityIdentifier=@"2";
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        
        
        [button setImage:[UIImage imageNamed:@"add"] forState:normal];
        if([UIScreen mainScreen].applicationFrame.size.height <= 480)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-185, 02, 60, 40.0);
        }
        else if ([UIScreen mainScreen].applicationFrame.size.height <= 568)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-180, 02, 60, 40.0);
        }
        else if([UIScreen mainScreen].applicationFrame.size.height <= 667)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-235, 02, 60, 40.0);
        }
        else if ([UIScreen mainScreen].applicationFrame.size.height <= 736)
        {
            button.frame = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-275, 02, 60, 40.0);
        }
        cell.textLabel.text=@"manage group tracs";
         [cell addSubview:button];
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"manage followed tracs";
    }
    
    cell.textLabel.font=Font_Roboto_Medium(15);
    
    

    cell.expandable = YES;
    
    
    
    
    
    return cell;
}


-(void)aMethod:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if ([btn.accessibilityIdentifier isEqualToString:@"1"]) {
        
        PersonalTracs *per=[[PersonalTracs alloc]init];
        
        [DELEGATE.p_emailArray removeAllObjects];
        [DELEGATE.f_emailArray removeAllObjects];
        DELEGATE.isgroup=NO;
        DELEGATE.isEdit=NO;
        DELEGATE.dic_edittrac=nil;

        
        per.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:per animated:YES];
        
        
    }
    
    if ([btn.accessibilityIdentifier isEqualToString:@"2"]) {
        
        GroupTrac *per=[[GroupTrac alloc]init];
        per.isback=YES;
        DELEGATE.isgroup=YES;
        DELEGATE.isEdit=NO;
        DELEGATE.dic_edittrac=nil;
        [DELEGATE.f_emailArray removeAllObjects];
        [DELEGATE.p_emailArray removeAllObjects];
        per.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:per animated:YES];
        
        
    }
    
    
}

- (int)lineCountForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return ceil(size.height / label.font.lineHeight);
    
    
    
    
}

-(BOOL)lineCheckLable : (UILabel *)lable
{
    CGSize size = [lable.text sizeWithFont:lable.font];
    if (size.width > lable.bounds.size.width) {

        return true;
    }
    
    return false;
    
    


}


- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        if ([[myarray objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
        {
            return 70.0f;
        }
        else
        {
            return 60.0f;
        }
    }
    
    else if (indexPath.row==2)
    {
        return 65.0f;
    }
    else{
        return 65.0f;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.useCustomCells)
    {
        UMTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UMCell" forIndexPath:indexPath];
        
        for (UIView *V in cell.subviews)
        {
            if ([V isKindOfClass:[UILabel class]]) {
                
                if (V.tag==98) {
                    [V removeFromSuperview];
                }
            }
            else  if ([V isKindOfClass:[UISwitch class]]) {
                    [V removeFromSuperview];
            }
        }
        
       
        cell.delegate = self;
        cell.tag=indexPath.row;
        
        deleteindex=indexPath.row*100+indexPath.subRow;
        cell.accessibilityIdentifier=[NSString stringWithFormat:@"%d",deleteindex];
        
        cell.textLabel.font=Font_Roboto(13);
        
        if (indexPath.row==0) {
            currentindex=1;
        }
        else if (indexPath.row==1)
        {
            currentindex=2;
        }
        else{
            currentindex=3;
        }
     
        return cell;
    }
    else
    {
        
        SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
        cell=nil;
        if (cell == nil) {
            
            cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
            cell.delegate = self;
        }
        for (UIView *V in cell.cellScrollView.subviews)
        {
            if ([V isKindOfClass:[UILabel class]]) {
                if (V.tag==98) {
                    [V removeFromSuperview];
                }
            }
            else  if ([V isKindOfClass:[UISwitch class]]) {
                    [V removeFromSuperview];
            }
            else  if ([V isKindOfClass:[UIImageView class]]) {
                 [V removeFromSuperview];
            }
        }

        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
      
        UILabel *mainalabel;

        
    if (indexPath.row==0) {


        if ([[myarray objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
        {
            UIButton *businessName = [UIButton buttonWithType:UIButtonTypeCustom];
            businessName.frame = CGRectMake(15, 5,[UIScreen mainScreen].applicationFrame.size.width-95, 20);
            [businessName addTarget:self action:@selector(btnurlClicked:) forControlEvents:UIControlEventTouchUpInside];
            businessName.tag = indexPath.subRow-1;
            
            businessName.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13];
            [businessName setTitle:[[myarray objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] forState:UIControlStateNormal];
            businessName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [businessName setTitleColor: [UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell addSubview:businessName];
            mainalabel = [[UILabel alloc]initWithFrame:CGRectMake(15,
                                                                  15 ,[UIScreen mainScreen].applicationFrame.size.width-100, 48)];

//            
//            int g= [self lineCountForLabel:mainalabel];
//            
//            if (g > 2)
//            {
//                mainalabel = [[UILabel alloc]initWithFrame:CGRectMake(15,
//                                                                      businessName.frame.origin.y + businessName.frame.size.height - 5,[UIScreen mainScreen].applicationFrame.size.width-100, 55)];
//
//            }
//            else
//            {
//
//            }

         
            UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15,69, [UIScreen mainScreen].applicationFrame.size.width, 1)];
            separator.backgroundColor=[UIColor lightGrayColor];
            [cell addSubview:separator];
        }
        else
        {
            mainalabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10,[UIScreen mainScreen].applicationFrame.size.width-100, 48)];
           
            UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15,59, [UIScreen mainScreen].applicationFrame.size.width, 1)];
            separator.backgroundColor=[UIColor lightGrayColor];
            
            [cell addSubview:separator];
        }
        
        

        mainalabel.tag=98;
        mainalabel.numberOfLines=2;
        mainalabel.text = [NSString stringWithFormat:@"%@",[[myarray objectAtIndex:indexPath.subRow-1] valueForKey:@"goal"]];

        mainalabel.font=Font_Roboto(12);
        mainalabel.textColor=[UIColor darkGrayColor];
        
        deleteindex=indexPath.row*100+indexPath.subRow;
        cell.accessibilityIdentifier=[NSString stringWithFormat:@"%d",deleteindex];
        
        [cell.cellScrollView addSubview:mainalabel];
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        playButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-35, 16, 30, 30);
        [playButton setBackgroundImage:[UIImage imageNamed:@"captionDelete"] forState:UIControlStateNormal];
        
        [playButton addTarget:self action:@selector(deleted3:) forControlEvents:UIControlEventTouchUpInside];
        playButton.accessibilityHint=[NSString stringWithFormat:@"%d",indexPath.subRow];
        playButton.tag=indexPath.row;
        
        [cell addSubview:playButton];
        
        UIButton *playButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        playButton2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, 16, 30, 30);
        [playButton2 setBackgroundImage:[UIImage imageNamed:@"edited"] forState:UIControlStateNormal];
        playButton2.accessibilityHint=[NSString stringWithFormat:@"%d",indexPath.subRow];
        playButton.tag=indexPath.row;
        
        [playButton2 addTarget:self action:@selector(edited3:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:playButton2];

        
    }
    else if (indexPath.row==1&&[grouparray count]>0)
    {
        
        
        for (UIView *V in cell.subviews)
        {
            
            if ([V isKindOfClass:[UIButton class]]) {
                
                
                if (V.tag==199)
                    
                
                
                [V removeFromSuperview];
                
            }
        }

        
        
        UILabel *mainalabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5,[UIScreen mainScreen].applicationFrame.size.width-60, 20)];
        mainalabel.tag=98;
        
      
        
        NSString *strName=[NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"name"]];
        
      
          mainalabel.text = strName;
        mainalabel.font=Font_Roboto(12);
        mainalabel.lineBreakMode = YES;
        mainalabel.textColor=[UIColor lightGrayColor];
        ;
        

        
        
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,18,[UIScreen mainScreen].applicationFrame.size.width-90,0)];

        fromLabel.tag=98;
        mainalabel.lineBreakMode = YES;
        fromLabel.text = [NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"goal"]];
        fromLabel.font=Font_Roboto(12);;
        fromLabel.textColor=[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
        fromLabel.numberOfLines=2;
        

        
        int g= [self lineCountForLabel:fromLabel];
        
        
        
        if (g>1) {
            fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,18,[UIScreen mainScreen].applicationFrame.size.width-90,50)];
        }
        else{
        fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,18,[UIScreen mainScreen].applicationFrame.size.width-90,30)];
        }
        
           fromLabel.text = [NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"goal"]];
        fromLabel.tag=98;
        mainalabel.lineBreakMode = YES;
        fromLabel.text = [NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"goal"]];
        fromLabel.font=Font_Roboto(12);;
        fromLabel.textColor=[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
        fromLabel.numberOfLines=2;
        
        
        mainalabel.textColor=[UIColor lightGrayColor];
        fromLabel.textColor=[UIColor darkGrayColor];
        if ([[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"a"] || [[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"p"])
        {
            UISwitch *switch_obj=[[UISwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 14, 49, 30)];
            
            [switch_obj addTarget:self action:@selector(btnSwtichClicked:) forControlEvents:UIControlEventValueChanged];
            
            switch_obj.tag=indexPath.subRow;
            
            cell.accessibilityIdentifier=@"no";

            if ([[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"a"])
            {
                [switch_obj setOn:YES animated:YES];
                mainalabel.textColor=[UIColor lightGrayColor];
                fromLabel.textColor=[UIColor darkGrayColor];

            }
            else if ([[[grouparray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"p"])
            {
                [switch_obj setOn:NO animated:YES];
                mainalabel.textColor=[UIColor redColor];
             
            }
       
            [cell addSubview:switch_obj];

        }
        else{
            cell.accessibilityIdentifier=@"";
            
            UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
            playButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-35, 15, 30, 30);
            [playButton setBackgroundImage:[UIImage imageNamed:@"captionDelete"] forState:UIControlStateNormal];
            
            [playButton addTarget:self action:@selector(deleted3:) forControlEvents:UIControlEventTouchUpInside];
            playButton.accessibilityHint=[NSString stringWithFormat:@"%d",indexPath.subRow];
            playButton.tag=indexPath.row;
            
            [cell addSubview:playButton];
            
            
            
            
            
            UIButton *playButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
            playButton2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, 15, 30, 30);
            [playButton2 setBackgroundImage:[UIImage imageNamed:@"edited"] forState:UIControlStateNormal];
            playButton2.accessibilityHint=[NSString stringWithFormat:@"%d",indexPath.subRow];
            playButton2.tag=indexPath.row;
            
            //NSLog(@"%d",indexPath.row);
            
            
            [playButton2 addTarget:self action:@selector(edited3:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:playButton2];

        }
        
        [cell.cellScrollView addSubview:mainalabel];
        [cell.cellScrollView addSubview:fromLabel];
        UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15, 63, [UIScreen mainScreen].applicationFrame.size.width, 1)];
        separator.backgroundColor=[UIColor lightGrayColor];
        [cell addSubview:separator];

        
        

        
    }
    else if (indexPath.row==2)
    {
        for (UIView *V in cell.cellScrollView.subviews)
        {
            [V removeFromSuperview];
        }
        
        UILabel *mainalabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-75, 20)];
          mainalabel.tag=98;
        if(![[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"group_name"] isEqualToString:@""]){
            mainalabel.text = [NSString stringWithFormat:@"%@ - %@",[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"group_name"],[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"owner_name"]];
        }else{
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15, 5,100, 20);
            
            
            if ([[followarray objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"] != nil)
            {
                NSString *strBussinessname =[[followarray objectAtIndex:indexPath.subRow-1]valueForKey:@"business_name"];
                
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
                
                mainalabel.frame = CGRectMake(button.frame.origin.x + button.frame.size.width, 4,200, 20);
                mainalabel.text =[NSString stringWithFormat:@"%@%@",@"-   ",[[followarray objectAtIndex:indexPath.subRow-1]valueForKey:@"owner_name"] ];
                
                
            }
            else{
                mainalabel.text = [NSString stringWithFormat:@"%@",[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"owner_name"]];
            }
        }
        
        mainalabel.font=Font_Roboto(12);
        mainalabel.textColor=[UIColor lightGrayColor];
        
        
        UILabel *Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20,[UIScreen mainScreen].applicationFrame.size.width-85,0)];
         Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followarray objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
        
        
        
        Sub_headingLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
        Sub_headingLabel.textAlignment = NSTextAlignmentLeft;
        Sub_headingLabel.tag = 10;
        Sub_headingLabel.numberOfLines=2;
        
        Sub_headingLabel.backgroundColor = [UIColor clearColor];
        Sub_headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
     
        
        int g= [self lineCountForLabel:Sub_headingLabel];
        
        
        
        if (g>1) {
        Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20,[UIScreen mainScreen].applicationFrame.size.width-85,50)];
            
        }
        else{
            Sub_headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20,[UIScreen mainScreen].applicationFrame.size.width-85,30)];
        }
        Sub_headingLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
        Sub_headingLabel.textAlignment = NSTextAlignmentLeft;
        Sub_headingLabel.tag = 10;
        Sub_headingLabel.numberOfLines=2;
        
        Sub_headingLabel.backgroundColor = [UIColor clearColor];
        Sub_headingLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
        Sub_headingLabel.text =[NSString stringWithFormat:@"%@",[[followarray objectAtIndex:indexPath.subRow-1]valueForKey:@"goal"]];
        
       [cell addSubview:Sub_headingLabel];

        
        mainalabel.textColor=[UIColor lightGrayColor];
        if ([[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"a"] || [[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"p"])
        {
            UISwitch *switch_obj=[[UISwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 17, 49, 31)];
            [switch_obj addTarget:self action:@selector(btnSwtichClicked:) forControlEvents:UIControlEventValueChanged];
            switch_obj.tag=indexPath.subRow;
            cell.accessibilityIdentifier=@"no";
            
            if ([[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"a"])
            {
                [switch_obj setOn:YES animated:YES];
                mainalabel.textColor=[UIColor lightGrayColor];
                
            }
            else if ([[[followarray objectAtIndex:indexPath.subRow-1] valueForKey:@"request_status"]isEqualToString:@"p"])
            {
                [switch_obj setOn:NO animated:YES];
                mainalabel.textColor=[UIColor redColor];
                
                
            }
            
            [cell addSubview:switch_obj];
            
        }
        else{
            cell.accessibilityIdentifier=@"";
            
           
        }
        
        [cell.cellScrollView addSubview:mainalabel];
        
        
        if (indexPath.row==2||indexPath.row==1) {
            UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15, 69, [UIScreen mainScreen].applicationFrame.size.width, 1)];
            separator.backgroundColor=[UIColor lightGrayColor];
            [cell addSubview:separator];
        }
        else{
            UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(15, 50, [UIScreen mainScreen].applicationFrame.size.width, 1)];
            separator.backgroundColor=[UIColor lightGrayColor];
            [cell addSubview:separator];
        }

    }

    

    cell.tag=indexPath.row;
    cell.accessibilityHint=[NSString stringWithFormat:@"%d",indexPath.subRow];
    
    
    cell.textLabel.font=Font_Roboto(13);
    
   
    if (indexPath.row==0) {
        currentindex=1;
    }
    else if (indexPath.row==1){
        currentindex=2;
    }
    else{
        currentindex=3;
    }


        
        
    return cell;
}
    
    
    
}

-(IBAction)btnurlClicked:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    NSString *strLink = [[myarray objectAtIndex:btn.tag]valueForKey:@"website_link"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLink]];
    
}

-(void)edited3:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    
    
    
    
    

    
    
        
        if (btn.tag==0)
        {
            
            int temp1=[btn.accessibilityHint integerValue]-1;
            
            
            PersonalTracs *gotP=[[PersonalTracs alloc] initWithNibName:@"PersonalTracs" bundle:nil];
            gotP.hidesBottomBarWhenPushed=YES;
            gotP.trac_id=[NSString stringWithFormat:@"%@",[[myarray objectAtIndex:temp1] valueForKey:@"id"]];
            DELEGATE.isEdit=YES;
            DELEGATE.isgroup=NO;
            [self.navigationController pushViewController:gotP animated:YES];
            
            
        }
        
        else if (btn.tag==1)
        {
            

            int temp1=[btn.accessibilityHint integerValue]-1;
            GroupTrac *gotG=[[GroupTrac alloc] initWithNibName:@"GroupTrac" bundle:nil];
            gotG.hidesBottomBarWhenPushed=YES;
            DELEGATE.isEdit=YES;
            DELEGATE.isgroup=YES;
            
            if ([grouparray count]>0) {
                 gotG.trac_id=[NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:temp1] valueForKey:@"id"]];
            }
           
            [self.navigationController pushViewController:gotG animated:YES];
        }
      
    
    
    
}


//delete api results
-(void)deleted3:(id)sender
{
    
    self.view.userInteractionEnabled=NO;
    
    
    UIButton *btn=(UIButton *)sender;
    
    
    
    
    
    if (btn.tag==0) {
        
        cellindex=0;
        temp=[btn.accessibilityHint integerValue]-1;
        delete_id=temp;
        UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to delete this trac?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert_msg.tag=111;
        [alert_msg show];
        
        
    }
    
    else if (btn.tag==1) {
        
        cellindex=1;
        temp=[btn.accessibilityHint integerValue]-1;
        delete_id=temp;
        UIAlertView *alert_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to delete this trac?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert_msg.tag=111;
        [alert_msg show];
        
        
        
    }

    
}


//switch ON OFF
- (void)btnSwtichClicked:(id)sender {
    
    
      self.view.userInteractionEnabled=NO;
    switch1=(UISwitch *)sender;
    
    if (currentindex == 1)
    {
        if (switch1.on)
        {
            [switch1 setOn:YES animated:YES];
            
            if ([Validate isConnectedToNetwork])
            {
              
                
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[myarray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"follow" action_chosen:@"a" selector:@selector(getResponseFromFollowers:)];
            }
        }
        else
        {
            if ([Validate isConnectedToNetwork])
            {
                
                 if ([grouparray count]>switch1.tag-1) {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[myarray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"follow" action_chosen:@"d" selector:@selector(getResponseFromFollowers:)];
                 }
            }
        }
   
    }
    else if (currentindex == 2)
    {
        if (switch1.on)
        {
                      [switch1 setOn:YES animated:YES];
            
            if ([Validate isConnectedToNetwork])
            {
                
                if ([grouparray count]>switch1.tag-1) {
                      [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"participate" action_chosen:@"a" selector:@selector(getResponseFromFollowers:)];
                }
              
            }
        }
        else
        {
            
            
            UIAlertView *alt_view=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to decline?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            alt_view.tag=72;
            [alt_view show];
            

            
            
            
        
        }
        
    }
    else if (currentindex == 3)
    {
        if (switch1.on)
        {
              [switch1 setOn:YES animated:YES];
            
            if ([Validate isConnectedToNetwork])
            {   self.view.userInteractionEnabled=NO;
                 if ([followarray count]>0) {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[followarray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"follow" action_chosen:@"a" selector:@selector(getResponseFromFollowers:)];
                 }
            }
        }
        else
        {
            UIAlertView *alt_view=[[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to decline?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            alt_view.tag=71;
            [alt_view show];
            
            
            
            
            
            
                  }

    }
}

-(void)getResponseFromFollowers:(NSMutableDictionary*)dic
{
    if ([[dic objectForKey:@"status"]isEqualToString:@"Success"])
    {
        
       
        UIAlertView *alt_view=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alt_view.tag=112;
        
        
        [alt_view show];
        
    }
    
}


- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

  
}

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

- (void)undoData
{
    [self reloadTableViewWithData:nil];
    
    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}


- (void)reloadTableViewWithData:(NSArray *)array
{

    [self.tableView refreshData];
    
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

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
}-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
}

#pragma mark - UIRefreshControl Selector

- (void)toggleCells:(UIRefreshControl*)refreshControl
{
    [refreshControl beginRefreshing];
    self.useCustomCells = !self.useCustomCells;
    if (self.useCustomCells)
    {
        self.refreshControl.tintColor = [UIColor yellowColor];
    }
    else
    {
        self.refreshControl.tintColor = [UIColor blueColor];
    }
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

#pragma mark - UIScrollViewDelegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want default white
}



//alertview delegate methods click on OK and CANCEL
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111)
    {
        if (buttonIndex == 1)
        {
            self.view.userInteractionEnabled=YES;
            
        }
        
        if (buttonIndex == 0)
        {
            if (cellindex == 0)
            {
            if ([Validate isConnectedToNetwork])
            {
                [mc deletetrac:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:[[myarray objectAtIndex:temp] valueForKey:@"id"] selector:@selector(deleted1:)];
                [myarray removeObjectAtIndex:temp];
                [self reloadTableViewWithData:nil];
            }
            }
            else if (cellindex == 1)
            {
                if ([Validate isConnectedToNetwork])
                {
                    
                    if([grouparray count])
                    {
                        [mc deletetrac:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:[[grouparray objectAtIndex:temp] valueForKey:@"id"] selector:@selector(deleted1:)];
                        [grouparray removeObjectAtIndex:temp];

                    }
                                [self reloadTableViewWithData:nil];
                }
            }
        }
        else
        {
           
            
            
        }
    }
    else if (alertView.tag == 110)
    {
        if ([Validate isConnectedToNetwork]) {
            myarray=[[NSMutableArray alloc]init];
            grouparray=[[NSMutableArray alloc]init];
            followarray=[[NSMutableArray alloc]init];
            [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:@"0" PageIndex:[NSString stringWithFormat:@"0"] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
        }
        
        [self selecTRAC_deleted];
        
    }
    else if (alertView.tag == 112)
    {
        if ([Validate isConnectedToNetwork]) {
            myarray=[[NSMutableArray alloc]init];
            grouparray=[[NSMutableArray alloc]init];
            followarray=[[NSMutableArray alloc]init];
            [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:@"0" PageIndex:[NSString stringWithFormat:@"0"] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
        }
    }
      else if (alertView.tag == 71)
    
    {
        if (buttonIndex==0) {
            if ([Validate isConnectedToNetwork])
            {
                
                
                
                if ([followarray count]>0) {
                    [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[followarray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"follow" action_chosen:@"d" selector:@selector(getResponseFromFollowers:)];
                }
                
            }

        }
        else{
            [switch1 setOn:YES];
            
        }
        
       
    }
    
      else if (alertView.tag == 72)
          
      {
          if (buttonIndex==0) {
            
                  
                  
                  
                  if ([Validate isConnectedToNetwork])
                  {
                      [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[grouparray objectAtIndex:switch1.tag-1] valueForKey:@"id"]] invitation_type:@"participate" action_chosen:@"d" selector:@selector(getResponseFromFollowers:)];
                  }
              
              
          }
          else{
              [switch1 setOn:YES];
              
          }
          
          
      }

    
}

//api result after delete trac
-(void)deleted1:(NSDictionary *)result
{
    self.view.userInteractionEnabled=YES;
    
    if ([[NSString stringWithFormat:@"%@",[result objectForKey:@"status"]]isEqualToString:@"Success"])
    {
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alt.tag=110;
        [alt show];
    }

    else
    {
//        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alt show];
    }
    
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


//loadmore method
-(void)loadmoredata
{ section_int=currentindex;
    if (currentindex>0) {
        
        if (currentindex==1 && [islast_personla isEqualToString:@"n"]) {
            index_int=start_personal;
            start_personal++;
            
            if ([Validate isConnectedToNetwork])
            {
            [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_personal] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
            }
        }
        
        else    if (currentindex==2 && [islast_group isEqualToString:@"n"]) {
            
                 index_int=start_group;
            start_group++;
            if ([Validate isConnectedToNetwork])
            {
            [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_group] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
            }
        }
        
        else    if (currentindex==3 && [islast_follow isEqualToString:@"n"]) {
            
              index_int=start_follow;
            start_follow++;
            if ([Validate isConnectedToNetwork])
            {
            [mc DashboardfollowedTrac_Useid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] Loadmore:[NSString stringWithFormat:@"%d",currentindex] PageIndex:[NSString stringWithFormat:@"%d",start_follow] ishome:NO selector:@selector(didgetResonseAlltracs1:)];
            }
        }
        
        
        
        
    }
  
}


//help action
-(IBAction)touch_help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *got_help=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [self.navigationController pushViewController:got_help animated:YES];
}

//offline delete trac
-(void)selecTRAC_deleted
{

    [DELEGATE openDatabase];
    sqlite3_stmt *selectStatement;
    NSString* sql;
    if (currentindex == 0)
    {
        sql = [NSString stringWithFormat:@"DELETE from tracmojo where trac_id=%d and trac_type='%@'",delete_id,@"p"];
    }
    else
    {
        sql = [NSString stringWithFormat:@"DELETE from tracmojo where trac_id=%d and trac_type='%@'",delete_id,@"g"];
    }
       if (sqlite3_prepare_v2(DELEGATE.database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(selectStatement)==SQLITE_ROW)
        {
            //////NSLog(@"Record Deleted");
            sqlite3_finalize(selectStatement);
        }
    }
}


//returns line numbers by enter label name only





@end


