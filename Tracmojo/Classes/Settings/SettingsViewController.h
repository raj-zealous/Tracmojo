//
//  SettingsViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController


@property(nonatomic,retain) IBOutlet UITableView *tbl_obj;
@property(nonatomic,retain) IBOutlet UILabel *lbl_header;
@property(nonatomic,retain) IBOutlet UIView *popup;
@property(strong,nonatomic)IBOutlet UIButton *btnpersonaltrac;
@property(strong,nonatomic)IBOutlet UIButton *btngrouptrac;

-(IBAction)personaltrack:(id)sender;
-(IBAction)grouptrack:(id)sender;
-(IBAction)help:(id)sender;
@end
