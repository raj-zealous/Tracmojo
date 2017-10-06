//
//  InvitedParticipated.h
//  Tracmojo
//
//  Created by macmini3 on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitedFollowers : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    
    IBOutlet UIView *view_invite;
    IBOutlet TPKeyboardAvoidingScrollView *scroll_invite;
    IBOutlet UITextField *txt_showtitel;
    IBOutlet UITableView *table_invitelist;
   
    IBOutlet UILabel *lbl_title;
    
    NSMutableArray *contactArray;
    IBOutlet UIButton *btn_invitecontact;
    IBOutlet UILabel *lbl_invitecount,*lbl_Add,*lbl_personal,*lbl_nofollower,*lbl_invitefollower,*lbl_mostfollower;
}

@property(strong,nonatomic)IBOutlet UIButton *btnBack;
@property(strong,nonatomic)IBOutlet UIButton *btnNext;
@property(strong,nonatomic)IBOutlet UIView *mailview;
@property(nonatomic,retain) NSString *str_add,*str_title;
@end
