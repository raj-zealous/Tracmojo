//
//  FacebookInstance.h
//  Oath
//
//  Created by LuanVo on 12/4/13.
//  Copyright (c) 2013 TriHPM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookInstance : NSObject

+ (void)hasCreatedToken;

+ (void)openReadSessionAllowLoginUI:(BOOL)isAllowed
                     completedBlock:(void (^)(FBSession *session,
                                              FBSessionState state, NSError *error))callBackBlock;

+ (void)openPublishSessionWithCompletedBlock:(void (^)(FBSession *session,
                                                FBSessionState state, NSError *error))callBackBlock;

+ (void)logOut;

@end
