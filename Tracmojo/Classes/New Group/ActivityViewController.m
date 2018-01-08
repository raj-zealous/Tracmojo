//
//  ActivityViewController.m
//  Tracmojo
//
//  Created by Kuldipsinh Gadhavi on 03/01/18.
//  Copyright © 2018 peerbits. All rights reserved.
//

#import "ActivityViewController.h"
#import "Validate.h"
#import "HelpViewController.h"
#import "SettingsViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    - (IBAction)btnClickSettings:(id)sender {
        
        SettingsViewController *vc = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:true];
    }
-(IBAction)help:(id)sender
    {
        
        if ([Validate isConnectedToNetwork])
        {
            [DELEGATE hidePopup];
            HelpViewController *help_obj=[[HelpViewController alloc]init];
            [self.navigationController pushViewController:help_obj animated:YES];
        }
        
    }


@end
