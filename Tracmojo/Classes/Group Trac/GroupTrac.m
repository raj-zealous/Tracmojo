//
//  GroupTrac.m
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "GroupTrac.h"
#import "ModelClass.h"
#import "HelpViewController.h"
#import "setFrequncyViewController.h"
#import "Validate.h"

@interface GroupTrac ()

@end

@implementation GroupTrac
{
    ModelClass *mc;
        UIPickerView *picker1,*picker2;
      UIToolbar *mytoolbar1;
      UIToolbar *mytoolbar2;
    NSString *str_group,*str_wording,*str_rateid,*str_typeid;
    
    
}

- (void)viewDidLoad {
    
    
    _txt_type.tintColor=[UIColor clearColor];
     _txt_ratewording.tintColor=[UIColor clearColor];

    [_txt_tracdetail setText:@"Enter your trac here"];
    
    
    [_txt_tracdetail setTextColor:[UIColor lightGrayColor]];
//     self.txt_tracdetail.delegate = self;
    _lbl_header.font=Font_Roboto_Medium(15);
    _lbl_rates.font=Font_Roboto_Medium(15);
    _lbl_reference.font=Font_Roboto_Medium(15);
    _lbl_type.font=Font_Roboto_Medium(15);
    _lbl_custom.font=Font_Roboto_Medium(15);
    
    
    _scrl_obj.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 600);
    
    picker1 = [[UIPickerView alloc] init];
    picker1.delegate = self;
    
    picker2 = [[UIPickerView alloc] init];
    picker2.delegate = self;
    
    picker1.backgroundColor=[UIColor whiteColor];
    picker2.backgroundColor=[UIColor whiteColor];
    
    _txt_type.inputView = picker1;
      _txt_ratewording.inputView = picker2;
    
    mytoolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    mytoolbar1.barStyle = UIBarStyleBlack;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self action:@selector(donePressed1)];
  
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    mytoolbar1.items = [NSArray arrayWithObjects:flexibleSpace,done, nil];
    self.txt_type
    .inputAccessoryView = mytoolbar1;
    
    
    mytoolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    mytoolbar2.barStyle = UIBarStyleBlack;
    
    UIBarButtonItem *done2 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self action:@selector(donePressed2)];
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    mytoolbar2.items = [NSArray arrayWithObjects:flexibleSpace1,done2, nil];
    self.txt_ratewording.inputAccessoryView = mytoolbar2;

    if(DELEGATE.isEdit)
    {
        if ([Validate isConnectedToNetwork])
        {
            mc=[[ModelClass alloc] init];
            mc.delegate=self;
            [mc GettracDetail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:self.trac_id selector:@selector(didgetResponserSelectedTrac:)];
        }
    }

    // Do any additional setup after loading the view from its nib.
}
#define MAX_LENGTH 12

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        
     
    
        return NO; // return NO to not change text
    }
    

        
        if (textField == _txt_rate1 || textField == _txt_rate2 || textField == _txt_rate3 || textField == _txt_rate4 || textField == _txt_rate5) {
            str_rateid=@"";
            _txt_ratewording.text=nil;
            return YES;
        }
        
    
    
    
    
    else
    {return YES;}
}



