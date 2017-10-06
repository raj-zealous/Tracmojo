// Name : Rahul Rathod

//
//  PersonalTracs.m
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "Validate.h"
#import "HelpViewController.h"
#import "PersonalTracs.h"
#import "setFrequncyViewController.h"

@interface PersonalTracs ()
{
    NSString *str_idea_id,*str_rateword_id;
    NSString *str_idea,*str_wording;
       int start;
    
}
@end

@implementation PersonalTracs

- (void)viewDidLoad {
 
    [self showtrac];
    [self showwording];
   
    
    str_idea_id=[NSString stringWithFormat:@"1"];
str_rateword_id=[NSString stringWithFormat:@"1"];
    
    DELEGATE.dic_addPersonaltrac=[[NSMutableDictionary alloc] init];
    txt_ratewording.tintColor=[UIColor clearColor];
    txt_trac.tintColor=[UIColor clearColor];
    str_idea=@"";
    str_wording=@"";
    txt_ratewording.text=@"";
    txt_trac.text=@"";
    txt_tracdetail.text=@"";
    txt_rate1.text=@"";
    txt_rate2.text=@"";
    txt_rate3.text=@"";
    txt_rate4.text=@"";
    txt_rate5.text=@"";
    
    [txt_tracdetail setText:@"Enter your trac here"];
    [txt_tracdetail setTextColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]];
    mc=[[ModelClass alloc] init];
    mc.delegate=self;
    if (DELEGATE.isEdit)
    {
        DELEGATE.p_emailArray=nil;
        DELEGATE.f_emailArray=nil;
        if ([Validate isConnectedToNetwork])
        {
            [mc GettracDetail_user_id:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] trac_id:self.trac_id selector:@selector(didgetResponserSelectedTrac:)];
        }
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define MAX_LENGTH 12

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        
     
        return NO; // return NO to not change text
    }
    else
    {return YES;}
}


-(void)viewWillAppear:(BOOL)animated
{
    scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 450);
  
    if ([Validate isConnectedToNetwork])
    {
        if (!DELEGATE.isEdit  && DELEGATE.dic_getdata==nil)
        {
            [mc Get_data_whileaddTrac_userid:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] selector:@selector(didgetResonseAlltracs:)];
        }
    }

    
}

-(void)didgetResponserSelectedTrac:(NSDictionary*)result
{
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        
  //      Mobilenumber
        
        DELEGATE.dic_addPersonaltrac=[[NSMutableDictionary alloc] init];
        DELEGATE.groupdic=[[NSMutableDictionary alloc] init];
        DELEGATE.dic_edittrac=[result objectForKey:@"Trac"];
        DELEGATE.dic_getdata=[result objectForKey:@"general_details"];
    
       
        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"idea_id"]]isEqualToString:@""])
        {
            
            for (int i=0; i<[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] count]; i++)
            {
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"idea_id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:i] objectForKey:@"id"]]]) {
                    
                    txt_trac.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:i] objectForKey:@"name"]];
                    str_idea_id=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata  objectForKey:@"rate_idea"] objectAtIndex:i] objectForKey:@"id"]];
                }
            }
            
            
        }
        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]]isEqualToString:@""])
        {
             txt_tracdetail.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"goal"]];
        }
        


        if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rate_wording_id"]]isEqualToString:@""])
        {
            txt_rate1.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word1"]];
            txt_rate2.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word2"]];
            txt_rate3.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word3"]];
            txt_rate4.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word4"]];
            txt_rate5.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"cust_rate_word5"]];
        }
        else
        {
            
            for (int i=0; i<[[DELEGATE.dic_getdata objectForKey:@"rate_word"] count]; i++)
            {
                if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rate_wording_id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"id"]]]) {
                    
                   txt_ratewording.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"name"]];
                    str_rateword_id=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:i] objectForKey:@"id"]];
                }
            }
            
        }

        
        
    }
    else
    {

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==99&&buttonIndex==0) {
        DELEGATE.ischeckadd=YES;
        DELEGATE.isNewTrackSelected=NO;
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];

    }
  }




