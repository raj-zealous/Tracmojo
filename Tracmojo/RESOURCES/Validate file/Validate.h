//
//  Validate.h
//  ValidationCode
//
//  Created by Triforce consultancy on 21/01/12.
//  Copyright 2012 Triforce consultancy . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Validate : NSObject {
BOOL isInternet;
}
+ (BOOL) isPasswordValid:(NSString *)pwd;
+ (BOOL) isEmpty:(NSString *) candidate;
+ (BOOL) isValidEmailAddress:(NSString *) candidate;
+ (BOOL) isAlphabetsOnly:(NSString *) candidate;
+ (BOOL) isNumbersOnly:(NSString *) candidate;
+ (BOOL) isAlphaNumeric:(NSString *) candidate;
+ (BOOL) lenghtVaidation:(NSString *) candidate withMinSize:(NSInteger)minSize andMaxSize:(NSInteger)maxSize;
+ (BOOL) isValidURL:(NSString *) candidate;
+ (BOOL) isValidPhoneNumber:(NSString *) candidate;
+ (BOOL) isValidCard:(NSString *) candidate;
+(BOOL)isConnectedToNetwork2;
+ (BOOL) isBankCSVCodeValid:(NSString *)pwd;
+ (BOOL) isValidPattern:(NSString *) candidate;
+ (BOOL)isConnectedToNetwork;

@end

