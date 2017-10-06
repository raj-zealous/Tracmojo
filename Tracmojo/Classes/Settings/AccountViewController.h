//
//  AccountViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface AccountViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,retain) IBOutlet UILabel *lbl1,*lbl2,*phnlbl;

@property(nonatomic,retain) IBOutlet UIImageView *img1,*img2;
@property(nonatomic,retain) IBOutlet UIButton *send_btn;
@property(nonatomic,retain) IBOutlet TPKeyboardAvoidingScrollView *scrl_obj;
@property(nonatomic,retain) IBOutlet UITextField *txtfld_second,*txtfld_name1,*txtfld_name2,*txtfld_pass,*txtfld_phone,*txtfld_current,*txtCode;
@property(nonatomic,retain) IBOutlet UILabel *lbl_primary,*lbl_secondary;
-(IBAction) btnback:(id)sender;
-(IBAction) save:(id)sender;
- (IBAction)btnLogoutClicked:(id)sender;
@end
