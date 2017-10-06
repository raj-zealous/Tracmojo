//
//  CommentsViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 18/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface CommentsViewController : UIViewController
{
    IBOutlet UIButton *btn_cancel,*btncoment;
    IBOutlet UITextView *txtbox;
     IBOutlet UITextField *txt_message;
     IBOutlet UIScrollView *scroll_popup;
        IBOutlet UIButton *btn_Message;
     IBOutlet UIButton *btnTemp;
        IBOutlet UIButton *btnCheckbox,*btnCheckbox1;
    
}
@property(nonatomic,retain) IBOutlet UITableView *tbl_obj;
@property(nonatomic,retain) IBOutlet TPKeyboardAvoidingScrollView *scrl_obj;
@property(nonatomic,retain) IBOutlet UIButton *btn_send;
@property(nonatomic,retain) IBOutlet UITextView *txtv;
@property(nonatomic,retain) IBOutlet NSString *trac_id;
@property(nonatomic,retain) IBOutlet UIView *viewSendMail;
@property(nonatomic,retain) IBOutlet UIButton *btnCheck1,*b1,*b2;
@property(nonatomic,retain) IBOutlet UIButton *btnCheck2,*btnmail;
@property(nonatomic,retain) IBOutlet UITextField *txtdlsEmail;
@property(nonatomic,retain) IBOutlet UILabel *lbl1;
@property(nonatomic,retain) IBOutlet UILabel *lbl2;


@property(assign)BOOL isOwner;

-(IBAction)back:(id)sender;
-(IBAction)btnSend:(id)sender;
-(IBAction)btnCancel:(id)sender;
-(IBAction)addcomment:(id)sender;
-(IBAction)mailcomment:(id)sender;

@end
