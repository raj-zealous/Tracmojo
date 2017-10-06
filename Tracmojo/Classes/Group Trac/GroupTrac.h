//
//  GroupTrac.h
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface GroupTrac : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,retain) IBOutlet TPKeyboardAvoidingScrollView *scrl_obj;
@property(nonatomic,retain)IBOutlet UITextField *txt_trac;
@property(nonatomic,retain)IBOutlet UITextField *txt_ratewording;
@property(nonatomic,retain)IBOutlet UITextView *txt_tracdetail;
@property(nonatomic,retain)IBOutlet UITextField *txt_rate5,*txt_type;
@property(nonatomic,retain)IBOutlet UITextField *txt_rate4;
@property(nonatomic,retain)IBOutlet UITextField *txt_rate3;
@property(nonatomic,retain)IBOutlet UITextField *txt_rate2;
@property(nonatomic,retain)IBOutlet UITextField *txt_rate1;
  @property(nonatomic,retain)  IBOutlet UIView *objviewform;
@property(nonatomic,retain)IBOutlet UILabel *lbl_header,*lbl_reference,*lbl_rates,*lbl_type,*lbl_custom;
@property(assign) BOOL isback;
@property(nonatomic,strong)NSString *trac_id;

@end
