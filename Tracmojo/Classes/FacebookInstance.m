//
//  FacebookInstance.m
//  Oath
//
//  Created by LuanVo on 12/4/13.
//  Copyright (c) 2013 TriHPM. All rights reserved.
//

#import "FacebookInstance.h"

@implementation FacebookInstance

+ (void)hasCreatedToken {

    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"user_friends", @"email",@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      }];
    }
}

+ (void)openReadSessionAllowLoginUI:(BOOL)isAllowed
                     completedBlock:(void (^)(FBSession *session,
                                                FBSessionState state, NSError *error))callBackBlock
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen ||
        FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
    {
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
//        callBackBlock(FBSession.activeSession, FBSession.activeSession.state, nil);
    }
    else
    {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"public_profile", @"email",@"basic_info", nil];

        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:isAllowed
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error)
        {
            callBackBlock(session, state, error);
        }];
    }
}

+ (void)openPublishSessionWithCompletedBlock:(void (^)(FBSession *session,
                                                       FBSessionState state, NSError *error))callBackBlock
{
//    NSArray *permissions = @[@"publish_stream", @"user_friends", @"publish_actions",@"email",@"user_birthday",@"basic_info",@"user_hometown",@"user_location",];
//    NSArray *permissions = @[@"publish_stream", @"user_friends", @"publish_actions",@"email",@"basic_info"];
    
    NSArray *permissions = @[@"user_friends", @"email",@"basic_info"];
    
    [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
         callBackBlock(session, status, error);
     }];
}

+ (void)logOut
{
    // Clear this token
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
