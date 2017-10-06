//
//  AppDelegate.h
//  Tracmojo
//
//  Created by macmini3 on 20/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginForm.h"
#import "ModelClass.h"
#import <sqlite3.h>
#import "ABCIntroView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

     ModelClass *mc;
     UserLoginForm *objview;
    

     NSMutableDictionary *dictionary;
}
-(UITabBarController*)tabBarViewControllertracmojo;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property(nonatomic,strong)UserLoginForm *objview;
@property(nonatomic) sqlite3 *database;

//Suhail
@property (strong, nonatomic) NSString *tokenstring,*email,*password;
@property(nonatomic,strong)ABCIntroView *introView;

//
@property (nonatomic)BOOL Islast,done,is_addPersonal,is_addgroup;


@property(nonatomic,assign) BOOL ischeckadd;
@property(nonatomic,assign) BOOL seletedIndex;
@property(nonatomic,assign) BOOL isNewTrackSelected;
@property(nonatomic,assign) BOOL isfirsttime;


@property (nonatomic) BOOL isInternet;
@property(nonatomic)BOOL isCheckNetWork;
@property(nonatomic)BOOL isAvaiable;
@property(nonatomic)BOOL isnavigateBack;





@property (nonatomic) BOOL isEdit,isyPlus;
@property (nonatomic) BOOL isGoogle,isgroup;
@property (nonatomic,retain) NSString *isTrac;

@property(strong,nonatomic)NSMutableDictionary *dic_addPersonaltrac;
@property(strong,nonatomic)NSMutableDictionary *dic_edittrac;
@property(strong,nonatomic)NSMutableDictionary *groupdic;
@property(strong,nonatomic)NSDictionary *dic_getdata;


@property(assign)int str_xvalue;

@property(assign) int xranges;
@property(assign) BOOL isSolid,isbar,isfirst,isFromReview,isOwnerP;
@property(strong,nonatomic)NSMutableArray *contact_followers;
@property(strong,nonatomic)NSMutableArray *contact_participants;
@property(strong,nonatomic) NSMutableArray *p_emailArray;
@property(strong,nonatomic) NSMutableArray *f_emailArray;
@property(nonatomic)BOOL ischkFollowers,istemp9,isma,isfinal1;







extern NSString *const FBSessionStateChangedNotification;

-(void)setKey:(NSString*)title;
- (BOOL) connectedToNetwork;
-(BOOL)openDatabase;
-(void)hidePopup;

//offline
-(void)inserttrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type;
-(void)updatetrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type;
-(void)deletetrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type;;
-(BOOL)selecttrac_id:(NSString *)trac_id trac_data:(NSString *)trac_data trac_type:(NSString *)trac_type;
-(BOOL)selectAlltrac:(NSString *)all_trac;
@end
