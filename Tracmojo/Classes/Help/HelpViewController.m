//
//  HelpViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "HelpViewController.h"
#import "WebviewViewController.h"


@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender
{
    [DELEGATE hidePopup];
    [self.navigationController popViewControllerAnimated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        cell.textLabel.text=@"What is it?";
        cell.detailTextLabel.text=@"So tell me what i can use this for";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"Why?";
        cell.detailTextLabel.text=@"How will it help me?";
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"How?";
        cell.detailTextLabel.text=@"How do I work it!";
    }
    
    
    
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font = Font_Roboto(14);
    cell.detailTextLabel.font = Font_Roboto(11);
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebviewViewController *web_obj=[[WebviewViewController alloc]init];
    
    if (indexPath.row==0) {
        web_obj.str=@"whatisit";
    }
    if (indexPath.row==1) {
        web_obj.str=@"why";
    }
    
    if (indexPath.row==2) {
        web_obj.str=@"how";
    }
    
    
    [self.navigationController pushViewController: web_obj animated:YES];
    
}




@end
