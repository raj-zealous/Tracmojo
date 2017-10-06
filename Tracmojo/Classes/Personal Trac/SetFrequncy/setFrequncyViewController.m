//
//  setFrequncyViewController.m
//  Tracmojo
//
//  Created by macmini3 on 08/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "setFrequncyViewController.h"
#import "InvitedParticipated.h"
#import "Validate.h"
#import "HelpViewController.h"
@interface setFrequncyViewController ()
{
    NSMutableArray *array_as;
    NSDictionary *array_on;
    NSString *str_as,*str_on;
    NSString *dateStrforedit;
    
}
@end

@implementation setFrequncyViewController

- (void)viewDidLoad {
    
    
    
    [self showas];
    [self showon];
    //[self showDatePicker];
    //NSLog(@"%@",DELEGATE.dic_edittrac);
    
    str_on=@"";
    str_as=@"";
    txt_as.text=@"";
    txt_finishingon.text=@"";
    txt_on.text=@"";
    txt_showtitle.text=@"";
    txt_as.tintColor=[UIColor clearColor];
    txt_on.tintColor=[UIColor clearColor];
    txt_finishingon.tintColor=[UIColor clearColor];
    
    if (DELEGATE.isEdit)
    {
        txt_as.enabled=NO;
        txt_on.enabled=NO;
        txt_finishingon.enabled=YES;
        if (DELEGATE.isgroup)
        {
            _lbl_ref.text=_str_ref_name;
            txt_showtitle.text= _str_tracname;
            txt_finishingon.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"finish_date_edit"]];
            txt_as.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_frequency"]];
            if ([[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]]isEqualToString:@""]) {
                txt_on.enabled=NO;
                txt_on.text=@"";
            }
            else
            {
                txt_on.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]];
            }
            //   rating_frequency finish_date_edit rating_day
        }
        else
        {
            
            txt_as.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_frequency"]];
            txt_finishingon.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"finish_date_edit"]];
            
            if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]]isEqualToString:@""])
            {
                txt_on.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]];
            }
            
            if ([[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]isEqualToString:@"N"])
            {
                txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                txt_showtitle.enabled=YES;
            }
            else
            {
                txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
                txt_showtitle.enabled=NO;
            }
            
        }
        
        if ([txt_as.text isEqualToString:@"Daily"]||[txt_as.text isEqualToString:@"All Weekdays"]) {
            _lblOn.hidden=YES;
            _imgv_bg.hidden=YES;
            txt_on.hidden=YES;
            _erro1.hidden=YES;
            
            
            
            txt_finishingon.frame=CGRectMake(txt_finishingon.frame.origin.x,214, txt_finishingon.frame.size.width, txt_finishingon.frame.size.height);
            
            _lblb.frame=CGRectMake(_lblb.frame.origin.x,185.0, _lblb.frame.size.width, _lblb.frame.size.height);
            
            _imgv_move.frame=CGRectMake(_imgv_move.frame.origin.x,206.0, _imgv_move.frame.size.width, _imgv_move.frame.size.height);
            
            
            _error2.frame=CGRectMake(_error2.frame.origin.x,221.0, _error2.frame.size.width, _error2.frame.size.height);
            
            
            
            
            
            
        }
        else{
            
            
            
            
            
            
            
            
            
            
            _lblOn.hidden=NO;
            _imgv_bg.hidden=NO;
            txt_on.hidden=NO;
            _erro1.hidden=NO;
            
            
            int x=77;
            
            txt_finishingon.frame=CGRectMake(txt_finishingon.frame.origin.x,214+x, txt_finishingon.frame.size.width, txt_finishingon.frame.size.height);
            
            _lblb.frame=CGRectMake(_lblb.frame.origin.x,185.0+x, _lblb.frame.size.width, _lblb.frame.size.height);
            
            _imgv_move.frame=CGRectMake(_imgv_move.frame.origin.x,206.0+x, _imgv_move.frame.size.width, _imgv_move.frame.size.height);
            
            
            _error2.frame=CGRectMake(_error2.frame.origin.x,221.0+x, _error2.frame.size.width, _error2.frame.size.height);
            
            
            
            
        }
        
        
        
        
    }
    else
    {
        if (DELEGATE.isgroup) {
            _lbl_ref.text=_str_ref_name;
            txt_showtitle.text= _str_tracname;
        }
        else
        {
            //            if ([[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]isEqualToString:@"N"])
            //            {
            //                txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            //                txt_showtitle.enabled=YES;
            //            }
            //            else
            //            {
            //                txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            //                txt_showtitle.enabled=NO;
            //            }
        }
        
    }
    scroll_frequncy.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,350);
    
    
    
    
    UIPickerView *pickerView=[[UIPickerView alloc]init];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate=self;
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd-MM-yyyy";
    
    
    //    df.dateStyle = NSDateFormatterNoStyle;
    
    
    NSCalendar *calendar;
    NSDateComponents *components;
    
    if ([txt_as.text isEqualToString:@"Daily"]) {
        calendar = [NSCalendar currentCalendar];
        components = [[NSDateComponents alloc] init];
        components.day = 0;
    }
    else if ([txt_as.text isEqualToString:@"All Weekdays"]) {
        calendar = [NSCalendar currentCalendar];
        components = [[NSDateComponents alloc] init];
        components.day = 0;
    }
    else if ([txt_as.text isEqualToString:@"Fortnightly"]) {
        
        calendar = [NSCalendar currentCalendar];
        components = [[NSDateComponents alloc] init];
        components.day = 14;
        
    }
    else if ([txt_as.text isEqualToString:@"Monthly"]) {
        
        calendar = [NSCalendar currentCalendar];
        components = [[NSDateComponents alloc] init];
        components.day = 30;
    }
    else if ([txt_as.text isEqualToString:@"Weekly"]) {
        calendar = [NSCalendar currentCalendar];
        components = [[NSDateComponents alloc] init];
        components.day = 7;
    }
    
    //  NSDate *startDate = [NSDate date];
    //  NSDate *endDate = [calendar dateByAddingComponents:components
    //                                              toDate:startDate
    //                                             options:0];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.hidden = NO;
    //krish
    
    
    //NSLog(@"%@",txt_finishingon.text);
    
    
    if (DELEGATE.isEdit) {
        NSString *dateStr = txt_finishingon.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        
        txt_finishingon.text = [NSString stringWithFormat:@"%@",
                                [df stringFromDate:date]];
        
        [datePicker setDate:date];//krish
        
        if ([txt_as.text isEqualToString:@"Weekly"])
        {
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+7];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            datePicker.minimumDate=afterSevenDays;
        }
        if ([txt_as.text isEqualToString:@"Fortnightly"])
            
        {
            
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+14];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            
            
            
            datePicker.minimumDate=afterSevenDays;
            
        }
        
        if ([txt_as.text isEqualToString:@"Monthly"])
            
        {
            
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+30];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            
            
            
            datePicker.minimumDate=afterSevenDays;
            
        }
        
        
    }
    else{
        datePicker.minimumDate=[NSDate date];
    }
    
    
    
    
    
    
    
    
    
    
    [datePicker addTarget:self
                   action:@selector(finishingDate:)
         forControlEvents:UIControlEventValueChanged];
    
    // [self.view addSubview:datePicker];
    txt_finishingon.inputView=datePicker;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    //    if (DELEGATE.isEdit)
    //    {
    //        txt_as.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_frequency"]];
    //        txt_finishingon.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"finish_date"]];
    //
    //        if (![[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]]isEqualToString:@""])
    //        {
    //            txt_on.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_edittrac objectForKey:@"rating_day"]];
    //        }
    //    }
    
    if (DELEGATE.isgroup)
    {
        _lbl_ref.text=_str_ref_name;
        txt_showtitle.text= _str_tracname;
        
        
    }
    else
    {
        _lbl_ref.hidden=YES;
        //NSLog(@"%@",DELEGATE.dic_addPersonaltrac);
        if ([[DELEGATE.dic_addPersonaltrac objectForKey:@"idea_flag"]isEqualToString:@"N"])
        {
            txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            txt_showtitle.enabled=YES;
        }
        else
        {
            txt_showtitle.text=[NSString stringWithFormat:@"%@",[DELEGATE.dic_addPersonaltrac objectForKey:@"trac_detail"]];
            txt_showtitle.enabled=NO;
        }
        
    }
    
    
    //Weekdays, daily, weekly, fortnightly, monthly
    
    
    //NSLog(@"%@",[DELEGATE.dic_getdata objectForKey:@"rate_frequency"]);
    
    
    array_as=[[NSMutableArray alloc] initWithObjects:@"All Weekdays",@"Daily",@"Weekly",@"Fortnightly",@"Monthly", nil];
    
    
    array_on=[[NSDictionary alloc]initWithDictionary:[DELEGATE.dic_getdata objectForKey:@"rate_frequency"]];
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    myToolbar.barStyle = UIBarStyleBlackOpaque;
    [myToolbar sizeToFit];
    
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(DonefinishingDate:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    myToolbar.items = [NSArray arrayWithObjects:flexibleSpace,doneButton, nil];
    
    //    [arrbarItems addObject:doneButton];
    //    [myToolbar setItems:arrbarItems animated:YES];
    txt_finishingon.inputAccessoryView=myToolbar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)touchBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)touchNext:(id)sender
{
    NSString *str_msg;
    if([Validate isEmpty:txt_as.text])
    {
        str_msg=@"Please select As";
    }
#pragma 15/4
    else if (![[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] count] == 0 && [Validate isEmpty:txt_on.text])
    {
        
        if([Validate isEmpty:txt_on.text])
        {
            str_msg=@"Please select on";
        }
        
    }
    else if([Validate isEmpty:txt_finishingon.text])
    {
        str_msg=@"Select finishing date";
    }
    else
    {
        str_msg=@"Done";
    }
    
    
    if ([str_msg isEqualToString:@"Done"])
    {
        
        InvitedParticipated *got_frq=[[InvitedParticipated alloc] initWithNibName:@"InvitedParticipated" bundle:nil];
        if (DELEGATE.isgroup) {
            
            [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",txt_as.text] forKey:@"as"];
            [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",txt_on.text] forKey:@"on"];
            [DELEGATE.groupdic setValue:[NSString stringWithFormat:@"%@",txt_finishingon.text] forKey:@"finisheddate"];
            
            
            
            got_frq.str_add=_str_ref_name;
            got_frq.str_title=_str_tracname;
            
        }
        else{
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_as.text] forKey:@"as"];
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_on.text] forKey:@"on"];
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_showtitle.text] forKey:@"trac_detail"];
            [DELEGATE.dic_addPersonaltrac setValue:[NSString stringWithFormat:@"%@",txt_finishingon.text] forKey:@"finisheddate"];
        }
        
        //  //NSLog(@"%@",DELEGATE.dic_addPersonaltrac);
        
        [self.navigationController pushViewController:got_frq animated:YES];
    }
    else
    {
        
        UIAlertView *alt_msg=[[UIAlertView alloc] initWithTitle:nil message:str_msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt_msg show];
    }
    
}

