//
//  TracReview.m
//  Tracmojo
//
//  Created by macmini3 on 14/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//
#import "ModelClass.h"
#import "tracrate.h"
#import "Validate.h"
#import "HelpViewController.h"
#import "CommentsViewController.h"
#import "HelpViewController.h"

@interface tracrate ()
{
    int num_rate;
    BOOL ischeck,ischeck2;
    
}
@end

@implementation tracrate

- (void)viewDidLoad {
    lbl_gole.numberOfLines = 0;
    mc=[[ModelClass alloc] init];
    //        mc.delegate=self;
    previewImage.clipsToBounds = YES;
    
    previewImage.layer.cornerRadius = 7;

    ischeck2=NO;
    ischeck=NO;
      [btnCheckbox setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
     [btnCheckbox2 setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
    btn_Message.layer.masksToBounds=YES;
    btn_Message.layer.cornerRadius=3.0;
    
    btn_cancel.layer.masksToBounds=YES;
    btn_cancel.layer.cornerRadius=3.0;
    
    UISwipeGestureRecognizer *swipeRightBlack = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightBlack.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightBlack];

    scroll_popup.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width+1, scroll_popup.frame.size.height);
    num_rate=0;
    
    NSLog(@"%@",self.dic_rate);
    
    if ([self.dic_rate objectForKey:@"group_name"])
    {
        lbl_detail.text=[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"goal"]];
        lbl_gole.text=[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"group_name"]];
//       lbl_gole.frame = CGRectMake(lbl_gole.frame.origin.x, lbl_gole.frame.origin.y, lbl_gole.frame.size.width, 25.0);
        _lblGoletopConstant.constant =  0 ;
        _lblGoleHightCOnst.constant = previewImage.frame.size.height / 2 ;
        _lblDetailTopConstant.constant = - 10;
        self.view.needsUpdateConstraints;
        
