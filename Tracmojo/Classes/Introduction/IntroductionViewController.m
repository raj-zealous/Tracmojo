//
//  IntroductionViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 14/10/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "IntroductionViewController.h"
#import "UserLoginForm.h"
#import <QuartzCore/QuartzCore.h>
#import "Dashboard.h"

@interface IntroductionViewController ()
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSArray *pageImages;


@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.alwaysBounceHorizontal = false;
    self.automaticallyAdjustsScrollViewInsets = NO;
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    /*self.pageImages = [NSArray arrayWithObjects:
                       self.view_1,
                       self.view_2,
                       self.view_3,
                       self.view_4,
                       nil];

    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 4;
    self.pageViews = [[NSMutableArray alloc] init];

    
    for (NSInteger i = 0; i <4; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }*/
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.scrollView.bounds  = self.view.bounds;
    self.scrollView.bounces  = false;
    self.scrollView.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    self.btn_got.layer.cornerRadius = 22;
    self.btn_got.clipsToBounds = YES;
    self.btn_got.layer.borderColor=[UIColor blackColor].CGColor;
    self.btn_got.layer.borderWidth=0.7;
    self.scrollView.pagingEnabled = TRUE;
    
    self.scrollView.bounces = false;

    for (int i=0; i<6; i++) {
        UIImageView *imgHelp = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, self.view.frame.origin.x, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imgHelp.image = [UIImage imageNamed:[NSString stringWithFormat:@"help_bg_%d",i+1]];
        imgHelp.bounds =  self.scrollView.bounds;
        imgHelp.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imgHelp];
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*6, self.scrollView.frame.size.height)];
    self.pageControl.numberOfPages = 6;
    self.automaticallyAdjustsScrollViewInsets = NO;

}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    float width = scrollView.frame.size.width;
    float xPos = scrollView.contentOffset.x;
    
    //Calculate the page we are on based on x coordinate position and width of scroll view
    self.pageControl.currentPage = (int)xPos/width;
    
    if(self.pageControl.currentPage == 5){
        btnCloseHelp.hidden = TRUE;
        btnLetsGo.hidden = FALSE;
    }else{
        btnCloseHelp.hidden = FALSE;
        btnLetsGo.hidden = TRUE;
    }
}


-(IBAction)BtnCloseHelpScreen:(id)sender{
    //[[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"help"];
    
    DELEGATE.isfirsttime = false;
    
    Dashboard *dash=[[Dashboard alloc]init];
    dash.strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    dash.str_callinvitation=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"callinvitation"]];
    
//    UIAlertView *alt_msg=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"messageKey"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    alt_msg.tag=112;
    
    [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    

//    UserLoginForm  *objview=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
//    UINavigationController *objnvg=[[UINavigationController alloc] initWithRootViewController:objview];
//    objnvg.navigationBarHidden = true;
//    
//    appDelegate.window.rootViewController=objnvg;
}


-(IBAction)got_clicked:(id)sender{
    
    DELEGATE.isfirsttime = false;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"help"];
    
    Dashboard *dash=[[Dashboard alloc]init];
    dash.strID=[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    dash.str_callinvitation=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"callinvitation"]];
    
//    UIAlertView *alt_msg=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"messageKey"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    alt_msg.tag=112;

    [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    

//    UserLoginForm  *objview=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
//    UINavigationController *objnvg=[[UINavigationController alloc] initWithRootViewController:objview];
//    objnvg.navigationBarHidden = true;
//    
//    appDelegate.window.rootViewController=objnvg;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 112)
    {
        [self.navigationController pushViewController:DELEGATE.tabBarViewControllertracmojo animated:YES];
    }
    else if (alertView.cancelButtonIndex == buttonIndex)
    {
        
    }
    
    
}


/*-(void)loadVisiblePages {

    // First, determine which page is currently visible
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<5; i++) {
        [self purgePage:i];
    }
    
    if(self.pageControl.currentPage  == 4){
        UserLoginForm  *objview=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
        UINavigationController *objnvg=[[UINavigationController alloc] initWithRootViewController:objview];
        objnvg.navigationBarHidden = true;
        appDelegate.window.rootViewController=objnvg;
    }
}


- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >=4) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    CGRect frame = self.scrollView.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIView *newPageView = [self.pageImages objectAtIndex:page];
        //newPageView.contentMode = UIViewContentModeScaleAspectFill;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        
    }
}




-(void)viewWillAppear:(BOOL)animated{
    
    self.btn_got.layer.cornerRadius = 22;
    self.btn_got.clipsToBounds = YES;
    self.btn_got.layer.borderColor=[UIColor blackColor].CGColor;
    self.btn_got.layer.borderWidth=0.7;
    
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:177.0/255.0 green:179.0/255.0 blue:110.0/255.0 alpha:1.0];
    
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, 0);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
}




-(void)purgePage:(NSInteger)page {
    
    if(page < 0 || page >= 4) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePages];
 }

*/

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
