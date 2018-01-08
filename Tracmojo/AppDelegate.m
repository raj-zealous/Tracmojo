//
//  AppDelegate.m
//  Tracmojo
//
//  Created by macmini3 on 20/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//
#import "SBJson.h"
#import "Validate.h"
#import "tracrate.h"
#import "ModelClass.h"
#import "AppDelegate.h"
//#import "ViewController1.h"
#import "ViewController.h"
#import "Dashboard.h"
#import "Popup.h"
#import "GroupTrac.h"
#import "PersonalTracs.h"
#import "PopupView.h"
#import "Reachability.h"
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SettingsViewController.h"
#import "ManageViewController.h"
#import <sqlite3.h>
#import "DarckWaitView.h"
#import "IntroductionViewController.h"
#import "ActivityViewController.h"

//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>

NSString *const FBSessionStateChangedNotification = @"com.Nick.Tracmojo:FBSessionStateChangedNotification";


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //final by chinkal
    
    self.isfirsttime = TRUE;
    
    NSString *currentAppVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    if([currentAppVersion  isEqual: @"1.02"]){
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"IsUpdated"] == TRUE)
        {
            
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"IsUpdated"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] isEqualToString:@"Y"]) {
            
            
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IsUpdated"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
    }
    
    
    
    
    _isyPlus=NO;
    _isOwnerP=NO;
    
    DELEGATE.ischeckadd=YES;
    
    _isbar=NO;
    _isfirst=NO;
    
    _is_addgroup=YES;
    _is_addPersonal=YES;
    
    
    _done=NO;
    
    NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self   selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _isSolid=0;
    _xranges=0;
    
    
    [self openDatabase];
    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    _isGoogle=NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DELEGATE.p_emailArray=[[NSMutableArray alloc] init];
    DELEGATE.f_emailArray=[[NSMutableArray alloc] init];
    DELEGATE.dic_addPersonaltrac=[[NSMutableDictionary alloc] init];
    _groupdic =[[NSMutableDictionary alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"time_stemp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"isfirst"])
    {
        _Islast=NO;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"isFirst" forKey:@"isfirst"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        _Islast=YES;
    }
    
    
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    if (launchOptions !=nil) {
        
        dictionary=[[NSMutableDictionary alloc]initWithDictionary:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]];
        
        if ([[[dictionary valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"comment_add"]) {
            UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[dictionary valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            push_notification.tag=1;
            [push_notification show];
        }
        
        else if ([[[dictionary valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"activity_add"])
        {
            UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[dictionary valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            push_notification.tag=2;
            [push_notification show];
        }
        else if ([[[dictionary valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"conversation_add"])
        {
            UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[dictionary valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            push_notification.tag=3;
            [push_notification show];
        }
    }
    else{
        
    }
    
    [self tabBarViewControllertracmojo];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] isEqualToString:@"Y"]) {
        self.window.rootViewController=DELEGATE.tabBarViewControllertracmojo;
        
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IsAlreadyLoggedIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"IsAlreadyLoggedIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        // if([[[NSUserDefaults standardUserDefaults] valueForKey:@"help"] isEqualToString:@"true"]){
        self.objview=[[UserLoginForm alloc] initWithNibName:@"UserLoginForm" bundle:nil];
        UINavigationController *objnvg=[[UINavigationController alloc] initWithRootViewController:self.objview];
        objnvg.navigationBarHidden=YES;
        self.window.rootViewController=objnvg;
        //  }
        //  else{
        //            IntroductionViewController *obj=[[IntroductionViewController alloc] initWithNibName:@"IntroductionViewController" bundle:nil];
        //            UINavigationController *objnvg1=[[UINavigationController alloc] initWithRootViewController:obj];
        //            objnvg1.navigationBarHidden=YES;
        //            self.window.rootViewController=objnvg1;
        
        
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



-(void)onDoneButtonPressed
{
    
    /*LogInViewController *loginVC = [[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
     _navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
     self.window.rootViewController = self.navigationController;
     
     [self.window makeKeyAndVisible];*/
}


-(void) timerMethod{
    
    if (DELEGATE.connectedToNetwork) {
        DELEGATE.isAvaiable=YES;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
        
    }
    else
    {
        DELEGATE.isAvaiable=NO;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        
    }
}


- (BOOL) connectedToNetwork
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if(remoteHostStatus == NotReachable)
    {
        
        _isInternet=FALSE;
        // [alert show];
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        _isInternet = TRUE;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    { _isInternet = TRUE;
        
    }
    return _isInternet;
}


-(UITabBarController*)tabBarViewControllertracmojo
{
    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.delegate=self;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        // _tabBarController.tabBar.translucent = YES;
    }
    else
    {
        _tabBarController.tabBar.translucent = NO;
        [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        
    }
    
    Dashboard *vc1 = [[Dashboard alloc]initWithNibName:@"Dashboard" bundle:nil];
    SettingsViewController *vc2 = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
// ActivityViewController *vc2 = [[ActivityViewController alloc]initWithNibName:@"ActivityViewController" bundle:nil];
    ViewController *vc3 = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    ManageViewController *vc4 = [[ManageViewController alloc]initWithNibName:@"ManageViewController" bundle:nil];
    
    UINavigationController *navController1=[[UINavigationController alloc]initWithRootViewController:vc1];
    [navController1.navigationBar setHidden:YES];
    if ([navController1 respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navController1.interactivePopGestureRecognizer.enabled = NO;
    }
    
    UINavigationController *navController2=[[UINavigationController alloc]initWithRootViewController:vc2];
    [navController2.navigationBar setHidden:YES];
    if ([navController2 respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navController2.interactivePopGestureRecognizer.enabled = NO;
    }
    UINavigationController *navController3=[[UINavigationController alloc]initWithRootViewController:vc3];
    [navController3.navigationBar setHidden:YES];
    if ([navController3 respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navController3.interactivePopGestureRecognizer.enabled = NO;
    }
    
    UINavigationController *navController4=[[UINavigationController alloc]initWithRootViewController:vc4];
    [navController4.navigationBar setHidden:YES];
    if ([navController4 respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navController4.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    NSArray *tabArrays = [NSArray arrayWithObjects: navController1, navController2,navController3,navController4, nil];
    _tabBarController.viewControllers = tabArrays ;
    [[_tabBarController.tabBar.items objectAtIndex:0]setTitle:@"Home"];
    [[_tabBarController.tabBar.items objectAtIndex:1]setTitle:@"Settings"];
    [[_tabBarController.tabBar.items objectAtIndex:2]setTitle:@"Add trac"];
    [[_tabBarController.tabBar.items objectAtIndex:3]setTitle:@"Edit tracs"];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:55.0/255.0f green:114.0/255.0f blue:185.0/255.0f alpha:1.0],UITextAttributeTextColor,nil,UITextAttributeFont,nil]forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:17.0/255.0f green:0.0/255.0f blue:14.0/255.0f alpha:1.0],UITextAttributeTextColor,nil,UITextAttributeFont,nil]forState:UIControlStateNormal];
    
    [[_tabBarController.tabBar.items objectAtIndex:0]setFinishedSelectedImage:[UIImage imageNamed:@"home_blue"] withFinishedUnselectedImage:[UIImage imageNamed:@"home_gray"]];
    [[_tabBarController.tabBar.items objectAtIndex:1]setFinishedSelectedImage:[UIImage imageNamed:@"setting_select"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting_gray"]];
    [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
    [[_tabBarController.tabBar.items objectAtIndex:3]setFinishedSelectedImage:[UIImage imageNamed:@"select_edit"] withFinishedUnselectedImage:[UIImage imageNamed:@"edit_gray"]];
    return _tabBarController;
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    _isfinal1=NO;
    _isFromReview=NO;
    
    //NSLog(@"%d",(int)tabBarController.selectedIndex);
    
    Popup *alert;
    if (tabBarController.selectedIndex == 2) {
        
        _isfinal1=YES;
        
        if (DELEGATE.ischeckadd)
        {
            [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor redColor] }
                                                     forState:UIControlStateNormal];
            [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"add_gray"] withFinishedUnselectedImage:[UIImage imageNamed:@"close_red"]];
            
            DELEGATE.ischeckadd=NO;
            alert = [[[NSBundle mainBundle] loadNibNamed:@"Popup" owner:self options:nil] lastObject];
            [alert.btngrouptrac addTarget:self action:@selector(touchGroupTrac:) forControlEvents:UIControlEventTouchUpInside];
            [alert.btnpersonaltrac addTarget:self action:@selector(touchPersonalTrac:) forControlEvents:UIControlEventTouchUpInside];
            alert.frame = CGRectMake(0, 1000, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
            alert.tag =1001;
            
            
#pragma 15/4
            for(UIView *element in viewController.view.subviews)
            {
                if ([element isKindOfClass:[Popup class]]) //check if the object is a UIImageView
                {
                    [element removeFromSuperview];
                }
                if (([[UIScreen mainScreen] bounds].size.height) == 812)
                {
                    [UIView animateWithDuration:0.45 animations:^{
                        alert.frame =  CGRectMake(0 ,88,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].applicationFrame.size.height-128);
                        
                    }];
                }
                else
                {
                    [UIView animateWithDuration:0.45 animations:^{
                        alert.frame =  CGRectMake(0 ,64,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].applicationFrame.size.height-95);
                        
                    }];
                }
                
                
               
                
                self.isNewTrackSelected = YES;
                
                [DELEGATE.window addSubview:alert];
                
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"dash"])
                {
                    DELEGATE.tabBarController.selectedIndex=0;
                }
                else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"setting"])
                {
                    DELEGATE.tabBarController.selectedIndex=1;
                }
                else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"manage"])
                {
                    DELEGATE.tabBarController.selectedIndex=3;
                }

            }
            
        }
        else
        {
            
            DELEGATE.ischeckadd=YES;
            DELEGATE.isNewTrackSelected=YES;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"dash"])
            {
                DELEGATE.tabBarController.selectedIndex=0;
            }
            else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"setting"])
            {
                DELEGATE.tabBarController.selectedIndex=1;
            }
            else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"]isEqualToString:@"manage"])
            {
                DELEGATE.tabBarController.selectedIndex=3;
            }
            
            [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                                     forState:UIControlStateNormal];
            
            [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                                     forState:UIControlStateSelected];
            [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
            
            
            for (UIView *view in self.window.subviews) {
                
                if (view.tag == 1001) {
                    [view removeFromSuperview];
                }
                
            }
        }
        
    }
    else
    {
        DELEGATE.ischeckadd=YES;
        //  [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor redColor] }
        //   forState:UIControlStateNormal];
        
        for (UIView *view in self.window.subviews) {
            
            if (view.tag == 1001) {
                [view removeFromSuperview];
            }
            
        }
        
        [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor]
                                                             }
                                                 forState:UIControlStateNormal];
        [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor]
                                                             }
                                                 forState:UIControlStateNormal];
        
    }
}