-(void)didgetResponserSelectedTrac:(NSDictionary*)result
{
    DELEGATE.p_emailArray=nil;
    DELEGATE.f_emailArray=nil;
    
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        
        
        
        DELEGATE.dic_edittrac=[result objectForKey:@"Trac"];
        
        //Krish code
        
     
        
        DELEGATE.dic_getdata=[result objectForKey:@"general_details"];
        
        
        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_name"]]isEqualToString:@""])
        {
            [_txt_tracdetail setTextColor:[UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0]];
            _txt_tracdetail.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];
        }
        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_name"]]isEqualToString:@""])
        {
            _txt_trac.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_name"]];
        }
        
    
        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_type"]]isEqualToString:@""])
        {

            for (int i=0; i<[[DELEGATE.dic_getdata objectForKey:@"group"] count]; i++)
            {
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"group_type"]] isEqualToString:[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:i] objectForKey:@"name"]]]) {
                    
                    
                    
                  
                    _txt_type.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:i] objectForKey:@"name"]];
                    str_typeid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata  objectForKey:@"group"] objectAtIndex:i] objectForKey:@"id"]];
                }
            }
            
            
        }
        
        
        if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rate_wording_id"]]isEqualToString:@""])
        {
            _txt_rate1.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word1"]];
            _txt_rate2.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word2"]];
            _txt_rate3.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word3"]];
            _txt_rate4.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word4"]];
            _txt_rate5.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word5"]];
        }
        else
        {
            
            for (int i=0; i<[[DELEGATE.dic_getdata objectForKey:@"rate_word"] count]; i++)
            {
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rate_wording_id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"id"]]]) {
                    
                    _txt_ratewording.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"name"]];
                    str_rateid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"id"]];
                }
            }
            
        }
        
        
        
    }
    else
    {
        
    }
}

-(void)donePressed1
{
    
    [self.view endEditing:YES];
    
        _txt_type.text = str_group;
    

    
}



-(void)donePressed2
{
        [self.view endEditing:YES];
   
        _txt_ratewording.text = str_wording;
    
    
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == picker1)
    {
        return [[DELEGATE.dic_getdata objectForKey:@"group"] count];
    }
    else
    {
        return [[DELEGATE.dic_getdata objectForKey:@"rate_word"] count];
    }
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == picker1)
    {
        
        str_typeid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:row] valueForKey:@"id"]];
        
        str_group=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:row] valueForKey:@"name"]];
    
        
        return [[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:row] objectForKey:@"name"];

    }
    else
    {
        
        
         str_rateid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"id"]];
        
            str_wording=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"]];
        return [[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"];
        
        
    }
    
    
    

    
 
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == picker1)
    {
        
                str_typeid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:row] valueForKey:@"id"]];
        
        str_group=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"group"] objectAtIndex:row] valueForKey:@"name"]];
        
        
    }
    else{
        _txt_rate1.text=nil;
        _txt_rate5.text=nil;
        _txt_rate2.text=nil;
        _txt_rate3.text=nil;
        _txt_rate4.text=nil;
        str_rateid=@"";
        
        str_rateid=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"id"]];
        str_wording=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"]];
    }
    
}




