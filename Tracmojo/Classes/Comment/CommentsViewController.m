//
//  CommentsViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 18/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "CommentsViewController.h"
#import "ModelClass.h"
#import "Validate.h"
#import "DarckWaitView.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController
{
    NSMutableArray *comment_array;
    int pager;
    BOOL islast;
    ModelClass *mc;
    BOOL ischeck,ischeck31;
}


-(IBAction)btnChek:(id)sender
{
    if (ischeck) {
        ischeck=NO;
        btnCheckbox.frame=CGRectMake(34, 276, 21, 22);
        [btnCheckbox setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
        
    }
    else{
        ischeck=YES;
        btnCheckbox.frame=CGRectMake(34, 276, 28, 22);
        [btnCheckbox setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
        
    }
}


-(IBAction)btnChek2:(id)sender
{
    if (ischeck31) {
        ischeck31=NO;
        btnCheckbox1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-160, 276, 21, 22);
        [btnCheckbox1 setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
        
    }
    else{
        ischeck31=YES;
        btnCheckbox1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-160, 276, 28, 22);
        [btnCheckbox1 setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
    }
}


-(void)viewDidLoad {
    
    if ([DELEGATE.isTrac isEqualToString:@"F"]) {
        btnTemp.hidden= NO;
    }
    
    if (_isOwner==NO) {
        _btnmail.hidden=YES;
       
    }

    ischeck=NO;
    [btnCheckbox setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
    ischeck31=NO;
    [btnCheckbox1 setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
    
    btn_Message.layer.masksToBounds=YES;
    btn_Message.layer.cornerRadius=3.0;
    
    btn_cancel.layer.masksToBounds=YES;
    btn_cancel.layer.cornerRadius=3.0;
    
    _b1.layer.masksToBounds=YES;
    _b2.layer.masksToBounds=YES;
    
    _b1.layer.cornerRadius=4.0;
    _b2.layer.cornerRadius=4.0;
    
    _lbl1.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"];
    _lbl2.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"];
    
    _viewSendMail.hidden=YES;
    
     [_txtv setText:@"Add comment"];
    islast=0;
    pager=0;
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
    [self.view addSubview:separatorLineView];

    
    
    _btn_send.layer.masksToBounds=YES;
    _btn_send.layer.cornerRadius=4.0;
    comment_array=[[NSMutableArray alloc]init];
    
    
    mc=[[ModelClass alloc]init];
    
    mc.delegate=self;
    [_btn_send setFont:Font_Roboto(15)];
    
    if ([Validate isConnectedToNetwork])
    {
        [mc getcomments:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:[NSString stringWithFormat:@"%@",self.trac_id] pager:[NSString stringWithFormat:@"%d",pager] selector:@selector(getcomments:)];
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)getcomments:(NSDictionary *)result
{
    
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
    {
        if([[result valueForKey:@"is_last"]isEqualToString:@"n"])
        {
            islast=NO;
        }
        else{
            islast=YES;
        }
        
        [comment_array addObjectsFromArray:[result valueForKey:@"comments"]];
  
        [_tbl_obj reloadData];
    }
    else if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"603"])
    {
        _btnmail.hidden=YES;
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alt show];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSIndexPath *)indexPath
{
    

        return [comment_array count];

    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:@"Cell"];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 80, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.font=Font_Roboto(11);
        label.textAlignment = UITextAlignmentRight;
        label.numberOfLines = 0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.text = [[comment_array objectAtIndex:indexPath.row] valueForKey:@"time"];;
        [cell.contentView addSubview:label];
        
        
        if ([[[comment_array objectAtIndex:indexPath.row ]valueForKey:@"is_anonymous"]isEqualToString:@"n"]) {
            cell.textLabel.text=[[comment_array objectAtIndex:indexPath.row ]valueForKey:@"comment_by_name"];
        }
        else{
            cell.textLabel.text=@"Anonymous";
        }
        
        cell.textLabel.textColor=[UIColor colorWithRed:1.0/255.0 green:111.0/255.0 blue:176.0/255.0 alpha:1.0];
        
        cell.textLabel.font=Font_Roboto(14);
        
        
       cell.detailTextLabel.font=Font_Roboto(14);
        cell.detailTextLabel.text=[[comment_array objectAtIndex:indexPath.row] valueForKey:@"comment"];
        
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];

        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, [self texttoheight:[[comment_array objectAtIndex:indexPath.row ]valueForKey:@"comment"]]+19, [UIScreen mainScreen].bounds.size.width, 0.5)];
        separatorLineView.backgroundColor = [UIColor lightGrayColor]; /// may be here is clearColor;
        [cell.contentView addSubview:separatorLineView];

        return cell;
        
    }



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [[comment_array objectAtIndex:indexPath.row] valueForKey:@"comment"];

    
    return  [self texttoheight:text]+20;
}