-(IBAction)touchPersonalTrac:(id)sender
{
    
    
    
    
    _isFromReview=NO;
    //    if (DELEGATE.is_addPersonal) {
    //
    //        UIAlertView *alter_msg=[[UIAlertView alloc] initWithTitle:nil message:@"Sorry! You can't add anymore personal trac" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //
    //        [alter_msg show];
    //
    //    }
    //
    //    else{
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        PersonalTracs *gotPersonal=[[PersonalTracs alloc] initWithNibName:@"PersonalTracs" bundle:nil];
        
        [DELEGATE.p_emailArray removeAllObjects];
        [DELEGATE.f_emailArray removeAllObjects];
        _isgroup=NO;
        DELEGATE.isEdit=NO;
        DELEGATE.dic_edittrac=nil;
        UINavigationController *nvg=[[UINavigationController alloc] initWithRootViewController:gotPersonal];
        nvg.navigationBarHidden=YES;
        self.window.rootViewController=nvg;
    });
    
    for (UIView *view in self.window.subviews) {
        
        if (view.tag == 1001) {
            [view removeFromSuperview];
        }
        
    }
    
    //}
}
-(IBAction)touchGroupTrac:(id)sender
{    dispatch_async(dispatch_get_main_queue(), ^{
    _isFromReview=NO;
    _isgroup=YES;
    GroupTrac *gotPersonal=[[GroupTrac alloc] initWithNibName:@"GroupTrac" bundle:nil];
    DELEGATE.isEdit=NO;
    DELEGATE.dic_edittrac=nil;
    [DELEGATE.f_emailArray removeAllObjects];
    [DELEGATE.p_emailArray removeAllObjects];
    UINavigationController *nvg=[[UINavigationController alloc] initWithRootViewController:gotPersonal];
    nvg.navigationBarHidden=YES;
    self.window.rootViewController=nvg;
});
    
    for (UIView *view in self.window.subviews) {
        
        if (view.tag == 1001) {
            [view removeFromSuperview];
        }
        
    }
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            if ([Validate isConnectedToNetwork])
            {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"aps"] objectForKey:@"trac_id"]] invitation_type:@"follow" action_chosen:@"a" selector:@selector(getResponseFromFollowers:)];
            }
        }
        else if(buttonIndex == 1)
        {
            if ([Validate isConnectedToNetwork])
            {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"aps"] objectForKey:@"trac_id"]] invitation_type:@"follow" action_chosen:@"d" selector:@selector(getResponseFromFollowers:)];
            }
        }
    }
    else  if (alertView.tag == 3)
    {
        if (buttonIndex == 0)
        {
            if ([Validate isConnectedToNetwork])
            {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"aps"] objectForKey:@"trac_id"]] invitation_type:@"participate" action_chosen:@"a" selector:@selector(getResponseFromFollowers:)];
            }
        }
        else if(buttonIndex == 1)
        {
            if ([Validate isConnectedToNetwork])
            {
                [mc followed_user_id:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]] trac_id:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"aps"] objectForKey:@"trac_id"]] invitation_type:@"participate" action_chosen:@"d" selector:@selector(getResponseFromFollowers:)];
            }
        }
        
    }
    else  if (alertView.tag == 9)
    {
        if (buttonIndex == 0)
        {
            
        }
    }
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    
    DarckWaitView *drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    [drk hide];
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badge"] intValue];
    
    dictionary=[[NSMutableDictionary alloc]initWithDictionary:userInfo];
    
    //NSLog(@"%@",dictionary);
    if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"contact"]) {
        
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        push_notification.tag=1;
        [push_notification show];
    }
    
    
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"follow_invitation"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:@"Decline", nil];
        push_notification.tag=2;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"participate_invitation"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:@"Decline", nil];
        push_notification.tag=3;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"tracrated"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=4;
        [push_notification show];
    }
    //change code
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"trac_changed"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=5;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"trac_deleted"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=6;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"respondtracinvitation"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=7;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"contactuser"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=8;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"trac_due"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=9;
        [push_notification show];
    }
    else if ([[[userInfo valueForKey:@"aps"]valueForKey:@"message" ]isEqualToString:@"weeklyreminder"])
        
    {
        UIAlertView *push_notification=[[UIAlertView alloc]initWithTitle:nil message:[[userInfo valueForKey:@"aps"]valueForKey:@"alert" ] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        push_notification.tag=10;
        [push_notification show];
    }
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    if (deviceToken) {
        
        self.tokenstring =[NSString stringWithFormat:@"%@",deviceToken];
        
        self.tokenstring = [_tokenstring stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        self.tokenstring = [[NSString alloc]initWithFormat:@"%@",[self.tokenstring stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        NSLog(@"tokenstring is %@",self.tokenstring);
        
        
    }
    
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    self.tokenstring=@"123456789";
    
    
}


-(void)getResponseFromFollowers:(NSMutableDictionary*)dic
{
    
    if ([[dic objectForKey:@"status"] isEqualToString:@"Success"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
    DarckWaitView * dark=[[DarckWaitView alloc]init];
    
    [dark hide];
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    if ([[[[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"] objectAtIndex:0]isEqualToString:@"fb810413249007722"]) {
        
        BOOL wasHandled = [FBAppCall handleOpenURL:url
                                 sourceApplication:sourceApplication];
        return wasHandled;
        
    }
    //    else if([[[[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"] objectAtIndex:0]isEqualToString:@"db-ud9pddjohl8f7p1"]){
    //        return NO;
    //    }
    else
    {
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    //NSArray *permissionsNeeded = @[@"basic_info", @"read_stream"];
    
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             
                                             if (!error) {
                                                 [FBSession setActiveSession:session];
                                             }
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                
            }
            break;
        case FBSessionStateClosed:
            
            break;
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        
    }
}

-(void)setKey:(NSString*)title
{
    [[NSUserDefaults standardUserDefaults] setValue:title
                                             forKey:@"title"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)hidePopup
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                             forState:UIControlStateSelected];
    [[_tabBarController.tabBar.items objectAtIndex:2]setFinishedSelectedImage:[UIImage imageNamed:@"close_red"] withFinishedUnselectedImage:[UIImage imageNamed:@"add_gray"]];
    
    
    for (UIView *view in self.window.subviews) {
        
        if (view.tag == 1001) {
            [view removeFromSuperview];
        }
        
    }
    
}
-(BOOL)openDatabase {
    
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"tracmojo.sqlite"];
    //NSLog(@"%@",dbPath);
    if (sqlite3_open([dbPath UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    BOOL res = [self createDatabase];
    
    return res;
}
-(BOOL)createDatabase {
    NSString *ddlPath = [[NSBundle mainBundle] pathForResource:@"/tracmojo" ofType:@"sql"];
    NSString *ddl = [NSString stringWithContentsOfFile:ddlPath encoding:NSUTF8StringEncoding error:NULL];
    if (sqlite3_exec(_database, [ddl UTF8String], nil,nil,nil) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    return YES;
}


-(void)inserttrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type
{
    trac_data=[trac_data stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO tracmojo (trac_id,trac_data,trac_type) VALUES (%@,'%@','%@') ",trac_id,trac_data ,trac_type];
    [self executeSQL:sql];
}


-(void)deletetrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type
{
    NSString* sql = [NSString stringWithFormat:@"DELETE from tracmojo where trac_id=%@ AND trac_type = '%@' ",trac_id,trac_type];
    [self executeSQL:sql];
}

-(void)updatetrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type
{
    trac_data=[trac_data stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    NSString* sql = [NSString stringWithFormat:@"UPDATE tracmojo set (trac_data) VALUES ('%@') where trac_id=%@ AND trac_type='%@'",trac_data,trac_id,trac_type];
    [self executeSQL:sql];
}

-(BOOL)selectAlltrac:(NSString *)all_trac
{
    sqlite3_stmt *selectStatement;
    NSMutableArray *array_followed=[[NSMutableArray alloc] init];
    NSMutableArray *array_group=[[NSMutableArray alloc] init];
    NSMutableArray *array_personal=[[NSMutableArray alloc] init];
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM tracmojo"];
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            
            
            if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"f"])
            {
                NSString *str_follow=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
                [array_followed addObject:str_follow];
            }
            else if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"p"])
            {
                NSString *str_follow=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
                [array_personal addObject:str_follow];
                
            }
            else if ([[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 2)]isEqualToString:@"g"])
            {
                NSString *str_follow=[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text( selectStatement, 1)];
                [array_group addObject:str_follow];
                
            }
        }
        
    }
    else
    {
        
    }
    sqlite3_finalize(selectStatement);
    return YES;
}



-(BOOL)selecttrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type
{
    NSString* sql = [NSString stringWithFormat:@"SELECT trac_id from tracmojo where trac_id=%@ AND trac_type='%@'",trac_id,trac_type];
    if ([self executeSQL:sql]) {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

-(BOOL)executeSQL:(NSString*)sql {
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database,[sql UTF8String],-1,&statement,NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) != SQLITE_DONE) {
            return NO;
        }
    }
    return YES;
}
@end