//            lbl_gole.frame = CGRectMake(lbl_gole.frame.origin.x, btn_BusinessName.frame.origin.y +btn_BusinessName.frame.size.height - 10, lbl_gole.frame.size.width, 25.0);
    }
    else
    {
        lbl_gole.frame = CGRectMake(lbl_gole.frame.origin.x, _trackRateHeaderElement.frame.origin.y +btn_BusinessName.frame.size.height - 15 , lbl_gole.frame.size.width, 59.0);
        
        
        lbl_gole.text=[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"goal"]];
    }

    if ([self.dic_rate objectForKey:@"business_name"] != nil)
    {
        [btn_BusinessName setTitle: [self.dic_rate objectForKey:@"business_name"] forState:UIControlStateNormal];
        btn_BusinessName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn_BusinessName setTitleColor:[UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        _lblGoletopConstant.constant  = btn_BusinessName.frame.origin. y +  btn_BusinessName.frame.size.height - 10;
        _lblGoleHightCOnst.constant   = _trackRateHeaderElement.frame.size.height -  btn_BusinessName.frame.size.height;
        
    }
    else
    {
        [btn_BusinessName setHidden:true];
        if (btn_BusinessName.hidden == YES && [lbl_detail.text isEqualToString:@""])
        {
           
            lbl_gole.font = Font_Roboto(14);
            lbl_gole.text=[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"goal"]];

            //              lbl_gole.frame = CGRectMake(lbl_gole.frame.origin.x,previewImage.frame.origin.y  , lbl_gole.frame.size.width, 65.0);
       
            self.lblGoleHightCOnst.constant = 65 ;
            self.lblGoletopConstant.constant  = 0 ;
            self.view.setNeedsUpdateConstraints;
         
        }
       
        
    }
    
    
    if ([[self.dic_rate objectForKey:@"last_rated"]isEqualToString:@""]) {
        lbl_frequency.text=[NSString stringWithFormat:@"rating is %@",[self.dic_rate objectForKey:@"rating_frequency"]];
    }
    else
    {
    lbl_frequency.text=[NSString stringWithFormat:@"rating is %@ , last rated %@",[self.dic_rate objectForKey:@"rating_frequency"],[self.dic_rate objectForKey:@"last_rated"]];
    }
    
    lbl_text1.text=[NSString stringWithFormat:@"%@",[[self.dic_rate objectForKey:@"rate_option"] objectForKey:@"option1"]];
    lbl_text2.text=[NSString stringWithFormat:@"%@",[[self.dic_rate objectForKey:@"rate_option"] objectForKey:@"option2"]];
    lbl_text3.text=[NSString stringWithFormat:@"%@",[[self.dic_rate objectForKey:@"rate_option"] objectForKey:@"option3"]];
    lbl_text4.text=[NSString stringWithFormat:@"%@",[[self.dic_rate objectForKey:@"rate_option"] objectForKey:@"option4"]];
    lbl_text5.text=[NSString stringWithFormat:@"%@",[[self.dic_rate objectForKey:@"rate_option"] objectForKey:@"option5"]];
    float verson =  [[UIDevice currentDevice].systemVersion floatValue];
    if (verson >= 11)
    {
        if([self isPad])
        {
            if ([self isPortrait])
            {
                
            }
        }
        else
        {
            if ([self isPortrait])
            {
                btn_color1.layer.cornerRadius=btn_color1.frame.size.height/3;
                btn_color1.layer.masksToBounds=YES;
                
                btn_color2.layer.cornerRadius=btn_color2.frame.size.height/3;
                btn_color2.layer.masksToBounds=YES;
                
                btn_color3.layer.cornerRadius=btn_color3.frame.size.height/3;
                btn_color3.layer.masksToBounds=YES;
                
                btn_color4.layer.cornerRadius=btn_color4.frame.size.height/3;
                btn_color4.layer.masksToBounds=YES;
                
                btn_color5.layer.cornerRadius=btn_color5.frame.size.height/3;
                btn_color5.layer.masksToBounds=YES;
                
                //NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
                if ([UIScreen mainScreen].bounds.size.height == 480) {
                    //NSLog(@"480");
                    
                    imgerate.frame=CGRectMake(imgerate.frame.origin.x-0, imgerate.frame.origin.y, imgerate.frame.size.width, imgerate.frame.size.height+10);
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x+10, btnmain.frame.origin.y, btnmain.frame.size.width, btnmain.frame.size.height);
                        int f=20;
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x-5, btn_color1.frame.origin.y+20-f, btn_color1.frame.size.width-5, btn_color1.frame.size.height-5);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x-10, btn_color2.frame.origin.y+15-f, btn_color2.frame.size.width-5, btn_color2.frame.size.height-5);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x-12, btn_color3.frame.origin.y+15-f, btn_color3.frame.size.width-5, btn_color3.frame.size.height-5);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x-10, btn_color4.frame.origin.y+11-f, btn_color4.frame.size.width-5, btn_color4.frame.size.height-5);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x-5, btn_color5.frame.origin.y+8-f, btn_color5.frame.size.width-5, btn_color5.frame.size.height-5);
                    
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x-5, lbl_text1.frame.origin.y+4, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x-10, lbl_text2.frame.origin.y+0, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x-12, lbl_text3.frame.origin.y+0, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x-13, lbl_text4.frame.origin.y-5, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x-8, lbl_text5.frame.origin.y-5, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    
                }
                else if ([UIScreen mainScreen].bounds.size.height == 568)
                {
                    imageViewRateTopConstant.constant = 20;
                    imageviewRateBotomCOnstaint.constant = 25 ;

//
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+20, imgerate.frame.origin.y, imgerate.frame.size.width-5, imgerate.frame.size.height);
                    
                    
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x + 10, btnmain.frame.origin.y-14, btnmain.frame.size.width+10, btnmain.frame.size.height+10);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x + 8, btn_color1.frame.origin.y-45, btn_color1.frame.size.width+20, btn_color1.frame.size.height+10);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x+18, btn_color2.frame.origin.y-34, btn_color2.frame.size.width+20, btn_color2.frame.size.height+12);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+22, btn_color3.frame.origin.y-19, btn_color3.frame.size.width+20, btn_color3.frame.size.height+15);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x+20, btn_color4.frame.origin.y-10, btn_color4.frame.size.width+20, btn_color4.frame.size.height+18);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x + 5, btn_color5.frame.origin.y + 15, btn_color5.frame.size.width+24, btn_color5.frame.size.height+15);
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x + 35, lbl_text1.frame.origin.y-17-18, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+51, lbl_text2.frame.origin.y-12-10, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+52, lbl_text3.frame.origin.y-7-1, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+44, lbl_text4.frame.origin.y + 8, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+34, lbl_text5.frame.origin.y + 22, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    
                }
                else if ([UIScreen mainScreen].bounds.size.height == 667)
                {
                    imageViewRateTopConstant.constant = 25;
                    imageviewRateBotomCOnstaint.constant = 30 ;
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+35, imgerate.frame.origin.y, imgerate.frame.size.width-30, imgerate.frame.size.height+9);
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x, btnmain.frame.origin.y-22, btnmain.frame.size.width+30, btnmain.frame.size.height+26);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x - 10, btn_color1.frame.origin.y-75, btn_color1.frame.size.width+50, btn_color1.frame.size.height+33);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x+ 6, btn_color2.frame.origin.y-58, btn_color2.frame.size.width+50, btn_color2.frame.size.height+35);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+18, btn_color3.frame.origin.y-35, btn_color3.frame.size.width+50, btn_color3.frame.size.height+36);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x + 10, btn_color4.frame.origin.y-12, btn_color4.frame.size.width+50, btn_color4.frame.size.height+35);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x - 10, btn_color5.frame.origin.y + 10, btn_color5.frame.size.width+50, btn_color5.frame.size.height + 35);
                    
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x+30, lbl_text1.frame.origin.y-54, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+47, lbl_text2.frame.origin.y-35, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+51, lbl_text3.frame.origin.y-14, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+43, lbl_text4.frame.origin.y +10, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+28, lbl_text5.frame.origin.y+35, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    //NSLog(@"667");
                }
                else if ([UIScreen mainScreen].bounds.size.height == 736)
                {
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+35, imgerate.frame.origin.y, imgerate.frame.size.width-26, imgerate.frame.size.height+20);
//

                    imageViewRateTopConstant.constant = 25;
                    imageviewRateBotomCOnstaint.constant = 30 ;
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x-8, btnmain.frame.origin.y-29, btnmain.frame.size.width+38, btnmain.frame.size.height+30);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x-10, btn_color1.frame.origin.y-100, btn_color1.frame.size.width+64, btn_color1.frame.size.height+50);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x + 10, btn_color2.frame.origin.y-70, btn_color2.frame.size.width+60, btn_color2.frame.size.height+45);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+15, btn_color3.frame.origin.y-45, btn_color3.frame.size.width+65, btn_color3.frame.size.height+48);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x , btn_color4.frame.origin.y - 20, btn_color4.frame.size.width+70, btn_color4.frame.size.height+50);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x-20, btn_color5.frame.origin.y + 10, btn_color5.frame.size.width+70, btn_color5.frame.size.height+48);
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x+29, lbl_text1.frame.origin.y-70, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+48, lbl_text2.frame.origin.y-48, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+53, lbl_text3.frame.origin.y-18, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+44, lbl_text4.frame.origin.y+12, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+26, lbl_text5.frame.origin.y+40, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                }
                else if ([UIScreen mainScreen].bounds.size.height == 812)
                {
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+35, imgerate.frame.origin.y, imgerate.frame.size.width-26, imgerate.frame.size.height+20);
                    // for iphone x
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x-8 , btnmain.frame.origin.y-14, btnmain.frame.size.width+29, btnmain.frame.size.height+27);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x - 15, btn_color1.frame.origin.y-50, btn_color1.frame.size.width+60, btn_color1.frame.size.height+40);
                    
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x + 5, btn_color2.frame.origin.y-40, btn_color2.frame.size.width+54, btn_color2.frame.size.height+28);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+10, btn_color3.frame.origin.y-35, btn_color3.frame.size.width+60, btn_color3.frame.size.height+42);
                    
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x , btn_color4.frame.origin.y-23, btn_color4.frame.size.width+60, btn_color4.frame.size.height+40);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x - 20, btn_color5.frame.origin.y - 10 , btn_color5.frame.size.width+60, btn_color5.frame.size.height+48);
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x+32, lbl_text1.frame.origin.y-32, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+53, lbl_text2.frame.origin.y-20, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+58, lbl_text3.frame.origin.y-8, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+48, lbl_text4.frame.origin.y+10, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+30, lbl_text5.frame.origin.y+20, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                }
            }
        }
    }
    else
    {
        if([self isPad])
        {
            if ([self isPortrait])
            {
                
            }
        }
        else
        {
            if ([self isPortrait])
            {
                btn_color1.layer.cornerRadius=btn_color1.frame.size.height/3;
                btn_color1.layer.masksToBounds=YES;
                
                btn_color2.layer.cornerRadius=btn_color2.frame.size.height/3;
                btn_color2.layer.masksToBounds=YES;
                
                btn_color3.layer.cornerRadius=btn_color3.frame.size.height/3;
                btn_color3.layer.masksToBounds=YES;
                
                btn_color4.layer.cornerRadius=btn_color4.frame.size.height/3;
                btn_color4.layer.masksToBounds=YES;
                
                btn_color5.layer.cornerRadius=btn_color5.frame.size.height/3;
                btn_color5.layer.masksToBounds=YES;
                
                //NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
                if ([UIScreen mainScreen].bounds.size.height == 480) {
                    //NSLog(@"480");
                    imgerate.frame=CGRectMake(imgerate.frame.origin.x-0, imgerate.frame.origin.y, imgerate.frame.size.width, imgerate.frame.size.height+10);
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x+10, btnmain.frame.origin.y, btnmain.frame.size.width, btnmain.frame.size.height);
                    
                    int f=20;
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x-5, btn_color1.frame.origin.y+20-f, btn_color1.frame.size.width-5, btn_color1.frame.size.height-5);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x-10, btn_color2.frame.origin.y+15-f, btn_color2.frame.size.width-5, btn_color2.frame.size.height-5);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x-12, btn_color3.frame.origin.y+15-f, btn_color3.frame.size.width-5, btn_color3.frame.size.height-5);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x-10, btn_color4.frame.origin.y+11-f, btn_color4.frame.size.width-5, btn_color4.frame.size.height-5);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x-5, btn_color5.frame.origin.y+8-f, btn_color5.frame.size.width-5, btn_color5.frame.size.height-5);
                    
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x-5, lbl_text1.frame.origin.y+4, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x-10, lbl_text2.frame.origin.y+0, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x-12, lbl_text3.frame.origin.y+0, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x-13, lbl_text4.frame.origin.y-5, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x-8, lbl_text5.frame.origin.y-5, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    
                }
                else if ([UIScreen mainScreen].bounds.size.height == 568)
                {
                    
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+20, imgerate.frame.origin.y, imgerate.frame.size.width-5, imgerate.frame.size.height);
                    
                    imageViewRateTopConstant.constant = 20;
                    imageviewRateBotomCOnstaint.constant = 25 ;
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x + 5, btnmain.frame.origin.y-8, btnmain.frame.size.width+11, btnmain.frame.size.height+10);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x + 15, btn_color1.frame.origin.y-45, btn_color1.frame.size.width+20, btn_color1.frame.size.height+20);
                    
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x + 35, btn_color2.frame.origin.y-32, btn_color2.frame.size.width+20, btn_color2.frame.size.height+18);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+50, btn_color3.frame.origin.y-19, btn_color3.frame.size.width+20, btn_color3.frame.size.height+15);
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x + 25 , btn_color4.frame.origin.y - 10, btn_color4.frame.size.width+30, btn_color4.frame.size.height+18);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x , btn_color5.frame.origin.y + 10, btn_color5.frame.size.width+30, btn_color5.frame.size.height+25);
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x + 63, lbl_text1.frame.origin.y-17-15, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+92, lbl_text2.frame.origin.y-12-8, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+94, lbl_text3.frame.origin.y-7-1, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+80, lbl_text4.frame.origin.y + 12, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+58, lbl_text5.frame.origin.y + 20, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    
                }
                else if ([UIScreen mainScreen].bounds.size.height == 667)
                {
                    imageViewRateTopConstant.constant = 25;
                    imageviewRateBotomCOnstaint.constant = 30 ;
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+35, imgerate.frame.origin.y, imgerate.frame.size.width-30, imgerate.frame.size.height+9);
//
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x, btnmain.frame.origin.y-18, btnmain.frame.size.width+30, btnmain.frame.size.height+24);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x , btn_color1.frame.origin.y-65, btn_color1.frame.size.width+50, btn_color1.frame.size.height+28);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x + 25, btn_color2.frame.origin.y-52, btn_color2.frame.size.width+50, btn_color2.frame.size.height+35);
                
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x + 45, btn_color3.frame.origin.y-35, btn_color3.frame.size.width+50, btn_color3.frame.size.height+36);
                    
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x + 30, btn_color4.frame.origin.y - 10, btn_color4.frame.size.width+50, btn_color4.frame.size.height+35);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x - 5, btn_color5.frame.origin.y + 8 , btn_color5.frame.size.width+50, btn_color5.frame.size.height + 35);
                    
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x+54, lbl_text1.frame.origin.y-50, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+86, lbl_text2.frame.origin.y-30, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+92, lbl_text3.frame.origin.y-14, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+78, lbl_text4.frame.origin.y + 12, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+53, lbl_text5.frame.origin.y+30, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                    //NSLog(@"667");
                }
                else if ([UIScreen mainScreen].bounds.size.height == 736)
                {
//                    imgerate.frame=CGRectMake(imgerate.frame.origin.x+35, imgerate.frame.origin.y , imgerate.frame.size.width-26, imgerate.frame.size.height+20);
                    imageViewRateTopConstant.constant = 25;
                    imageviewRateBotomCOnstaint.constant = 35 ;
                    
                    btnmain.frame=CGRectMake(btnmain.frame.origin.x-12, btnmain.frame.origin.y-22, btnmain.frame.size.width+35, btnmain.frame.size.height+30);
                    
                    btn_color1.frame=CGRectMake(btn_color1.frame.origin.x + 5, btn_color1.frame.origin.y-85, btn_color1.frame.size.width+60, btn_color1.frame.size.height+45);
                    btn_color2.frame=CGRectMake(btn_color2.frame.origin.x + 30, btn_color2.frame.origin.y-65, btn_color2.frame.size.width+70, btn_color2.frame.size.height+45);
                    btn_color3.frame=CGRectMake(btn_color3.frame.origin.x+57, btn_color3.frame.origin.y-45, btn_color3.frame.size.width+60, btn_color3.frame.size.height+48);
                    
                    btn_color4.frame=CGRectMake(btn_color4.frame.origin.x+ 25, btn_color4.frame.origin.y-22, btn_color4.frame.size.width+70, btn_color4.frame.size.height+50);
                    btn_color5.frame=CGRectMake(btn_color5.frame.origin.x, btn_color5.frame.origin.y , btn_color5.frame.size.width+60, btn_color5.frame.size.height+48);
                    
                    lbl_text1.frame=CGRectMake(lbl_text1.frame.origin.x+50, lbl_text1.frame.origin.y-62, lbl_text1.frame.size.width, lbl_text1.frame.size.height);
                    lbl_text2.frame=CGRectMake(lbl_text2.frame.origin.x+86, lbl_text2.frame.origin.y-40, lbl_text2.frame.size.width, lbl_text2.frame.size.height);
                    lbl_text3.frame=CGRectMake(lbl_text3.frame.origin.x+92, lbl_text3.frame.origin.y-15, lbl_text3.frame.size.width, lbl_text3.frame.size.height);
                    lbl_text4.frame=CGRectMake(lbl_text4.frame.origin.x+75, lbl_text4.frame.origin.y+10, lbl_text4.frame.size.width, lbl_text4.frame.size.height);
                    lbl_text5.frame=CGRectMake(lbl_text5.frame.origin.x+46, lbl_text5.frame.origin.y+35, lbl_text5.frame.size.width, lbl_text5.frame.size.height);
                }
                
            }
        }
    }

    
    
   // if (@available(iOS 11, *)) {
        
   
}