//textview height returns based on text length
-(float)texttoheight:(NSString *)texts
{

    UITextView *textview_obj=[[UITextView alloc]init];

    textview_obj.frame=CGRectMake(5, 10, 280, 155);
    
    
    CGRect frame = textview_obj.frame;
    
    [ textview_obj setFont:Font_Roboto(14)];
    
    CGSize textViewSize = textview_obj.frame.size;
    frame.size = textViewSize  ;
    
    
    textview_obj.backgroundColor=[UIColor clearColor];
    textview_obj.userInteractionEnabled=NO;
    
    
    textview_obj.text=texts;
    
    
    textview_obj.frame = frame ;
    [textview_obj setTextAlignment:NSTextAlignmentLeft];
    [textview_obj layoutIfNeeded];
    [textview_obj sizeToFit];
    
    
    
  
    
    return textview_obj.frame.size.height;
}

//back button action
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    
    
    
    // Change 10.0 to adjust the distance from bottom
    if (maximumOffset - currentOffset <= 10.0  )
    {
        if ([comment_array count]==0)
        {
            
        }
        else
        {
            
            //this method is called when you load table (10 datas at first time)
            [self loadmoredata];
        }
    }
}


//load more method called when current screen scroll ends
-(void)loadmoredata
{
    if (islast==NO)
    {
        pager++;
        
        if ([Validate isConnectedToNetwork])
        {
                [mc getcomments:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] tracid:self.trac_id pager:[NSString stringWithFormat:@"%d",pager] selector:@selector(getcomments:)];
        }
    }
    

    
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSString *str=[NSString stringWithFormat:@"%@",[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    
    if ([str isEqualToString:@""]) {
        [_txtv setText:@"Add comment"];
        
        [textView setTextColor: [UIColor lightGrayColor]];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Add comment"]) {
        textView.text = @"";
        [textView setTextColor:[UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0]];
    }
    
}


-(IBAction)addcomment:(id)sender
{
    
    scroll_popup.hidden=NO;    
}


//add comments selector
-(void)addcomments:(NSDictionary *)result

{
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
    {
        [_txtv resignFirstResponder];
        [self viewDidLoad];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alt show];
    }

}
-(IBAction)touch_Message:(id)sender
{
    scroll_popup.hidden=NO;
    
    if ([Validate isEmpty:txt_message.text]) {
        UIAlertView *aler_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Please enter message" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [aler_msg show];
        [txt_message becomeFirstResponder];
    }
    else
    {
        
        NSLog(@"Value of hello = %@", DELEGATE.isTrac);
        if ([DELEGATE.isTrac isEqualToString:@"F"])
        {
            [txt_message resignFirstResponder];
            mc=[[ModelClass alloc]init];
            mc.delegate=self;
            if ([Validate isConnectedToNetwork])
            {
                [txt_message resignFirstResponder];
                
                [mc addfollowercomment:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] tracid:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",self.trac_id]] text:[NSString stringWithFormat:@"%@",txt_message.text] selector:@selector(addcomments2:)];
            }
        }
        else
        {
            [txt_message resignFirstResponder];
            mc=[[ModelClass alloc]init];
            mc.delegate=self;
            if ([Validate isConnectedToNetwork])
            {
                [txt_message resignFirstResponder];
                [mc addcomment:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] tracid:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",self.trac_id]] text:[NSString stringWithFormat:@"%@",txt_message.text] ischeck:ischeck ischeck2:ischeck31 selector:@selector(addcomments2:)];
            }
        }
       
    }
}

-(void)addcomments2:(NSDictionary*)dic
{
    if ([[[dic valueForKey:@"code"]stringValue] isEqualToString:@"200"])
    {
        if ([Validate isConnectedToNetwork])
        {
            [self viewDidLoad];
        }
        txt_message.text=nil;
        
    }
    scroll_popup.hidden=YES;
    [txt_message resignFirstResponder];
}


-(IBAction)touch_cancel:(id)sender
{

    
    scroll_popup.hidden=YES;
    [txt_message resignFirstResponder];
}


//send click of sending mail comments
-(IBAction)btnSend:(id)sender
{
    
    [self.view endEditing:YES];
    
    
    if ([self txtEmailValid]) {
        
        
        if ([Validate isConnectedToNetwork])
        {
        
        [mc commentsinmail:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] tracid:[NSString stringWithFormat:@"%@",self.trac_id] email:_txtdlsEmail.text selector:@selector(mailcommentersult:)];
        }
        
    }
    
}

//api result for mail comments
-(void)mailcommentersult:(NSDictionary *)result
{
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
{
    _viewSendMail.hidden=YES;
    [self.view makeToast:[result valueForKey:@"message"]];
    _txtdlsEmail.text=nil;
 }
else
{
    _viewSendMail.hidden=NO;

    [self.view makeToast:[result valueForKey:@"message"]];

}

    
}

//send comments in mail action
-(IBAction)mailcomment:(id)sender
{
    _viewSendMail.hidden=NO;
    
}

//cancel button action to send comments in mail
-(IBAction)btnCancel:(id)sender
{
    [self.view endEditing:YES];
    _viewSendMail.hidden=YES;;
}


//email validations
-(BOOL)txtEmailValid
{
    if ([_txtdlsEmail.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return NO;
    }
    else if(![Validate isValidEmailAddress:_txtdlsEmail.text])
    {
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [myalert show];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