-(void)addPicker:(UITextField*)field{
    
    if (txt_as==field)
    {
        pickerView_as.delegate=self;
        pickerView_as.dataSource=self;
        txt_as.inputView=pickerView_as;
    }
    else if (txt_on==field)
    {
        
        pickerView_on.delegate=self;
        pickerView_on.dataSource=self;
        txt_on.inputView=pickerView_on;
    }
    else if (txt_finishingon==field)
    {
        
        pickerView_finishing.delegate=self;
        pickerView_finishing.dataSource=self;
        
        //datePicker
        txt_finishingon.inputView=datePicker;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (txt_as==textField)
    {
        
        [self addPicker:txt_as];
        
    }
    else if (txt_on==textField)
    {
        [self addPicker:txt_on];
        
    }
    else if (txt_finishingon==textField)
    {
        [self addPicker:txt_finishingon];
        
        //  [self showDatePicker];
        
    }
    
    
}
- (void)showas {
    
    // df.dateStyle = NSDateFormatterMediumStyle;
    
    pickerView_as = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    pickerView_as.delegate=self;
    pickerView_as.dataSource=self;
    pickerView_as.backgroundColor=[UIColor whiteColor];
    pickerView_as.hidden = NO;
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    myToolbar.barStyle = UIBarStyleBlackOpaque;
    [myToolbar sizeToFit];
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidYearDone:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    myToolbar.items = [NSArray arrayWithObjects:flexibleSpace,doneButton, nil];
    
    
    txt_as.inputAccessoryView=myToolbar;
    txt_as.inputView=pickerView_as;
}

- (void)showon {
    
    // df.dateStyle = NSDateFormatterMediumStyle;
    
    pickerView_on = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    pickerView_on.delegate=self;
    pickerView_on.dataSource=self;
    pickerView_on.backgroundColor=[UIColor whiteColor];
    pickerView_on.hidden = NO;
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    myToolbar.barStyle = UIBarStyleBlackOpaque;
    [myToolbar sizeToFit];
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidMonthDone:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    myToolbar.items = [NSArray arrayWithObjects:flexibleSpace,doneButton, nil];
    
    
    txt_on.inputAccessoryView=myToolbar;
    txt_on.inputView=pickerView_on;
}

- (void)showDatePicker {
    
    
}

-(void)DonefinishingDate:(UITextField*)textfiel
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //	df.dateStyle = NSDateFormatterMediumStyle;
    df.dateFormat = @"dd-MM-yyyy";
    txt_finishingon.text = [NSString stringWithFormat:@"%@",
                            [df stringFromDate:datePicker.date]];
    if([self isEndDateIsSmallerThanCurrent:datePicker.date])
    {
        
    }
    else
    {
    }
    [txt_finishingon resignFirstResponder];
    //datePicker.hidden=YES;
}

