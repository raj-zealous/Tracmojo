//
//  PrivacyTerms.m
//  Tracmojo
//
//  Created by macmini3 on 25/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "PrivacyTerms.h"
#import "Validate.h"
#import "ModelClass.h" 

@interface PrivacyTerms ()

@end

@implementation PrivacyTerms
{
    ModelClass *mc;
}
- (void)viewDidLoad
{
    drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];

    if(self.Is_from_terms == true){
        
        NSString *urlAddress = @"http://www.tracmojo.com/terms-of-use/";
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        //Load the request in the UIWebView.
        [_webVIEW loadRequest:requestObj];
       
    }
    else{
    
        mc=[[ModelClass alloc]init];
        mc.delegate=self;
        
        if ([Validate isConnectedToNetwork])
        {
            [mc Title:@"privacy" selector:@selector(privacytrmsClicked:)];
        }

       
    
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)privacytrmsClicked:(NSMutableDictionary *)result
{
   
    NSString *fullURL = [NSString stringWithFormat:@"%@",[result valueForKey:@"content"]];
    [_webVIEW loadHTMLString:fullURL baseURL:nil];
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [drk showWithMessage:nil];

    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [drk hide];
    

    NSLog(@"finish");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [drk hide];
    
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}

- (IBAction)btnBackClicked:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
