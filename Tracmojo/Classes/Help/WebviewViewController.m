//
//  WebviewViewController.m
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "WebviewViewController.h"
#import "ModelClass.h"
#import "Validate.h"
@interface WebviewViewController ()

@end

@implementation WebviewViewController
{
    ModelClass *mc;
}

- (void)viewDidLoad {

    mc=[[ModelClass alloc]init];
    mc.delegate=self;
    
   // [self.webv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.1-on-1-coaching-call.genbook.com"]]];

    if ([_str isEqualToString:@"whatisit"]) {
        _lbl_header.text=@"What is it?";
    }
    if ([_str isEqualToString:@"why"]) {
        _lbl_header.text=@"Why?";
    }
    if ([_str isEqualToString:@"how"]) {
        _lbl_header.text=@"How?";
    }
    if ([Validate isConnectedToNetwork])
    {
    [mc webpages:_str selector:@selector(getphoto:)];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)getphoto:(NSDateFormatter *)result
{
    
    if ([[[result valueForKey:@"code"]stringValue] isEqualToString:@"200"])
        {
        _str=[[NSString alloc]initWithString:[result valueForKey:@"content"]];
        
        [self createWebViewWithHTML];
  
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alt show];
    }
}


    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createWebViewWithHTML
{
    
    
    [_webv loadHTMLString:[_str description] baseURL:nil];
    
}

-(IBAction)back:(id)sender
{
    [DELEGATE hidePopup];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