-(void)didgetResonseAlltracs:(NSDictionary*)result
{
    
    if([[result objectForKey:@"status"]isEqualToString:@"Success"])
    {
        
        if([[result objectForKey:@"can_add_personal_trac"]isEqualToString:@"y"])
        {
            
            DELEGATE.is_addPersonal=YES;
            
       
        }
        if([[result objectForKey:@"can_add_personal_trac"]isEqualToString:@"n"])
        {
             DELEGATE.is_addPersonal=NO;
        }
        
        DELEGATE.dic_getdata=result;
        
   
    }
    else
    {
        
    }

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



#pragma Touch button
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

    NSString *str_msg;
    
    if ([Validate isEmpty:txt_tracdetail.text] || [txt_tracdetail.text isEqualToString:@"Enter your trac here"])
    {
        
        if([Validate isEmpty:txt_trac.text])
        {
             str_msg=@"Please enter trac ideas";
            [txt_trac becomeFirstResponder];
        }
        else if ([Validate isEmpty:txt_ratewording.text])
        {
            if ([Validate isEmpty:txt_rate1.text] || [Validate isEmpty:txt_rate2.text] || [Validate isEmpty:txt_rate3.text] || [Validate isEmpty:txt_rate4.text] || [Validate isEmpty:txt_rate5.text])
            {
                str_msg=@"Please enter rate name";
            }
            else if (![Validate isEmpty:txt_rate1.text] && ![Validate isEmpty:txt_rate2.text] && ![Validate isEmpty:txt_rate3.text] && ![Validate isEmpty:txt_rate4.text] && ![Validate isEmpty:txt_rate5.text])
            {
                str_msg=@"Done";
            }
            else
            {
                str_msg=@"Please choose rate";
                [txt_ratewording becomeFirstResponder];
            }
            
        }
        else
        {
            str_msg=@"Done";
        }
        
       
    }
    else if ([Validate isEmpty:txt_ratewording.text])
    {
        if ([Validate isEmpty:txt_rate1.text] || [Validate isEmpty:txt_rate2.text] || [Validate isEmpty:txt_rate3.text] || [Validate isEmpty:txt_rate4.text] || [Validate isEmpty:txt_rate5.text])
        {
             str_msg=@"Please enter custom rate";
                    }
        else if (![Validate isEmpty:txt_rate1.text] && ![Validate isEmpty:txt_rate2.text] && ![Validate isEmpty:txt_rate3.text] && ![Validate isEmpty:txt_rate4.text] && ![Validate isEmpty:txt_rate5.text])
        {
             str_msg=@"Done";
        }
        else
        {
            str_msg=@"Please choose rate";
            [txt_ratewording becomeFirstResponder];
        }

    }
    else
    {
        str_msg=@"Done";
    }
    if ([str_msg isEqualToString:@"Done"])
    {

        if ([Validate isEmpty:txt_ratewording.text])
        {
            
            if (![Validate isEmpty:txt_rate1.text] && ![Validate isEmpty:txt_rate2.text] && ![Validate isEmpty:txt_rate3.text] && ![Validate isEmpty:txt_rate4.text] && ![Validate isEmpty:txt_rate5.text])
            {
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_rate1.text] forKey:@"rate1"];
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_rate2.text] forKey:@"rate2"];
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_rate3.text] forKey:@"rate3"];
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_rate4.text] forKey:@"rate4"];
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_rate5.text] forKey:@"rate5"];
                 [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"N"] forKey:@"rate_flag"];
            }
        }
        else
        {
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",str_rateword_id] forKey:@"rateword_id"];
             [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"Y"] forKey:@"rate_flag"];
        }
    
        
        if ([[NSString stringWithFormat:@"%@",txt_tracdetail.text] isEqualToString:@"Enter your trac here"])
        {
           if (![Validate isEmpty:txt_trac.text])
            {
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",str_idea_id] forKey:@"idea_id"];
                [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_trac.text] forKey:@"trac_detail"];
                 [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"Y"] forKey:@"idea_flag"];
                //NSLog(@"%@",DELEGATE.dic_addPersonaltrac);

            }
        }
        else
        {
            NSString *track_detail =
            [txt_tracdetail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@""] forKey:@"idea_id"];
            
             [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",track_detail] forKey:@"trac_detail"];
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"N"] forKey:@"idea_flag"];
        }
        //NSLog(@"%@",DELEGATE.dic_addPersonaltrac);
        setFrequncyViewController *got_frq=[[setFrequncyViewController alloc] initWithNibName:@"setFrequncyViewController" bundle:nil];
        [self.navigationController pushViewController:got_frq animated:YES];
    }
    else
    {
        UIAlertView *alter_msg=[[UIAlertView alloc] initWithTitle:nil message:str_msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter_msg show];
    }
}




#pragma Pickerview


