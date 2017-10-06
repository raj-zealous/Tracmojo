//
//  setFrequncyViewController.h
//  Tracmojo
//
//  Created by macmini3 on 08/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setFrequncyViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    
    IBOutlet TPKeyboardAvoidingScrollView *scroll_frequncy;
    IBOutlet UIView *view_frequncy;
    IBOutlet UITextField *txt_showtitle;
    IBOutlet UITextField *txt_as;
    IBOutlet UITextField *txt_on;
    IBOutlet UITextField *txt_finishingon;
    UIPickerView *pickerView_as;
    UIPickerView *pickerView_on;
    UIPickerView *pickerView_finishing;
    UIDatePicker *datePicker;
}
@property(strong,nonatomic)IBOutlet UIButton *btnBack;
@property(strong,nonatomic)IBOutlet UIButton *btnNext;
@property(strong,nonatomic)IBOutlet UILabel *lbl_ref,*lblb;
@property(strong,nonatomic) NSString *str_ref_name,*str_tracname;



@property(strong,nonatomic)IBOutlet UILabel *lblOn;
@property(strong,nonatomic)IBOutlet UIImageView *imgv_bg,*imgv_move,*error2,*erro1;
@end