-(void)slideToRightWithGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.9
                              delay:0.9
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         completion:^(BOOL finished){}];
        

}

-(void)viewWillAppear:(BOOL)animated
{

     _lableComment.layer.cornerRadius  = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnBusinessNameClicked:(UIButton *)sender;
{
//    UIButton *btn = (UIButton *)sender;
    NSString *strLink = [self.dic_rate objectForKey:@"website_link"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLink]];
}

-(IBAction)touchDone:(id)sender
{

    NSString *u_id=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
    NSString *u_trac=[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"id"]];
    NSString *u_rate=[NSString stringWithFormat:@"%d",num_rate];
    
    if (num_rate == 0)
    {
        UIAlertView *alt_show=[[UIAlertView alloc] initWithTitle:nil message:@"Please rate first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alt_show show];
        
    }
    else
    {
        mc=[[ModelClass alloc]init];
        mc.delegate=self;
        [mc Addrate:u_id trac_id:u_trac rate:u_rate isCheck:ischeck selector:@selector(responseFromRate:)];
        
    }
}


-(IBAction)comment:(id)sender
{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    UIViewController *mainView = appDelegate.window.rootViewController;
//    NSLog(@"%@", appDelegate.window.rootViewController);
//
//    UIView * viewMain ;
//    viewMain.frame   = CGRectMake(mainView.view.frame.origin.x, mainView.view.frame.origin.y, mainView.view.frame.size.width
//                          ,mainView.view.frame.size.height);
//    viewMain.backgroundColor  =  [UIColor redColor];
////    [self.view.window.rootViewController.view addSubview:viewMain];
//    [appDelegate.tabBarController.view removeFromSuperview];
//    [self.view.window.rootViewController.view addSubview:viewMain];
//
////    [appDelegate.window addSubview:viewMain];
////    [appDelegate.window makeKeyAndVisible];
//
//
//
////    UIWindow * window ;
////    [window addSubview:viewMain];
////    [window makeKeyAndVisible];
    
    if (num_rate>0) {
        obj_view_comment.hidden=NO;

    }
    else{

        UIAlertView *alt_show=[[UIAlertView alloc] initWithTitle:nil message:@"Please rate first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt_show show];

    }
}


-(void)responseFromRate:(NSDictionary*)dic
{
    
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"Success"])
    {
       
            UIAlertView *alt_show=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            alt_show.tag=101;
            [alt_show show];
            [self timedAlert:alt_show];
     
    }
    else    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"error"])
    {
        UIAlertView *alt_show=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        alt_show.tag=101;
        
        [alt_show show];
    }
    
   
}