-(void)addPicker:(UITextField*)field{
    
    if (txt_ratewording==field)
    {
        pickerView_ratewording.delegate=self;
        pickerView_ratewording.dataSource=self;
        txt_ratewording.inputView=pickerView_ratewording;
    }
    else if (txt_trac==field)
    {
        
        
        
        
        pickerView_trac.delegate=self;
        pickerView_trac.dataSource=self;
        txt_trac.inputView=pickerView_trac;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textField
{
    

    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txt_trac)
    {
        

    }
    else if(txt_ratewording == textField)
    {
        txt_rate1.text=nil;
        txt_rate5.text=nil;
        txt_rate2.text=nil;
        txt_rate3.text=nil;
        txt_rate4.text=nil;
    }
    else if(txt_rate1 == textField || txt_rate2 == textField || txt_rate3 == textField || txt_rate5 == textField || txt_rate5 == textField )
    {
            txt_ratewording.text=nil;
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (txt_trac==textField)
    {
        [self addPicker:txt_trac];
     
    }
    else if (txt_ratewording==textField)
    {
        [self addPicker:txt_ratewording];
      
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSString *str=[NSString stringWithFormat:@"%@",[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    
    if ([str isEqualToString:@""]) {
        [txt_tracdetail setText:@"Enter your trac here"];
        [textView setTextColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == txt_tracdetail)
    {
        str_idea_id=@"";
        txt_trac.text=nil;
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
    if ([textView.text isEqualToString:@"Enter your trac here"]) {
        textView.text = @"";
        [textView setTextColor:[UIColor blackColor]];
        
    }
    
    
    
}
- (void)showtrac {
    
    
    pickerView_trac = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    pickerView_trac.delegate=self;
    pickerView_trac.dataSource=self;
    pickerView_trac.backgroundColor=[UIColor whiteColor];
    pickerView_trac.hidden = NO;
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    myToolbar.barStyle = UIBarStyleBlackOpaque;
    [myToolbar sizeToFit];
 
    
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidYearDone:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    myToolbar.items = [NSArray arrayWithObjects:flexibleSpace,doneButton, nil];

 
    txt_trac.inputAccessoryView=myToolbar;
    txt_trac.inputView=pickerView_trac;
}

- (void)showwording {
    
    
    pickerView_ratewording = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    pickerView_ratewording.delegate=self;
    pickerView_ratewording.dataSource=self;
    pickerView_ratewording.backgroundColor=[UIColor whiteColor];
    pickerView_ratewording.hidden = NO;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    myToolbar.barStyle = UIBarStyleBlackOpaque;
    [myToolbar sizeToFit];
    
    
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidMonthDone:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    myToolbar.items = [NSArray arrayWithObjects:flexibleSpace,doneButton, nil];
    
    txt_ratewording.inputAccessoryView=myToolbar;
    txt_ratewording.inputView=pickerView_ratewording;
    
    
}
-(void)inputAccessoryViewDidYearDone:(UITextField*)textfiel
{
    
    

    if([str_idea isEqualToString:@"Loose Weight"])
    {
        str_idea_id=@"1";
        
    }
    
    
    txt_trac.text=str_idea;
    [txt_tracdetail setText:@"Enter your trac here"];
     [txt_tracdetail setTextColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]];
    [txt_trac resignFirstResponder];
    
}
-(void)inputAccessoryViewDidMonthDone:(UITextField*)textfiel
{
    txt_ratewording.text=str_wording;
    [txt_ratewording resignFirstResponder];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (pickerView_trac==pickerView)
    {
        
       
        return [[DELEGATE.dic_getdata objectForKey:@"rate_idea"] count];
    }
    else
    {
        return [[DELEGATE.dic_getdata objectForKey:@"rate_word"] count];
    }
   
    return 0;
    
}


// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView_trac==pickerView)
    {
        
        str_idea=[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:row] objectForKey:@"name"];
        return [[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:row] objectForKey:@"name"];
    }
    else  if (pickerView_ratewording ==pickerView)
    {
        str_wording=[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"];
        return [[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"];
    }
   
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView_trac==pickerView)
    {
        NSString *str=[NSString stringWithFormat:@"%@",[txt_tracdetail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        if (![str isEqualToString:@""]) {
            [txt_tracdetail setText:@"Enter your trac here"];
            [txt_tracdetail setTextColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]];
        }
        
        
     
        str_idea=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:row] objectForKey:@"name"]];
        str_idea_id=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:row] objectForKey:@"id"]];
        txt_trac.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_idea"] objectAtIndex:row] objectForKey:@"name"]];
    }
    else  if (pickerView_ratewording==pickerView)
    {
        
        
        
        str_wording=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"]];
        str_rateword_id=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"id"]];
        txt_ratewording.text=[NSString stringWithFormat:@"%@",[[[DELEGATE.dic_getdata objectForKey:@"rate_word"] objectAtIndex:row] objectForKey:@"name"]];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txt_rate1) {
        [txt_rate2 becomeFirstResponder];
        
    }
    if (textField==txt_rate2) {
        [txt_rate3 becomeFirstResponder];
        
    }
    if (textField==txt_rate3) {
        [txt_rate4 becomeFirstResponder];
        
    }   if (textField==txt_rate4) {
        [txt_rate5 becomeFirstResponder];
        
    }   if (textField==txt_rate5) {
        [self.view endEditing:YES];
        
    }
    return YES;
}

-(IBAction)touch_help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *got_help=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [self.navigationController pushViewController:got_help animated:YES];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}
@end
