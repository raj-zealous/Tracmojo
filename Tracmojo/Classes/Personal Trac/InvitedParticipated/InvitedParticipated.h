//
//  InvitedParticipated.h
//  Tracmojo
//
//  Created by macmini3 on 09/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitedParticipated : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    
    IBOutlet UIView *view_invite;
    
    IBOutlet UIImageView *track_bg;
    IBOutlet TPKeyboardAvoidingScrollView *scroll_invite;
    IBOutlet UITextField *txt_showtitel;
    IBOutlet UITableView *table_invitelist;
     IBOutlet UIButton *btnCheck;
    IBOutlet UILabel *lbl_title,*lblO;
    
    NSMutableArray *contactArray;
    IBOutlet UIButton *btn_invitecontact;
    IBOutlet UILabel *lbl_invitecount,*lbl_Add,*lbl_personal,*lbl_nofollower,*lbl_invitefollower,*lbl_mostfollower;
}

@property(strong,nonatomic)IBOutlet UIButton *btnBack;
@property(strong,nonatomic)IBOutlet UIButton *btnNext;
@property(strong,nonatomic)IBOutlet UIView *mailview;
@property(nonatomic,retain) NSString *str_add,*str_title;

-(IBAction)btncheck:(id)sender;

@end