-(void)viewWillAppear:(BOOL)animated
{
    

    
    
    mc=[[ModelClass alloc] init];
    mc.delegate=self;
    DELEGATE.isgroup=YES;
    if (DELEGATE.isEdit) {
        
    }
    else
    {
        if ([Validate isConnectedToNetwork])
        {
            [mc Get_data_whileaddTrac_userid:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] selector:@selector(didgetResonseAlltracs:)];
        }
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSString *str=[NSString stringWithFormat:@"%@",[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                   
   
    if ([str isEqualToString:@""]) {
        [_txt_tracdetail setText:@"Enter your trac here"];

        [textView setTextColor: [UIColor lightGrayColor]];
    }
    
}
-(void)didgetResonseAlltracs:(NSDictionary*)result
{
    
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        DELEGATE.dic_getdata=result;
        
       // [DELEGATE inserttrac_id:<#(NSString *)#> trac_data:<#(NSString *)#> trac_type:<#(NSString *)#>];
        
    }
    else
    {
        
    }
    
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
   
    
    if ([textView.text isEqualToString:@"Enter your trac here"]) {
        textView.text = @"";
       [textView setTextColor:[UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0]];
        
    //[textView setTextColor: [UIColor lightGrayColor]];

    }
    else
    {
        [textView setTextColor:[UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0]];
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_txt_rate1) {
        [_txt_rate2 becomeFirstResponder];
        
    }
    if (textField==_txt_rate2) {
        [_txt_rate3 becomeFirstResponder];
        
    }
    if (textField==_txt_rate3) {
        [_txt_rate4 becomeFirstResponder];
        
    }   if (textField==_txt_rate4) {
        [_txt_rate5 becomeFirstResponder];
        
    }   if (textField==_txt_rate5) {
        [self.view endEditing:YES];
        
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==_txt_ratewording)
    {

    }
    else if(textField==_txt_rate1||textField==_txt_rate2||textField==_txt_rate3||textField==_txt_rate4||textField==_txt_rate5)
    {

    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)touchBack:(id)sender
{
    if (DELEGATE.isEdit)
    {
        
        DELEGATE.isma=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    else{
        DELEGATE.ischeckadd=YES;
        DELEGATE.isNewTrackSelected=NO;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    

}

-(IBAction)touchNext:(id)sender
{

    if ([self validation]) {
    
    NSString *track_detail =  [_txt_tracdetail.text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *track_title =  [_txt_trac.text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
     [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",track_detail] forKey:@"details"];
        
     [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",track_title] forKey:@"groupreference"];
     [DELEGATE.groupdic setValue:str_typeid forKey:@"type"];
     [DELEGATE.groupdic setValue:str_rateid forKey:@"rateword"];
    
    [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",_txt_rate1.text] forKey:@"rate1"];
    [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",_txt_rate2.text] forKey:@"rate2"];
    [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",_txt_rate3.text] forKey:@"rate3"];
    [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",_txt_rate4.text] forKey:@"rate4"];
    [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",_txt_rate5.text] forKey:@"rate5"];

       
    
        setFrequncyViewController *got_frq=[[setFrequncyViewController alloc] initWithNibName:@"setFrequncyViewController" bundle:nil];
    
    got_frq.str_ref_name=_txt_trac.text;
     got_frq.str_tracname=_txt_tracdetail.text;
        [self.navigationController pushViewController:got_frq animated:YES];
    }
    
}



-(BOOL)validation
{
    
    
    
    NSString *name = [self.txt_tracdetail .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *ref_name = [self.txt_trac .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *type = [self.txt_type.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
     NSString *rates = [self.txt_ratewording.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
      NSString *rate1 = [self.txt_rate1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      NSString *rate2 = [self.txt_rate2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      NSString *rate3 = [self.txt_rate3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      NSString *rate4 = [self.txt_rate4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      NSString *rate5 = [self.txt_rate5.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if([name isEqualToString:@"Enter your trac here"] ||ref_name.length <=0 || type.length <=0 )
    {
        
        if([name isEqualToString:@"Enter your trac here"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter trac ideas" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txt_tracdetail becomeFirstResponder];
            [alert show];
            
            
        }
        else    if(ref_name.length <=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter trac name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txt_trac becomeFirstResponder];
            [alert show];
            
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter type" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [_txt_type becomeFirstResponder];
            [alert show];
        }
      
              return NO;
            
        }
    
    else if (rates.length <=0)
    {
        
        
        if (rate1.length<=0 || (rate2.length<=0||rate3.length<=0||rate4.length<=0||rate5.length<=0)) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter custom rate wording" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
                return NO;

        }
        else if (!rate1.length<=0 && !rate2.length<=0 && !rate3.length<=0 && !rate4.length<=0  && !rate5.length<=0)
        {
            return YES;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select rate wording" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            return NO;
        }
        
        
    }
    else{
         return YES;
    }
        
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [_txt_trac becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

-(IBAction)help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *help_obj=[[HelpViewController alloc]init];
    [self.navigationController pushViewController:help_obj animated:YES];
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSInteger restrictedLength=80;
    
    NSString *temp=textView.text;
    
    if([[textView text] length] > restrictedLength){
        textView.text=[temp substringToIndex:[temp length]-1];
        
    }
    
    if([[textView text] length] == restrictedLength){
        
        UIAlertView *alert1 = [[UIAlertView alloc]
                               initWithTitle:@""
                               message:@"Limit has been exceeded!"
                               delegate:self
                               cancelButtonTitle:@"ok"
                               otherButtonTitles:nil];
        
        [alert1 show];
        
    }
    
}


@end
