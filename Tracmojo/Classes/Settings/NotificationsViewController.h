//
//  NotificationsViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface NotificationsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain) IBOutlet UITableView *tbl_obj;
@property(nonatomic,retain) IBOutlet TPKeyboardAvoidingScrollView *scrl_obj;
@property(nonatomic,retain) IBOutlet UITextField *txtfld_time;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableviewHightConts;



-(IBAction) btnback:(id)sender;
@end
