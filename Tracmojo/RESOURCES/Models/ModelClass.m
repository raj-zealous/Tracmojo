
//
//  ModelClass.m
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 MyCompanyName. All rights reserved.
//

#import "ModelClass.h"
#import "SBJson.h"
@implementation ModelClass{
    
}

@synthesize delegate = _delegate;
@synthesize success;


- (id)init
{
    self = [super init];
    if (self) {
        success=NO;
        drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
        
    }
    
    return self;
}


-(void)detailstrac:(NSString*)userid tracid:(NSString *)tracid selector:(SEL)sel
{
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",tracid] forKey:@"trac_id"];
    
    //    [requestDictionary setObject:@"y" forKey:@"israndom"];
    
    
    URL = [[NSString stringWithFormat:@"%@user/gettracdetails/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    [self postData:requestDictionary];
    
    
    
  
}

//
//-(void)login:(NSString *)email pass:(NSString*)pass selector:(SEL)sel
//{
//    [drk showWithMessage:nil];
//    responseselector = sel;
//    
//    //device ID
//    NSString *str_zipcode=[NSString stringWithFormat:@"%@",email];
//    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
//    URL = [[NSString stringWithFormat:@"https://appcheck.pfcloud.net/FindRDS.asp?postalCode=%@",str_zipcode]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [self postData:requestDictionary];
//    
//}

-(void)myprofile:(NSString*)user_id selector:(SEL)sel
{
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/getprofile/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
}

-(void)editprofile:(NSString*)user_id email_id:(NSString *)email sec_emailid:(NSString *)secid name1:(NSString *)name1 name2:(NSString *)name2 Mobile:(NSString *)mobile password:(NSString *)password current:(NSString *)current selector:(SEL)sel
{
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    
    //          [requestDictionary setObject:[NSString stringWithFormat:@"%@",email] forKey:@"email_id"];
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",secid] forKey:@"secondary_email_id"];
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",name1] forKey:@"first_name"];
    
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",name2] forKey:@"last_name"];
    
    
    if ([password length]>0 ) {
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",password] forKey:@"password"];
        [requestDictionary setObject:current forKey:@"current_password"];
        
        
    }
    
    
    
    
    if ([mobile length]>0 ) {
        
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",mobile] forKey:@"mobile"];
        
        
    }
    
    
    
    
    
    URL = [[NSString stringWithFormat:@"%@user/updateprofile/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
    
    
}
-(void)getsettings:(NSString *)userid selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    
    
    URL = [[NSString stringWithFormat:@"%@user/getsetting/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
}

-(void)setsettingsfortime:(NSString *)userid notification_preferred_time:(NSString*)notification_preferred_time value:(NSString*)value selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",notification_preferred_time] forKey:@"notification_type"];
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",value] forKey:@"value"];
    
    URL = [[NSString stringWithFormat:@"%@user/setsetting/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
}

-(void)setsettings:(NSString *)userid notification_type:(NSString*)notification_type value:(NSString*)value selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",notification_type] forKey:@"notification_type"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",value] forKey:@"value"];
    
    URL = [[NSString stringWithFormat:@"%@user/setsetting/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
}


-(void)webpages:(NSString*)title selector:(SEL)sel{
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",title] forKey:@"title"];
    
    URL = [[NSString stringWithFormat:@"%@user/getcmsdetails/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
    
}

-(void)Social_Media_Type:(NSString *)social_media_type UuserID:(NSString *)userid Email_id:(NSString *)email_id first_name:(NSString *)first_name last_name:(NSString *)last_name Device_id:(NSString *)device_id Device_type:(NSString *)device_type Sel:(SEL)sel
{
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:social_media_type forKey:@"social_media_type"];
    [requestDisc setValue:userid forKey:@"id"];
    [requestDisc setValue:email_id forKey:@"email_id"];
    [requestDisc setValue:first_name forKey:@"first_name"];
    [requestDisc setValue:last_name forKey:@"last_name"];
    [requestDisc setValue:device_id forKey:@"device_id"];
    [requestDisc setValue:device_type forKey:@"device_type"];
    
    float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
  
    
    
    [requestDisc setValue:[NSString stringWithFormat:@"%f",timezoneoffset] forKey:@"timezone"];
    
    
    [requestDisc setValue:[NSString stringWithFormat:@"%@",tzName] forKey:@"timezone_string"];
    
    URL = [[NSString stringWithFormat:@"%@user/loginviasocial",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
    
}

-(void)login:(NSString *)email pass:(NSString*)pass device_id:(NSString*)device_id device_type:(NSString*)device_type selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:email forKey:@"email_id"];
    [requestDisc setValue:pass forKey:@"password"];
    [requestDisc setValue:device_id forKey:@"device_id"];
    [requestDisc setValue:device_type forKey:@"device_type"];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    
    float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
    [requestDisc setValue:[NSString stringWithFormat:@"%f",timezoneoffset] forKey:@"timezone"];
    
    [requestDisc setValue:[NSString stringWithFormat:@"%@",tzName] forKey:@"timezone_string"];
    
    
    URL = [[NSString stringWithFormat:@"%@user/login",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  ////NSLog(@"Url =%@",URL);
    [self postData:requestDisc];
    
}

-(void)Email:(NSString *)email_id Password:(NSString*)password Mobile:(NSString*)mobile First_name:(NSString*)first_name Last_name:(NSString*)last_name Device_id:(NSString*)device_id Device_type:(NSString *)device_type selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:email_id forKey:@"email_id"];
    [requestDisc setValue:password forKey:@"password"];
    [requestDisc setValue:first_name forKey:@"first_name"];
    [requestDisc setValue:last_name forKey:@"last_name"];
    [requestDisc setValue:mobile forKey:@"mobile"];
    [requestDisc setValue:device_id forKey:@"device_id"];
    [requestDisc setValue:device_type forKey:@"device_type"];
    NSLog(@"%ld",(long)[[NSTimeZone systemTimeZone] secondsFromGMT]);
    
    
    float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
  
    [requestDisc setValue:[NSString stringWithFormat:@"%f",timezoneoffset] forKey:@"timezone"];
    [requestDisc setValue:[NSString stringWithFormat:@"%@",tzName] forKey:@"timezone_string"];
    
    URL = [[NSString stringWithFormat:@"%@user/register",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  ////NSLog(@"Url =%@",URL);
  
    NSLog(@"post dictionary is %@",requestDisc);
    [self postData:requestDisc];
}


-(void)Media_Type:(NSString *)social_media_type UserID:(NSString*)uid Device_id:(NSString*)device_id Device_type:(NSString *)device_type selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    
    float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
    
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:social_media_type forKey:@"social_media_type"];
    [requestDisc setValue:uid forKey:@"id"];
    [requestDisc setValue:device_id forKey:@"device_id"];
    [requestDisc setValue:device_type forKey:@"device_type"];
    [requestDisc setValue:[NSString stringWithFormat:@"%f",timezoneoffset] forKey:@"timezone"];
    
    [requestDisc setValue:[NSString stringWithFormat:@"%@",tzName] forKey:@"timezone_string"];

    URL = [[NSString stringWithFormat:@"%@user/checksocialid",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
    
}


-(void)Title:(NSString*)title selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:title forKey:@"title"];
    
    URL = [[NSString stringWithFormat:@"%@user/getcmsdetails",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
}

-(void)Invitation_User_id:(NSString*)user_id selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:user_id forKey:@"user_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/getpendinginvitation",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
    
}

-(void)Invitation_User:(NSString*)user_id invite_code:(NSString*)invite_code selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:user_id forKey:@"user_id"];
    [requestDisc setValue:invite_code forKey:@"invite_code"];
    
    URL = [[NSString stringWithFormat:@"%@user/confirmsponsoredtrac",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
    
}

-(void)Infomation_title:(NSString*)title selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:title forKey:@"title"];
    
    URL = [[NSString stringWithFormat:@"%@user/getcmsdetails",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
}

-(void)addsponsoredtrac:(NSString*)user_id invite_code:(NSString*)invite_code isflag:(BOOL)isflag selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:user_id forKey:@"user_id"];
    [requestDisc setValue:invite_code forKey:@"invite_code"];
    
    if (isflag) {
        [requestDisc setObject:@"1" forKey:@"flag"];
    }
    
    URL = [[NSString stringWithFormat:@"%@user/addsponsoredtrac",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDisc];
}

-(void)Email_id:(NSString*)email_id selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector=sel;
    NSMutableDictionary *requestDisc=[NSMutableDictionary new];
    [requestDisc setValue:email_id forKey:@"email_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/forgotpassword",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  ////NSLog(@"Url =%@",URL);
    [self postData:requestDisc];
    
}


-(void)DashboardPersonalTrac_Useid:(NSString *)userid Loadmore:(NSString *)loadmore PageIndex:(NSString *)pageindex ishome:(BOOL)ishome selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",loadmore] forKey:@"load_more"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",pageindex] forKey:@"page"];
    
    if (ishome) {
        [requestDictionary setObject:@"y" forKey:@"is_home"];
    }
    
    URL = [[NSString stringWithFormat:@"%@user/gettraclist/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self postData:requestDictionary];
    
}


-(void)DashboardfollowedTrac_Useid:(NSString *)userid Loadmore:(NSString *)loadmore PageIndex:(NSString *)pageindex ishome:(BOOL)ishome selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",loadmore] forKey:@"load_more"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",pageindex] forKey:@"page"];
    
    
    
    if (ishome) {
        [requestDictionary setObject:@"y" forKey:@"is_home"];
    }
    
    URL = [[NSString stringWithFormat:@"%@user/gettraclist/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
}



-(void)DashboardgroupTrac_Useid:(NSString *)userid Loadmore:(NSString *)loadmore PageIndex:(NSString *)pageindex ishome:(BOOL)ishome selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",loadmore] forKey:@"load_more"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",pageindex] forKey:@"page"];
    if (ishome) {
        [requestDictionary setObject:@"y" forKey:@"is_home"];
    }
    
    URL = [[NSString stringWithFormat:@"%@user/gettraclist/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
}


-(void)DashboardAlltracTrac_Useid:(NSString *)userid Loadmore:(NSString*)loadmore PageIndex:(NSString*)pageindex ishome:(BOOL)ishome selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",loadmore] forKey:@"load_more"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",pageindex] forKey:@"page"];
        // [requestDictionary setObject:@"y" forKey:@"is_home"];
    if (ishome) {
        [requestDictionary setObject:@"y" forKey:@"is_home"];
    }
    URL = [[NSString stringWithFormat:@"%@user/gettraclist/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
}

-(void)Get_data_whileaddTrac_userid:(NSString*)user_id selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    URL = [[NSString stringWithFormat:@"%@user/getdatawhileaddtrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
}

-(void)addfollowercomment:(NSString*)userid tracid:(NSString *)tracid text:(NSString *)text selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",tracid] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",text] forKey:@"comment"];

    
    URL = [[NSString stringWithFormat:@"%@user/addfollowercomment",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}


#pragma invite code
-(void)invite_users:(NSString *)userid
{
    [drk showWithMessage:nil];
    
    URL = [[NSString stringWithFormat:@"%@user//",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [self postData:requestDictionary];
}

#pragma Edit trac
-(void)GettracDetail_user_id:(NSString *)userid trac_id:(NSString *)p_trac_id selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_trac_id] forKey:@"trac_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/gettracdetails/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
}


-(void)UpdatePersonalTrac_p_userId:(NSString*)userid gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails:(NSMutableArray*)p_invited_emails trac_id:(NSString*)trac_id selector:(SEL)sel
{
    
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_gole] forKey:@"goal"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_idea_id] forKey:@"idea_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rate_word_id] forKey:@"rate_word_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word1] forKey:@"cust_rate_word1"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word2] forKey:@"cust_rate_word2"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word3] forKey:@"cust_rate_word3"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word4] forKey:@"cust_rate_word4"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word5] forKey:@"cust_rate_word5"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_frequency] forKey:@"rating_frequency"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_day] forKey:@"rating_day"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_finish_date] forKey:@"finish_date"];
   // [requestDictionary setObject:[NSString stringWithFormat:@"%@",[p_invited_emails JSONRepresentation]] forKey:@"invited_emails"];
    NSString *str_em=[NSString stringWithFormat:@"%@",[p_invited_emails JSONRepresentation]];
    [requestDictionary setObject:str_em forKey:@"invited_emails"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/editpersonaltrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
    
}

