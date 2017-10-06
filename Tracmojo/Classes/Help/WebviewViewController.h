//
//  WebviewViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewViewController : UIViewController


@property(nonatomic,retain) IBOutlet UILabel *lbl_header;
@property (strong, nonatomic) IBOutlet UIWebView *webv;
@property(nonatomic,retain) NSString *str;

-(IBAction)back:(id)sender;
@end