-(void)finishingDate:(UITextField*)textfiel
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd-MM-yyyy";
    
    //NSLog(@"%@",datePicker.date);
    //   	df.dateStyle = NSDateFormatterMediumStyle;
    txt_finishingon.text = [NSString stringWithFormat:@"%@",
                            [df stringFromDate:datePicker.date]];
    if([self isEndDateIsSmallerThanCurrent:datePicker.date])
    {
        
    }
    else
    {
    }
    // datePicker.hidden=YES;
}

-(void)inputAccessoryViewDidYearDone:(UITextField*)textfiel
{
    
    //[str_as isEqualToString:@"All Weekdays"]
    
    if ([str_as isEqualToString:@"Daily"] || [str_as isEqualToString:@"All Weekdays"]) {
        _lblOn.hidden=YES;
        _imgv_bg.hidden=YES;
        txt_on.hidden=YES;
        _erro1.hidden=YES;
        
        
        
        txt_finishingon.frame=CGRectMake(txt_finishingon.frame.origin.x,214, txt_finishingon.frame.size.width, txt_finishingon.frame.size.height);
        
        _lblb.frame=CGRectMake(_lblb.frame.origin.x,185.0, _lblb.frame.size.width, _lblb.frame.size.height);
        
        _imgv_move.frame=CGRectMake(_imgv_move.frame.origin.x,206.0, _imgv_move.frame.size.width, _imgv_move.frame.size.height);
        
        
        _error2.frame=CGRectMake(_error2.frame.origin.x,221.0, _error2.frame.size.width, _error2.frame.size.height);
        
        
        
        
        
        
    }
    else{
        
        
        
        if ([str_as isEqualToString:@"Weekly"])
            
        {
            
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+7];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            
            
            
            datePicker.minimumDate=afterSevenDays;
            
        }
        
        if ([str_as isEqualToString:@"Fortnightly"])
            
        {
            
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+14];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            
            
            
            datePicker.minimumDate=afterSevenDays;
            
        }
        
        if ([str_as isEqualToString:@"Monthly"])
            
        {
            
            NSDate *todayDate = [NSDate date];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setDay:+30];
            NSDate *afterSevenDays = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
            
            
            
            datePicker.minimumDate=afterSevenDays;
            
        }
        
        
        
        
        
        
        _lblOn.hidden=NO;
        _imgv_bg.hidden=NO;
        txt_on.hidden=NO;
        _erro1.hidden=NO;
        
        
        int x=77;
        
        txt_finishingon.frame=CGRectMake(txt_finishingon.frame.origin.x,214+x, txt_finishingon.frame.size.width, txt_finishingon.frame.size.height);
        
        _lblb.frame=CGRectMake(_lblb.frame.origin.x,185.0+x, _lblb.frame.size.width, _lblb.frame.size.height);
        
        _imgv_move.frame=CGRectMake(_imgv_move.frame.origin.x,206.0+x, _imgv_move.frame.size.width, _imgv_move.frame.size.height);
        
    
        _error2.frame=CGRectMake(_error2.frame.origin.x,221.0+x, _error2.frame.size.width, _error2.frame.size.height);
    
    }
    
    
    
    
    txt_as.text=str_as;
    [txt_as resignFirstResponder];
    
}
-(void)inputAccessoryViewDidMonthDone:(UITextField*)textfiel
{
    txt_on.text=str_on;
    [txt_on resignFirstResponder];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
{
    NSDate* enddate = checkEndDate;
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return YES;
    else if (secondsBetweenDates < 0)
        return NO;
    else
        return YES;
}

// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    
    if (pickerView_as==pickerView)
    {
        return [array_as count];
    }
    else if(pickerView_on == pickerView)
    {
        
        return [[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] count];
    }
    
    return 0;
    
}


// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
#pragma 14/4
    if (pickerView_as==pickerView)
    {
        //        if ([[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] count] == 0) {
        //            txt_on.enabled=YES;
        //        }
        //        else
        //        {
        //            txt_on.enabled=NO;
        //
        //        }
        
        str_as=[array_as objectAtIndex:row] ;
        
        return [array_as objectAtIndex:row] ;
    }
    else  if (pickerView_on ==pickerView)
    {
        str_on=[[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] objectAtIndex:row];
        return [[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] objectAtIndex:row];
    }
    
    
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
#pragma 14/4
    if (pickerView_as==pickerView)
    {
        str_as=[NSString stringWithFormat:@"%@",[array_as objectAtIndex:row]];
        str_on=@"";
        
        txt_as.text=[NSString stringWithFormat:@"%@",[array_as objectAtIndex:row]];
        txt_on.text=@"";
        txt_finishingon.text=@"";
        
        if ([[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] count] == 0) {
            txt_on.enabled=NO;
        }
        else
        {
            txt_on.enabled=YES;
            
        }
        
    }
    else  if (pickerView_on==pickerView)
    {
        str_on=[NSString stringWithFormat:@"%@",[[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] objectAtIndex:row]];
        txt_on.text=[NSString stringWithFormat:@"%@",[[array_on objectForKey:[NSString stringWithFormat:@"%@",txt_as.text]] objectAtIndex:row]];
    }
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(IBAction)touch_help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *got_help=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [self.navigationController pushViewController:got_help animated:YES];
}
-(IBAction)help:(id)sender
{
    [DELEGATE hidePopup];
    HelpViewController *help_obj=[[HelpViewController alloc]init];
    [self.navigationController pushViewController:help_obj animated:YES];
    
}
@end