-(void)Updategroup:(NSString*)userid name:(NSString *)name gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails_participants:(NSMutableArray*)p_invited_emails_participants invited_emails_followers:(NSMutableArray*)p_invited_emails_followers trac_id:(NSString*)trac_id selector:(SEL)sel
{

    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_gole] forKey:@"goal"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_idea_id] forKey:@"group_type_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",name] forKey:@"group_name"];
    
    
    if (p_rate_word_id.length<=0) {
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word1] forKey:@"cust_rate_word1"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word2] forKey:@"cust_rate_word2"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word3] forKey:@"cust_rate_word3"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word4] forKey:@"cust_rate_word4"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word5] forKey:@"cust_rate_word5"];
        
    }
    else{
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rate_word_id] forKey:@"rate_word_id"];
    }
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_frequency] forKey:@"rating_frequency"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_day] forKey:@"rating_day"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_finish_date] forKey:@"finish_date"];
   // [requestDictionary setObject:[NSString stringWithFormat:@"%@",[p_invited_emails JSONRepresentation]] forKey:@"invited_emails"];
    NSString *str_em=[NSString stringWithFormat:@"%@",[p_invited_emails_participants JSONRepresentation]];
    NSString *str_followers=[NSString stringWithFormat:@"%@",[p_invited_emails_followers JSONRepresentation]];
    [requestDictionary setObject:str_em forKey:@"participated_emails"];
    [requestDictionary setObject:str_followers forKey:@"invited_emails"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    if (DELEGATE.isOwnerP) {
        [requestDictionary setObject:@"y" forKey:@"is_owner_participant"];
    }
    else{
        [requestDictionary setObject:@"n" forKey:@"is_owner_participant"];
    }

    URL = [[NSString stringWithFormat:@"%@user/editgrouptrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
}


#pragma Add trac

-(void)addPersonalTrac_p_userId:(NSString*)userid gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails:(NSMutableArray*)p_invited_emails invited_names:(NSMutableArray*)p_invited_name selector:(SEL)sel
{
    
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_gole] forKey:@"goal"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_idea_id] forKey:@"idea_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rate_word_id] forKey:@"rate_word_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word1] forKey:@"cust_rate_word1"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word2] forKey:@"cust_rate_word2"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word3] forKey:@"cust_rate_word3"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word4] forKey:@"cust_rate_word4"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word5] forKey:@"cust_rate_word5"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_frequency ] forKey:@"rating_frequency"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_day] forKey:@"rating_day"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_finish_date] forKey:@"finish_date"];
    
    NSString *str_em=[NSString stringWithFormat:@"%@",[p_invited_emails JSONRepresentation]];
    [requestDictionary setObject:str_em forKey:@"invited_emails"];
   
    
    NSString *str_em1=[NSString stringWithFormat:@"%@",[p_invited_name JSONRepresentation]];
    [requestDictionary setObject:str_em1 forKey:@"invited_names"];
   
    
    URL = [[NSString stringWithFormat:@"%@user/addpersonaltrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
}


-(void)addgroup:(NSString*)userid name:(NSString *)name gole:(NSString*)p_gole idea_id:(NSString*)p_idea_id rate_word_id:(NSString*)p_rate_word_id cust_rate_word1:(NSString*)p_cust_rate_word1 cust_rate_word2:(NSString*)p_cust_rate_word2 cust_rate_word3:(NSString*)p_cust_rate_word3 cust_rate_word4:(NSString*)p_cust_rate_word4 cust_rate_word5:(NSString*)p_cust_rate_word5 rating_frequency:(NSString*)p_rating_frequency rating_day:(NSString*)p_rating_day finish_date:(NSString*)p_finish_date invited_emails_participants:(NSMutableArray*)p_invited_emails_participants invited_emails_followers:(NSMutableArray*)p_invited_emails_followers invited_namesf:(NSMutableArray*)invited_namesf invited_namesp:(NSMutableArray*)invited_namesp  selector:(SEL)sel
{
    
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_gole] forKey:@"goal"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_idea_id] forKey:@"group_type_id"];
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",name] forKey:@"group_name"];
    
    
    if (p_rate_word_id.length<=0) {
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word1] forKey:@"cust_rate_word1"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word2] forKey:@"cust_rate_word2"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word3] forKey:@"cust_rate_word3"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word4] forKey:@"cust_rate_word4"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_cust_rate_word5] forKey:@"cust_rate_word5"];
   
    }
    else{
          [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rate_word_id] forKey:@"rate_word_id"];
    }
  
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_frequency] forKey:@"rating_frequency"];
    
    if (![p_rating_day isEqualToString:@""]) {
           [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rating_day] forKey:@"rating_day"];
    }
    
    if (DELEGATE.isOwnerP) {
     [requestDictionary setObject:@"y" forKey:@"is_owner_participant"];
        
    }
    else{
      [requestDictionary setObject:@"n" forKey:@"is_owner_participant"];
    }
    
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_finish_date] forKey:@"finish_date"];
    