-(void)timedAlert:(UIAlertView *) alert
{
    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2];
}

-(void)dismissAlert:(UIAlertView *) alertView
{
    [alertView dismissWithClickedButtonIndex:nil animated:YES];
    [[self navigationController] popViewControllerAnimated:YES];

}


-(void)subscribe
{
    //scroll_popup.hidden=NO;
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101)
    {
           [self performSelector:@selector(subscribe) withObject:self afterDelay:0.9 ];
           [self.navigationController popViewControllerAnimated:YES];

    }
    else if (alertView.tag == 102)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(IBAction)touch_rate1:(id)sender
{
    
     [btncoment setTitleColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0] forState:normal];
    
    num_rate=5;
    [btnmain setImage:[UIImage imageNamed:@"s_rate1.png"] forState:UIControlStateNormal];
}
-(IBAction)touch_rate2:(id)sender
{ [btncoment setTitleColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0] forState:normal];
    num_rate=4;
    [btnmain setImage:[UIImage imageNamed:@"s_rate2"] forState:UIControlStateNormal];
}
-(IBAction)touch_rate3:(id)sender
{ [btncoment setTitleColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0] forState:normal];  num_rate=3;
    [btnmain setImage:[UIImage imageNamed:@"s_rate3.png"] forState:UIControlStateNormal];
}
-(IBAction)touch_rate4:(id)sender
{ [btncoment setTitleColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0] forState:normal]; num_rate=2;
    [btnmain setImage:[UIImage imageNamed:@"s_rate4.png"] forState:UIControlStateNormal];
}
-(IBAction)touch_rate5:(id)sender
{ [btncoment setTitleColor:[UIColor colorWithRed:0/255.0 green:119.0/255.0 blue:181.0/255.0 alpha:1.0] forState:normal];  num_rate=1;
    [btnmain setImage:[UIImage imageNamed:@"s_rate5.png"] forState:UIControlStateNormal];
}

