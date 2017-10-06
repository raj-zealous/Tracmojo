//
//  IntroductionViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 14/10/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface IntroductionViewController : UIViewController{

    AppDelegate *appDelegate;
    IBOutlet UIButton *btnCloseHelp,*btnLetsGo;
}

@property(nonatomic,weak)IBOutlet UIView *view_1;
@property(nonatomic,weak)IBOutlet UIView *view_2;
@property(nonatomic,weak)IBOutlet UIView *view_3;
@property(nonatomic,weak)IBOutlet UIView *view_4;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

//@property (nonatomic, strong) IBOutlet UIPageControl *page;
//@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property(nonatomic,weak)IBOutlet UIButton *btn_got;


-(IBAction)BtnCloseHelpScreen:(id)sender;


@end