//    NSString *str_em=[NSString stringWithFormat:@"%@",[p_invited_emails_participants JSONRepresentation]];
    [requestDictionary setObject:[p_invited_emails_participants JSONRepresentation] forKey:@"participated_emails"];
    NSString *str_followers=[NSString stringWithFormat:@"%@",[p_invited_emails_followers JSONRepresentation]];
    [requestDictionary setObject:str_followers forKey:@"invited_emails"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",[invited_namesp JSONRepresentation]] forKey:@"participated_names"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",[invited_namesf JSONRepresentation]] forKey:@"invited_names"];
    

 //   str_em=[str_em stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    URL = [[NSString stringWithFormat:@"%@user/addgrouptrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
}


-(void)AddParticipants:(NSString *)userid trac_id:(NSString*)p_trac_id emails:(NSMutableArray*)emails iseowner:(NSString *)iseowner names:(NSMutableArray*)names selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_trac_id] forKey:@"trac_id"];
    
    NSString *str_em=[NSString stringWithFormat:@"%@",[emails JSONRepresentation]];
    NSString *str_em2=[NSString stringWithFormat:@"%@",[names JSONRepresentation]];
    
    [requestDictionary setObject:str_em forKey:@"participated_names"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",str_em2] forKey:@"participated_emails"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",iseowner] forKey:@"is_owner_participant"];
    
    URL = [[NSString stringWithFormat:@"%@user/addparticipants/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
    
    
    
}



-(void)AddFollowers:(NSString *)userid trac_id:(NSString*)p_trac_id emails:(NSMutableArray*)emails names:(NSMutableArray*)names selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_trac_id] forKey:@"trac_id"];
    
     NSString *str_em=[NSString stringWithFormat:@"%@",[emails JSONRepresentation]];
     NSString *str_em2=[NSString stringWithFormat:@"%@",[names JSONRepresentation]];

    [requestDictionary setObject:str_em forKey:@"invited_emails"];
    [requestDictionary setObject:str_em2 forKey:@"invited_names"];
    
    URL = [[NSString stringWithFormat:@"%@user/addfollowers/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
}

-(void)Addrate:(NSString *)userid trac_id:(NSString*)p_trac_id rate:(NSString*)p_rate isCheck:(BOOL)iscke selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_trac_id] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",p_rate] forKey:@"rate"];
    
    URL = [[NSString stringWithFormat:@"%@user/addrate/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
    
    
}


-(void)logoutapi:(NSString*)userid selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    
    URL = [[NSString stringWithFormat:@"%@user/logout/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postData:requestDictionary];
}

#pragma Delete

-(void)deletetrac:(NSString*)userid tracid:(NSString *)tracid selector:(SEL)sel
{
    
    
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",tracid] forKey:@"trac_id"];
    URL = [[NSString stringWithFormat:@"%@user/deletetrac/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}

#pragma Followed
-(void)followed_user_id:(NSString*)user_id trac_id:(NSString*)trac_id invitation_type:(NSString*)invitation_type action_chosen:(NSString*)action_chosen selector:(SEL)sel
{
 
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",invitation_type] forKey:@"invitation_type"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",action_chosen] forKey:@"action_chosen"];
    
    URL = [[NSString stringWithFormat:@"%@user/respondtracinvitation/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self postData:requestDictionary];
}

#pragma Comment

-(void)getcomments:(NSString*)userid tracid:(NSString *)tracid pager:(NSString *)pager selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",tracid] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",pager] forKey:@"page"];
    
    URL = [[NSString stringWithFormat:@"%@user/getcommentlist/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}
            
            
-(void)addcomment:(NSString*)userid tracid:(NSString *)tracid text:(NSString *)text ischeck:(BOOL)ischeck ischeck2:(BOOL)ischeck2  selector:(SEL)sel
{
        [drk showWithMessage:nil];
        responseselector = sel;
        NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",tracid] forKey:@"trac_id"];
        [requestDictionary setObject:[NSString stringWithFormat:@"%@",text] forKey:@"comment"];
    
    if (ischeck) {
          [requestDictionary setObject:@"y" forKey:@"is_anonymous"];
    }
    else{
         [requestDictionary setObject:@"n" forKey:@"is_anonymous"];
    }
    
    if (ischeck2) {
        [requestDictionary setObject:@"y" forKey:@"for_admin_only"];
    }
    else{
        [requestDictionary setObject:@"n" forKey:@"for_admin_only"];
    }
    
        URL = [[NSString stringWithFormat:@"%@user/addcomment/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
        [self postData:requestDictionary];
}


#pragma Message

-(void)sendPushnotification_user_id:(NSString*)user_id tracid:(NSString *)trac_id message:(NSString *)send_msg send_to:(NSString *)send_to selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",send_msg] forKey:@"message"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",send_to] forKey:@"send_to"];
    
    URL = [[NSString stringWithFormat:@"%@user/sendpushtocontact/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //NSLog(@"??????????%@",requestDictionary);
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}


-(void)commentsinmail:(NSString*)user_id tracid:(NSString *)trac_id email:(NSString *)email selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",email] forKey:@"email_id"];

    
    URL = [[NSString stringWithFormat:@"%@user/sendcomments/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}


-(void)sendEmail_user_id:(NSString*)user_id tracid:(NSString *)trac_id message:(NSString *)send_msg send_to:(NSString *)send_to selector:(SEL)sel
{
    [drk showWithMessage:nil];
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",trac_id] forKey:@"trac_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",send_msg] forKey:@"message"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",send_to] forKey:@"send_to"];
    
    URL = [[NSString stringWithFormat:@"%@user/sendemailtocontact/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}


#pragma Offline

-(void)dataSync:(NSString*)userid timestamp:(NSString *)timestamp selector:(SEL)sel
{
    responseselector = sel;
    NSMutableDictionary *requestDictionary = [NSMutableDictionary new];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",userid] forKey:@"user_id"];
    [requestDictionary setObject:[NSString stringWithFormat:@"%@",timestamp] forKey:@"timestamp"];
    
    URL = [[NSString stringWithFormat:@"%@user/syncofflinedata/",API_PATH]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL=@"http://www.genbook.com/bookings/slot/reservation/30174794";
    [self postData:requestDictionary];
}

-(void)postData:(NSMutableDictionary *)postdatadictionary {
    
    NSLog(@"%@",postdatadictionary);
    NSLog(@"%@",URL);
    
    AFHTTPRequestOperationManager *operationmanager = [AFHTTPRequestOperationManager manager];
    operationmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationmanager.responseSerializer.acceptableContentTypes = [operationmanager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [operationmanager POST:URL parameters: postdatadictionary    success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [drk hide];
        
        NSDictionary *responsedictionary = (NSDictionary *)responseObject;
        
        if ([[[responsedictionary objectForKey:@"Trac"] objectForKey:@"i_by_name"] isEqualToString:@"Me"]) {
       
        }
        
        [drk hide];
        [self.delegate performSelector:responseselector withObject:responsedictionary afterDelay:0.0];
        
        
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      //  hideIndicator();
        
                [drk hide];
        NSString *str = [operation responseString];
        
        
        /* NSMutableDictionary *responsedictionary = [[NSMutableDictionary alloc] init];
         
         [responsedictionary setValue:@"false" forKey:@"successful"];
         [responsedictionary setValue:@"Api calling fail" forKey:@"message"];*/
   //     hideIndicator();
        [self.delegate performSelector:responseselector withObject:[operation responseObject]];
        
        ////NSLog(@"\n\n +++++>> Response String : %@",str);
    }];
}



@end