-(BOOL)isPad {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }else {
        return NO;
    }
}
-(BOOL)isPortrait {
    
    //critical change by krishna
    
    return YES;
    
  //  return UIDeviceOrientationIsPortrait(self.interfaceOrientation);
}

-(IBAction)touch_help:(id)sender
{
    
    
    [DELEGATE hidePopup];
    HelpViewController *help_obj=[[HelpViewController alloc]init];
    [self.navigationController pushViewController:help_obj animated:YES];
    
    
}


-(IBAction)touch_cancel:(id)sender
{

    obj_view_comment.hidden=YES;
    [txt_message resignFirstResponder];
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
        [txt_message resignFirstResponder];
        mc=[[ModelClass alloc]init];
        mc.delegate=self;
        if ([Validate isConnectedToNetwork])
        {
            [txt_message resignFirstResponder];
            [mc addcomment:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] tracid:[NSString stringWithFormat:@"%@",[self.dic_rate objectForKey:@"id"]] text:[NSString stringWithFormat:@"%@",txt_message.text] ischeck:ischeck ischeck2:ischeck2 selector:@selector(addcomments:)];
        }
    }
    
}

-(void)addcomments:(NSDictionary*)dic
{
 
    
    if ([[[dic valueForKey:@"code"]stringValue] isEqualToString:@"200"])
            {
                txt_message.text=nil;
            }

         UIAlertView *alt_show=[[UIAlertView alloc] initWithTitle:nil message:[dic valueForKey:@"message"] delegate:NO cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];;
                [alt_show show];

    obj_view_comment.hidden=YES;
    [txt_message resignFirstResponder];

}


-(IBAction)btnChek:(id)sender
{
    if (ischeck) {
         ischeck=NO;
//         btnCheckbox.frame=CGRectMake(34, 276, 21, 22);
         [btnCheckbox setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
    }
    else{
         ischeck=YES;
//         btnCheckbox.frame=CGRectMake(34, 276, 28, 22);
         [btnCheckbox setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
    }
}

-(IBAction)btnChek2:(id)sender
{
    if(ischeck2) {
        ischeck2=NO;
//        btnCheckbox2.frame=CGRectMake(165, 276, 21, 22);
        [btnCheckbox2 setImage:[UIImage imageNamed:@"unticks"] forState:UIControlStateNormal];
        
    }
    else{
        ischeck2=YES;
//        btnCheckbox2.frame=CGRectMake(165, 276, 28, 22);
        [btnCheckbox2 setImage:[UIImage imageNamed:@"ticks"] forState:UIControlStateNormal];
        
    }
    
}

@end
