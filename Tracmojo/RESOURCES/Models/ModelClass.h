//
//  ModelClass.h
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import "JSON.h"

#import <Foundation/Foundation.h>
#import "DarckWaitView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@class DarckWaitView;

@interface ModelClass : NSObject {
    DarckWaitView *drk;
    SEL responseselector;
    NSString * URL;
    
    BOOL isHostAvailable;
    //SEL sel;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, readwrite) BOOL success;

-(void)addfollowercomment:(NSString*)userid tracid:(NSString *)tracid text:(NSString *)text selector:(SEL)sel;


-(void)setsettingsfortime:(NSString *)userid notification_preferred_time:(NSString*)notification_preferred_time value:(NSString*)value selector:(SEL)sel;
-(void)getsettings:(NSString *)userid selector:(SEL)sel;
//SOCIAL

-(void)setsettings:(NSString *)userid notification_type:(NSString*)notification_type value:(NSString*)value selector:(SEL)sel;

//http://192.168.1.100/apps/tracmojo/web/api/forms/loginviasocial.php
-(void)Social_Media_Type:(NSString *)social_media_type UuserID:(NSString *)userid Email_id:(NSString *)email_id first_name:(NSString *)first_name last_name:(NSString *)last_name Device_id:(NSString *)device_id Device_type:(NSString *)device_type Sel:(SEL)sel;

-(void)editprofile:(NSString*)user_id email_id:(NSString *)email sec_emailid:(NSString *)secid name1:(NSString *)name1 name2:(NSString *)name2 Mobile:(NSString *)mobile password:(NSString *)password current:(NSString *)current selector:(SEL)sel;
    
-(void)webpages:(NSString*)title selector:(SEL)sel;


-(void)logoutapi:(NSString*)userid selector:(SEL)sel;

//Login
//http://192.168.1.100/apps/tracmojo/web/api/forms/login.php
-(void)login:(NSString *)email pass:(NSString*)pass device_id:(NSString*)device_id device_type:(NSString*)device_type selector:(SEL)sel;
-(void)myprofile:(NSString*)user_id selector:(SEL)sel;

//Signup
//http://192.168.1.100/apps/tracmojo/web/api/forms/register.php
-(void)Email:(NSString *)email_id Password:(NSString*)password Mobile:(NSString*)mobile First_name:(NSString*)first_name Last_name:(NSString*)last_name Device_id:(NSString*)device_id Device_type:(NSString *)device_type selector:(SEL)sel;


//Social Check
//http://192.168.1.100/apps/tracmojo/web/api/forms/checksocialid.php
-(void)Media_Type:(NSString *)social_media_type UserID:(NSString*)uid Device_id:(NSString*)device_id Device_type:(NSString *)device_type selector:(SEL)sel;


//Privacy Policy
//http://192.168.1.100/apps/tracmojo/web/api/forms/getcmsdetails.php
-(void)Title:(NSString*)title selector:(SEL)sel;


//forget Passsword
//http://192.168.1.100/apps/tracmojo/web/api/forms/forgotpassword.php
-(void)Email_id:(NSString*)email_id selector:(SEL)sel;



//http://192.168.1.100/apps/tracmojo/web/api/forms/getpendinginvitation.php
-(void)Invitation_User_id:(NSString*)user_id selector:(SEL)sel;

-(void)Invitation_User:(NSString*)user_id invite_code:(NSString*)invite_code selector:(SEL)sel;
-(void)Infomation_title:(NSString*)title selector:(SEL)sel;

-(void)addsponsoredtrac:(NSString*)user_id invite_code:(NSString*)invite_code isflag:(BOOL)isflag selector:(SEL)sel;

//Get data while add Trac
-(void)Get_data_whileaddTrac_userid:(NSString*)user_id selector:(SEL)sel;


-(void)DashboardPersonalTrac_Useid:(NSString *)userid Loadmore:(NSString*)loadmore PageIndex:(NSString*)pageindex ishome:(BOOL)ishome selector:(SEL)sel;
-(void)DashboardgroupTrac_Useid:(NSString *)userid Loadmore:(NSString*)loadmore PageIndex:(NSString*)pageindex ishome:(BOOL)ishome selector:(SEL)sel;
-(void)DashboardfollowedTrac_Useid:(NSString *)userid Loadmore:(NSString*)loadmore PageIndex:(NSString*)pageindex ishome:(BOOL)ishome selector:(SEL)sel;
-(void)DashboardAlltracTrac_Useid:(NSString *)userid Loadmore:(NSString*)loadmore PageIndex:(NSString*)pageindex ishome:(BOOL)ishome selector:(SEL)sel;

#pragma Add Trac

-(void)addPersonalTrac_p_userId:(NSString*)userid gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails:(NSMutableArray*)p_invited_emails invited_names:(NSMutableArray*)p_invited_name selector:(SEL)sel;


-(void)addgroup:(NSString*)userid name:(NSString *)name gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails_participants:(NSMutableArray*)p_invited_emails_participants invited_emails_followers:(NSMutableArray*)p_invited_emails_followers invited_namesf:(NSMutableArray*)invited_namesf invited_namesp:(NSMutableArray*)invited_namesp  selector:(SEL)sel;

#pragma  Add rate


-(void)AddFollowers:(NSString *)userid trac_id:(NSString*)p_trac_id emails:(NSMutableArray*)emails names:(NSMutableArray*)names selector:(SEL)sel;


-(void)Addrate:(NSString *)userid trac_id:(NSString*)p_trac_id rate:(NSString*)p_rate isCheck:(BOOL)iscke selector:(SEL)sel;


#pragma  Edit trac

-(void)GettracDetail_user_id:(NSString *)userid trac_id:(NSString*)p_trac_id selector:(SEL)sel;
-(void)detailstrac:(NSString*)userid tracid:(NSString *)tracid selector:(SEL)sel;
-(void)UpdatePersonalTrac_p_userId:(NSString*)userid gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails:(NSMutableArray*)p_invited_emails trac_id:(NSString*)trac_id selector:(SEL)sel;

-(void)Updategroup:(NSString*)userid name:(NSString *)name gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails_participants:(NSMutableArray*)p_invited_emails_participants invited_emails_followers:(NSMutableArray*)p_invited_emails_followers trac_id:(NSString*)trac_id selector:(SEL)sel;


#pragma followed 


-(void)commentsinmail:(NSString*)user_id tracid:(NSString *)trac_id email:(NSString *)email selector:(SEL)sel;

-(void)followed_user_id:(NSString*)user_id trac_id:(NSString*)trac_id invitation_type:(NSString*)invitation_type action_chosen:(NSString*)action_chosen selector:(SEL)sel;

#pragma Participated


#pragma Delete
//-(void)AddParticipants:(NSString *)userid trac_id:(NSString*)p_trac_id emails:(NSMutableArray*)emails names:(NSMutableArray*)names selector:(SEL)sel;

-(void)AddParticipants:(NSString *)userid trac_id:(NSString*)p_trac_id emails:(NSMutableArray*)emails iseowner:(NSString *)iseowner names:(NSMutableArray*)names selector:(SEL)sel;



-(void)deletetrac:(NSString*)userid tracid:(NSString *)tracid selector:(SEL)sel;

#pragma Sync

-(void)dataSync:(NSString*)userid timestamp:(NSString *)timestamp selector:(SEL)sel;

#pragma Comment
-(void)getcomments:(NSString*)userid tracid:(NSString *)tracid pager:(NSString *)pager selector:(SEL)sel;
-(void)addcomment:(NSString*)userid tracid:(NSString *)tracid text:(NSString *)text ischeck:(BOOL)ischeck ischeck2:(BOOL)ischeck2  selector:(SEL)sel;


#pragma Message
-(void)sendPushnotification_user_id:(NSString*)user_id tracid:(NSString *)trac_id message:(NSString *)send_msg send_to:(NSString *)send_to selector:(SEL)sel;

-(void)sendEmail_user_id:(NSString*)user_id tracid:(NSString *)trac_id message:(NSString *)send_msg send_to:(NSString *)send_to selector:(SEL)sel;


@end
