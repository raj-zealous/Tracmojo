//
//  PrivacyTerms.h
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DarckWaitView.h"


@interface PrivacyTerms : UIViewController<UIWebViewDelegate>
{
    DarckWaitView *drk;

}
@property (strong, nonatomic) IBOutlet UIWebView *webVIEW;
@property (strong, nonatomic) NSString *strUserID;

@property (readwrite, nonatomic) BOOL Is_from_terms;



@end
