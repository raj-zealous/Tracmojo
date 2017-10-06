//
//  PersonalTracs.h
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"


@interface PersonalTracs : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    ModelClass *mc;
    
    //form
    IBOutlet TPKeyboardAvoidingScrollView *scrollview;
    IBOutlet UIView *objviewform;
    IBOutlet UITextField *txt_trac;
    IBOutlet UITextField *txt_ratewording;
    
    IBOutlet UITextView *txt_tracdetail;
    IBOutlet UITextField *txt_rate5;
    IBOutlet UITextField *txt_rate4;
    IBOutlet UITextField *txt_rate3;
    IBOutlet UITextField *txt_rate2;
    IBOutlet UITextField *txt_rate1;
    
    //picker
    UIPickerView *pickerView_ratewording;
    UIPickerView *pickerView_trac;
}

@property(nonatomic,strong)NSString *trac_id;
@property(strong,nonatomic)IBOutlet UIButton *btnBack;
@property(strong,nonatomic)IBOutlet UIButton *btnNext;
@end
